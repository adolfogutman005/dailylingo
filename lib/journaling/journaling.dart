import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const JournalingPage(),
    );
  }
}

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
          'Feb 5', 'A calm day', 'Today I felt relaxed and focused...'),
      JournalEntry('Feb 3', 'Music thoughts',
          'I listened to a song that reminded me...'),
    ],
    'January 2026': [
      JournalEntry('Jan 28', 'New goals', 'This month I want to improve...'),
      JournalEntry(
          'Jan 14', 'Rainy afternoon', 'It was raining and I stayed home...'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final journals = journalsByMonth[selectedMonth]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _startDailyJournaling(),
            const SizedBox(height: 24),
            _challengeRow(),
            const SizedBox(height: 16),
            _randomJournalButton(),
            const SizedBox(height: 32),
            _monthSelector(),
            const SizedBox(height: 12),
            ...journals.map(_journalTile),
          ],
        ),
      ),
    );
  }

  // ---------- UI ----------

  Widget _startDailyJournaling() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 320,
        ),
        child: Container(
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.blue.shade50,
            border: Border.all(color: Colors.blue),
          ),
          child: const Text(
            'Start Daily Journaling',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _challengeRow() {
    final challenges = [
      {'title': 'Favorite Song', 'icon': Icons.music_note},
      {'title': 'Favorite Movie', 'icon': Icons.movie},
      {'title': 'Happiest Memory', 'icon': Icons.emoji_emotions},
      {'title': 'Random Thought', 'icon': Icons.lightbulb},
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
          );
        },
      ),
    );
  }

  Widget _challengeCard({required String title, required IconData icon}) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 12),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _randomJournalButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('${entry.date} · ${entry.title}'),
      subtitle: Text(
        entry.preview,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {},
    );
  }
}

// ---------- Model ----------

class JournalEntry {
  final String date;
  final String title;
  final String preview;

  JournalEntry(this.date, this.title, this.preview);
}
