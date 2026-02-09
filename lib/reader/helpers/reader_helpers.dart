import 'package:flutter/material.dart';
import '../models/reader_models.dart';

void openReader(BuildContext context, int page) {
  print("Open reader at page $page");

  // Later:
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (_) => ReaderPage(
  //       book: book,
  //       initialPage: page,
  //     ),
  //   ),
  // );
}

void openVocabularyMore(BuildContext context, VocabularyItem item) {
  print("More options for vocabulary: ${item.term}");

  // Later:
  // showModalBottomSheet(...)
  // or PopupMenuButton actions
}
