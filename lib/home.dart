import 'package:flutter/material.dart';
import 'home_page.dart';
import 'journaling/journaling_page.dart';
import 'vocabulary/pages/vocabulary_page.dart';
import 'journaling/write_journal_page.dart';
import 'services/vocabulary_service.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    const _ComingSoonPage(title: 'Reading'),
    const JournalingPage(),
    const HomePage(),
    const _ComingSoonPage(title: 'Note Taking'),
    const VocabularyPage(),
  ];

  PreferredSizeWidget? buildAppBar(int index) {
    final appBars = {
      0: AppBar(title: const Text('Reading')),
      1: AppBar(
        title: const Text('Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      2: AppBar(
        title: const Text("Dailylingo"),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      3: AppBar(title: const Text('Note Taking')),
      4: AppBar(
        title: const Text("Vocabulary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    };

    return appBars[index];
  }

  // Dictionary for FAB per tab
  final Map<int, FloatingActionButton> _fabs = {};

  @override
  void initState() {
    super.initState();

    // Define FABs
    _fabs[1] = FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WriteJournalPage()),
        );
      },
      child: const Icon(Icons.edit),
    );

    _fabs[2] = generalFAB(context: context);
    _fabs[4] = generalFAB(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(_currentIndex),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
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
      floatingActionButton: _fabs[_currentIndex],
    );
  }
}

FloatingActionButton generalFAB({
  required BuildContext context,
}) {
  return FloatingActionButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _controller = TextEditingController();
          final vocabularyService =
              Provider.of<VocabularyService>(context, listen: false);

          return AlertDialog(
            title: const Text("Add Word or Phrase"),
            content: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Enter word or phrase",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // Close dialog
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  String inputText = _controller.text.trim();
                  if (inputText.isNotEmpty) {
                    await vocabularyService.saveVocabulary(
                        text: inputText,
                        source: 'General',
                        sourceLang: 'English',
                        targetLang: 'Spanish');
                    Navigator.of(context).pop();
                    // TODO: Use user settings languages                      _controller.clear(); // Clear text
                  }
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
    },
    child: const Icon(Icons.add),
  );
}

class _ComingSoonPage extends StatelessWidget {
  final String title;

  const _ComingSoonPage({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.construction_outlined, size: 48, color: theme.colorScheme.primary.withOpacity(0.6)),
          const SizedBox(height: 16),
          Text(
            'Coming Soon',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
