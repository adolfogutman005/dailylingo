import 'package:flutter/material.dart';
// Import your pages
import 'home_page.dart';
import 'journaling/journaling.dart';
// import 'notetaking/note_taking_page.dart';
// import 'vocabulary_page.dart';
import 'reader/pages/reader_page.dart';
import 'journaling/write_journal_page.dart';
// import 'journaling/write_note_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dailylingo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2; // Default to Home

  // Pages
  final List<Widget> _pages = [
    const ReaderPage(),
    const JournalingPage(),
    const HomePage(),
    // const NoteTakingPage(),
    // const VocabularyPage(),
  ];

  // Dictionary for AppBar titles
  final Map<int, String> _appBarTitles = {
    0: "Reader",
    1: "Journal",
    2: "Home",
    3: "Note Taking",
    4: "Vocabulary",
  };

  // Dictionary for AppBar actions
  final Map<int, List<Widget>> _appBarActions = {
    0: [], // Reader
    1: [
      IconButton(icon: const Icon(Icons.calendar_today), onPressed: () {}),
      IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
    ],
    2: [
      IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
    ],
    3: [], // NoteTaking
    4: [], // Vocabulary
  };

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

    _fabs[2] = FloatingActionButton(
      onPressed: () {
        // Push to write note page
      },
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_currentIndex] ?? ""),
        actions: _appBarActions[_currentIndex] ?? [],
      ),
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
