import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'state/user_settings_state.dart';
import 'translator_service.dart';

final Map<String, String> _langCodes = {
  "english": "EN",
  "spanish": "ES",
  "french": "FR",
  "german": "DE",
  "portuguese": "PT",
  "italian": "IT",
  "chinese": "ZH",
  "japanese": "JA",
  "korean": "KO",
  "arabic": "AR",
};

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // -------- SESSION STATE (TEMPORARY) --------
  late String currentSourceLang;
  late String currentTargetLang;

  String sourceText = "";
  String targetText = "";
  DateTime selectedDate = DateTime.now();

  Timer? _debounce;
  final translationService =
      TranslationService(apiKey: '253c4f2b-4394-4dcc-b808-82572df88046:fx');

  final TextEditingController sourceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // initialize from user defaults ONCE
    final userSettings = context.read<UserSettingsState>();
    currentSourceLang = userSettings.settings.sourceLang;
    currentTargetLang = userSettings.settings.targetLang;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dailylingo"),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _translatorSection(),
            const SizedBox(height: 20),
            _calendarStrip(),
            const SizedBox(height: 12),
            _dayInformation(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Reading"),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Journaling"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: "Note Taking"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Vocabulary"),
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
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language selector
            InkWell(
              onTap: () => _openLanguageSelector(isSource),
              child: Row(
                children: [
                  Text(
                    lang,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
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
                          targetLang: _deeplLangCode(currentTargetLang),
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
                    targetText.isEmpty
                        ? (_debounce?.isActive ?? false
                            ? "Translating..."
                            : "Translation")
                        : targetText,
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
                    onPressed: () {},
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

  String _deeplLangCode(String lang) {
    return _langCodes[lang.toLowerCase()] ?? "EN"; // default to English
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

          return GestureDetector(
            onTap: isFuture ? null : () => setState(() => selectedDate = date),
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_weekday(date)),
                  Text(
                    "${date.day}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
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

    return Padding(
      padding: const EdgeInsets.all(12),
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
          const SizedBox(height: 12),
          Text(
            isToday ? "To Do" : "Done",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              title: const Text("Read"),
              subtitle: const Text("Pages read: 8"),
            ),
          ),
          Card(
            child: ListTile(
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
