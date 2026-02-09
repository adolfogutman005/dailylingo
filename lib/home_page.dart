import 'package:dailylingo/speaking_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'state/user_settings_state.dart';
import 'translator_service.dart';
import 'services/vocabulary_service.dart';
import 'language_codes.dart';
import 'config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // -------- SESSION STATE (TEMPORARY) --------
  late String currentSourceLang;
  late String currentTargetLang;
  late VocabularyService vocabularyService;

  String sourceText = "";
  String targetText = "";
  DateTime selectedDate = DateTime.now();

  Timer? _debounce;
  final translationService =
      TranslationService(apiKey: ApiKeys.deeplApiKey);

  final TextEditingController sourceController = TextEditingController();
  final TtsService ttsService = TtsService();

  @override
  void initState() {
    super.initState();

    // initialize from user defaults ONCE
    final userSettings = context.read<UserSettingsState>();
    currentSourceLang = userSettings.settings.sourceLang;
    currentTargetLang = userSettings.settings.targetLang;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize provider safely here (listen: true so widget rebuilds)
    vocabularyService = Provider.of<VocabularyService>(context, listen: true);
  }

  @override
  void dispose() {
    sourceController.dispose();
    _debounce?.cancel();
    super.dispose();
    ttsService.stop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _translatorSection(),
          const SizedBox(height: 20),
          _calendarStrip(),
          const SizedBox(height: 12),
          _dayInformation(),
        ],
      ),
    );
  }

  // ---------------- TRANSLATOR ----------------

  Widget _translatorSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontal = constraints.maxWidth > 700;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: horizontal
              ? Row(
                  children: [
                    Expanded(child: _translatorPanel(true)),
                    const SizedBox(width: 8),
                    Expanded(child: _translatorPanel(false)),
                  ],
                )
              : Column(
                  children: [
                    _translatorPanel(true),
                    const SizedBox(height: 8),
                    _translatorPanel(false),
                  ],
                ),
        );
      },
    );
  }

  Widget _translatorPanel(bool isSource) {
    final lang = isSource ? currentSourceLang : currentTargetLang;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language selector
            InkWell(
              onTap: () => _openLanguageSelector(isSource),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(
                      lang,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, size: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Text area
            isSource
                ? TextField(
                    controller: sourceController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Enter text",
                      border: InputBorder.none,
                    ),
                    onChanged: (v) {
                      setState(() {
                        sourceText = v;
                        targetText = ""; // clear previous translation
                      });

                      // Debounce translation request
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce =
                          Timer(const Duration(milliseconds: 500), () async {
                        if (sourceText.trim().isEmpty) return;

                        final translated =
                            await translationService.translateText(
                          text: sourceText,
                          targetLang: deeplLangCode(currentTargetLang),
                          // Optional: sourceLang: _deeplLangCode(currentSourceLang),
                        );

                        if (translated != null) {
                          setState(() {
                            targetText = translated;
                          });
                        }
                      });
                    })
                : SelectableText(
                    targetText.isNotEmpty
                        ? targetText
                        : (sourceText.trim().isNotEmpty &&
                                (_debounce?.isActive ?? false)
                            ? "Translating..."
                            : "Translation"),
                    style: TextStyle(
                      color: targetText.isEmpty ? Colors.grey.shade600 : null,
                      fontSize: 16,
                    ),
                  ),

            const SizedBox(height: 8),

            // Buttons
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    onPressed: () {
                      final textToSpeak = isSource ? sourceText : targetText;
                      final lang =
                          isSource ? currentSourceLang : currentTargetLang;
                      ttsService.speak(textToSpeak, lang);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark),
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      messenger.showSnackBar(
                        const SnackBar(content: Text("Saving…")),
                      );
                      await vocabularyService.saveVocabulary(
                        text: sourceText,
                        source: 'translator',
                        sourceLang: currentSourceLang,
                        targetLang: currentTargetLang,
                      );
                      if (!mounted) return;
                      messenger.hideCurrentSnackBar();
                      messenger.showSnackBar(
                        const SnackBar(content: Text("Saved to vocabulary")),
                      );
                    },
                  ),
                  if (isSource)
                    IconButton(
                      icon: const Icon(Icons.swap_horiz),
                      onPressed: _swapLanguages,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _swapLanguages() {
    setState(() {
      final tempLang = currentSourceLang;
      currentSourceLang = currentTargetLang;
      currentTargetLang = tempLang;

      final tempText = sourceText;
      sourceText = targetText;
      targetText = tempText;

      sourceController.text = sourceText;
    });
  }

  void _openLanguageSelector(bool isSource) {
    final allLanguages = [
      "English",
      "Spanish",
      "French",
      "German",
      "Portuguese",
      "Italian",
      "Chinese",
      "Japanese",
      "Korean",
      "Arabic",
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        String query = "";
        List<String> filtered = List.from(allLanguages);

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search language",
                    ),
                    onChanged: (value) {
                      setModalState(() {
                        query = value.toLowerCase();
                        filtered = allLanguages
                            .where((l) => l.toLowerCase().contains(query))
                            .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final lang = filtered[index];
                        return ListTile(
                          title: Text(lang),
                          onTap: () {
                            setState(() {
                              if (isSource) {
                                currentSourceLang = lang;
                              } else {
                                currentTargetLang = lang;
                              }
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ---------------- CALENDAR ----------------

  Widget _calendarStrip() {
    final today = DateTime.now();
    const totalDays = 15;
    const middleIndex = totalDays ~/ 2;

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: totalDays,
        itemBuilder: (context, i) {
          final date = today.add(Duration(days: i - middleIndex));
          final isSelected = _sameDay(date, selectedDate);
          final isFuture = date.isAfter(today);

          final theme = Theme.of(context);
          return GestureDetector(
            onTap: isFuture ? null : () => setState(() => selectedDate = date),
            child: Container(
              width: 56,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected
                    ? [BoxShadow(color: theme.colorScheme.primary.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2))]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weekday(date),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white70 : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    "${date.day}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- DAY INFO ----------------

  Widget _dayInformation() {
    final bool isToday = _sameDay(selectedDate, DateTime.now());
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isToday)
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Start Daily Challenge"),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            isToday ? "To Do" : "Done",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.menu_book_outlined, color: theme.colorScheme.primary),
              title: const Text("Read"),
              subtitle: const Text("Pages read: 8"),
            ),
          ),
          const SizedBox(height: 6),
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.school_outlined, color: theme.colorScheme.primary),
              title: const Text("Vocabulary"),
              subtitle: const Text("Words learned: 3"),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HELPERS ----------------

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _weekday(DateTime d) =>
      ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][d.weekday - 1];
}
