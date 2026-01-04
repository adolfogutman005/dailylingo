import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
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
      appBar: appBar(),
      body: body(),
      floatingActionButton: floatingButton(),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}

SingleChildScrollView body() {
  return SingleChildScrollView(
    child: Column(
      children: [
        _translatorSection(),
        const SizedBox(height: 12),
        _calendarSection(),
        const SizedBox(height: 12),
        _dayInformation(),
      ],
    ),
  );
}

AppBar appBar() {
  return AppBar(
    title: const Text("Dailylingo"),
    actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
  );
}

FloatingActionButton floatingButton() {
  return FloatingActionButton(onPressed: () {}, child: Icon(Icons.add));
}

BottomNavigationBar bottomNavigation() {
  return BottomNavigationBar(
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
  );
}

Widget _translatorSection() {
  return LayoutBuilder(
    builder: (context, contraints) {
      final bool horizontal = contraints.maxWidth > 700;

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
                  SizedBox(height: 8),
                  _translatorPanel(false),
                ],
              ),
      );
    },
  );
}


Widget _translatorPanel(String lang){
  return Card(
    elevation: 12,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Languages 
          InkWell(
            onTap: () {
              
            },
            child: Row(
              children: [
                // Language 

                // Icon 
                Icon(Icons.arrow_downward),
              ],
            )
          ),

          const SizedBox(height: 12),

          // Text Field

          // Buttons 


        ],

      )
    )   
  
  )

}