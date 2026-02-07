import 'package:flutter/material.dart';
// Import your pages
import 'home_page.dart';
import 'journaling/journaling.dart';
// import 'notetaking/note_taking_page.dart';
import 'vocabulary/pages/vocabulary_page.dart';
import 'reader/pages/reader_page.dart';
import 'reader/widgets/reader_app_bar.dart';
import 'journaling/write_journal_page.dart';
// import 'journaling/write_note_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2; // Default to Home
  String selectedFilter = "Reading";

  // Pages
  final List<Widget> _pages = [
    const ReaderPage(),
    const JournalingPage(),
    const HomePage(),
    // const NoteTakingPage(),

    const VocabularyPage(),
  ];

  PreferredSizeWidget? buildAppBar(int index) {
    final appBars = {
      0: ReaderAppBar(
        filters: const ["Reading", "Finished", "Favorites"],
        selected: selectedFilter,
        onFilterSelected: (filter) {
          setState(() {
            selectedFilter = filter;
          });
        },
      ),
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
      3: AppBar(
        title: const Text("Vocabulary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: open search
            },
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
