import 'package:flutter/material.dart';
import '../widgets/book_card.dart';
import '../widgets/sort_bar.dart';
import '../data/demo_data_books.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});

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
