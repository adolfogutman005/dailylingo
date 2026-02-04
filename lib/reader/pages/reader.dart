import 'package:flutter/material.dart';
import '../widgets/reader_app_bar.dart';
import '../widgets/book_card.dart';
import '../widgets/sort_bar.dart';
import '../data/demo_data_books.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({super.key});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  String selectedFilter = "Reading";

  final List<String> filters = ["Reading", "Finished", "Favorites"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReaderAppBar(
        filters: filters,
        selected: selectedFilter,
        onFilterSelected: (filter) {
          setState(() {
            selectedFilter = filter;
          });
        },
      ),
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SortBar(), // Book Cards
        Expanded(
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (BuildContext build, int index) {
              return BookCard(book: books[index]);
            }, //
          ),
        ),
      ],
    );
  }
}
