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
          _sectionTitle('Challenges'),
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
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              "No journals for this month yet.",
              style: TextStyle(color: Colors.grey),
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
    final challenges = [
      {
        'title': 'My Favorite Song',
        'icon': Icons.music_note,
        'placeholder': 'What is your favorite song and why?',
      },
      {
        'title': 'My Favorite Movie',
        'icon': Icons.movie,
        'placeholder': 'What is your favorite movie and what makes it special?',
      },
      {
        'title': 'Happiest Memory',
        'icon': Icons.emoji_emotions,
        'placeholder': 'What is one of the happiest memories of your life?',
      },
      {
        'title': 'Random Thought',
        'icon': Icons.lightbulb,
        'placeholder': 'Write about any thought currently on your mind.',
      },
    ];

    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: challenges.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = challenges[index];
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
    return InkWell(
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
      child: Ink(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [BoxShadow(blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _randomJournalButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 14,
          ),
        ),
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              month,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              day,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      title: Text(entry.title),
      subtitle: Text(
        entry.content.replaceAll('\n', ' '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red),
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
    );
  }
}

Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
