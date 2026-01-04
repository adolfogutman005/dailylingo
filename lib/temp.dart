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
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String sourceLang = "English";
  String targetLang = "Spanish";
  String sourceText = "";
  String targetText = "";
  DateTime selectedDate = DateTime.now();

  final TextEditingController sourceController = TextEditingController();

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
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Habit1"),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Habit2"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Habit3"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Habit4"),
        ],
      ),
    );
  }

  // ---------------- TRANSLATOR ----------------

  Widget _translatorSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool horizontal = constraints.maxWidth > 700;

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
                    isSource ? sourceLang : targetLang,
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
                        targetText = ""; // placeholder
                      });
                    },
                  )
                : SelectableText(
                    targetText.isEmpty ? "Translation" : targetText,
                  ),

            const SizedBox(height: 8),

            // Action buttons
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

  void _swapLanguages() {
    setState(() {
      final tempLang = sourceLang;
      sourceLang = targetLang;
      targetLang = tempLang;

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
                  // Search field
                  TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search language",
                    ),
                    onChanged: (value) {
                      setModalState(() {
                        query = value.toLowerCase();
                        filtered = allLanguages
                            .where((lang) => lang.toLowerCase().contains(query))
                            .toList();
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  // Language list
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
                                sourceLang = lang;
                              } else {
                                targetLang = lang;
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
                  Text(
                    _weekday(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    "${date.day}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
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

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Only today
          if (isToday) ...[
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Start Daily Challenge"),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "To Do",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Card(
              child: ListTile(
                title: const Text("Read"),
                subtitle: const Text("Pages to read: 8"),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("Vocabulary"),
                subtitle: const Text("Words to learn: 3"),
              ),
            ),

            const SizedBox(height: 16),
          ],

          // Always show Done
          const Text(
            "Done",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
