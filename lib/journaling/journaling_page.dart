import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'write_journal_page.dart';
import 'journal_detail_page.dart';
import '../PrimaryActionCard.dart';
import 'models/journal.dart';
import '../services/vocabulary_service.dart';

class JournalingPage extends StatefulWidget {
  static const routeName = '/journaling';

  const JournalingPage({super.key});

  @override
  State<JournalingPage> createState() => _JournalingPageState();
}

class _JournalingPageState extends State<JournalingPage> {
  String selectedMonth = DateFormat('MMMM yyyy').format(DateTime.now());

  late VocabularyService vocabularyService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    vocabularyService = Provider.of<VocabularyService>(context);
  }

  DateTime get _selectedMonthDate =>
      DateFormat('MMMM yyyy').parse(selectedMonth);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _startDailyJournaling(),
          const SizedBox(height: 24),
          _sectionTitle('Challenges', context),
          _challengeRow(),
          const SizedBox(height: 16),
          _randomJournalButton(),
          const SizedBox(height: 32),
          _monthSelector(),
          const SizedBox(height: 12),
          _journalsList(),
        ],
      ),
    );
  }

  Widget _journalsList() {
    return StreamBuilder<List<JournalEntry>>(
      stream: vocabularyService.watchJournalsForMonth(_selectedMonthDate),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final journals = snapshot.data!;

        if (journals.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              "No journals for this month yet.",
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          );
        }

        return Column(
          children: journals.map(_journalTile).toList(),
        );
      },
    );
  }

  Future<void> _confirmDelete(JournalEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete journal'),
        content: const Text(
          'Are you sure you want to delete this journal? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await vocabularyService.deleteJournal(entry.id);
    }
  }

  // ---------- UI ----------

  Widget _startDailyJournaling() {
    return PrimaryActionCard(
      text: "Start Daily Journaling",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WriteJournalPage()),
        );
      },
    );
  }

  Widget _challengeRow() {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _challengeJournals.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = _challengeJournals[index];
          return _challengeCard(
            title: item['title'] as String,
            icon: item['icon'] as IconData,
            placeholder: item['placeholder'] as String,
          );
        },
      ),
    );
  }

  Widget _challengeCard({
    required String title,
    required IconData icon,
    required String placeholder,
  }) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      shadowColor: Colors.black26,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WriteJournalPage(
                initialTitle: title,
                placeholder: placeholder,
              ),
            ),
          );
        },
        child: Container(
          width: 140,
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: theme.colorScheme.primary),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _challengeJournals = [
    {'title': 'My Favorite Song', 'icon': Icons.music_note, 'placeholder': 'What is your favorite song and why?'},
    {'title': 'My Favorite Movie', 'icon': Icons.movie, 'placeholder': 'What is your favorite movie and what makes it special?'},
    {'title': 'Happiest Memory', 'icon': Icons.emoji_emotions, 'placeholder': 'What is one of the happiest memories of your life?'},
    {'title': 'Random Thought', 'icon': Icons.lightbulb, 'placeholder': 'Write about any thought currently on your mind.'},
  ];

  Widget _randomJournalButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: () {
          final challenge = _challengeJournals[Random().nextInt(_challengeJournals.length)];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WriteJournalPage(
                initialTitle: challenge['title'] as String,
                placeholder: challenge['placeholder'] as String,
              ),
            ),
          );
        },
        child: const Text('Random Journal'),
      ),
    );
  }

  Widget _monthSelector() {
    final months = List.generate(
      6,
      (i) => DateFormat('MMMM yyyy')
          .format(DateTime.now().subtract(Duration(days: 30 * i))),
    );

        return Align(
      alignment: Alignment.centerLeft,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedMonth,
          icon: const Icon(Icons.expand_more),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          items: months
              .map(
                (month) => DropdownMenuItem(
                  value: month,
                  child: Text(month),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => selectedMonth = value);
            }
          },
        ),
      ),
    );
  }

  Widget _journalTile(JournalEntry entry) {
    final month = DateFormat('MMM').format(entry.date).toUpperCase();
    final day = DateFormat('d').format(entry.date);
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: SizedBox(
          width: 44,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                month,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(
                day,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          entry.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          entry.content.replaceAll('\n', ' '),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
          onPressed: () => _confirmDelete(entry),
        ),
        onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JournalDetailPage(entry: entry),
          ),
        );
      },
    ),
    );
  }
}

Widget _sectionTitle(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    ),
  );
}
