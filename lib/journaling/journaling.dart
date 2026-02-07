import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'write_journal_page.dart';
import 'journal_detail_page.dart';
import '../PrimaryActionCard.dart';

class JournalingPage extends StatefulWidget {
  const JournalingPage({super.key});

  @override
  State<JournalingPage> createState() => _JournalingPageState();
}

class _JournalingPageState extends State<JournalingPage> {
  String selectedMonth = 'February 2026';

  final Map<String, List<JournalEntry>> journalsByMonth = {
    'February 2026': [
      JournalEntry(
        DateTime(2026, 2, 5),
        'A calm day',
        '''Today felt unusually calm. I woke up earlier than usual and decided not to check my phone immediately.

Instead, I made coffee and sat near the window while the city was still quiet. I spent most of the morning reading and reflecting on how fast the past weeks have gone by.

There was no rush, no pressure — just a quiet sense of focus. I wish more days felt like this.''',
      ),
      JournalEntry(
        DateTime(2026, 2, 3),
        'Music thoughts',
        '''I listened to an old song today that immediately brought back memories from years ago.

It’s strange how music can transport you to a completely different time — almost like opening a door you forgot existed.

For a few minutes, I wasn’t thinking about the present at all. Just memories, feelings, and how much has changed since then.''',
      ),
    ],
    'January 2026': [
      JournalEntry(
        DateTime(2026, 1, 28),
        'New goals',
        '''This month I want to focus on building things consistently.

Not huge projects — just steady progress every day. Even one hour of deep work is better than scattered effort.

If I can maintain that rhythm, the results will compound.''',
      ),
      JournalEntry(
        DateTime(2026, 1, 14),
        'Rainy afternoon',
        '''It rained almost the entire afternoon, so I stayed home.

Made some tea, organized my desk, and finally finished a book I had been postponing.

Sometimes slowing down is exactly what you need.''',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final journals = journalsByMonth[selectedMonth]!;

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
          ...journals.map(_journalTile),
        ],
      ),
    );
  }

  // ---------- UI ----------

  Widget _startDailyJournaling() {
    return PrimaryActionCard(text: "Start Daily Journaling", onTap: () => {});
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
              placeholder: item['placeholder'] as String);
        },
      ),
    );
  }

  Widget _challengeCard(
      {required String title,
      required IconData icon,
      required String placeholder}) {
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
          boxShadow: const [
            BoxShadow(blurRadius: 6),
          ],
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
          items: journalsByMonth.keys
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
        entry.content.replaceAll('\n', ' '), // prevents line break glitches
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
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

// ---------- Model ----------

class JournalEntry {
  final DateTime date;
  final String title;
  final String content;

  JournalEntry(this.date, this.title, this.content);
}
