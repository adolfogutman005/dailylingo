import 'package:flutter/material.dart';
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
    return ReaderBody();
  }
}

class ReaderBody extends StatelessWidget {
  const ReaderBody({super.key});

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
