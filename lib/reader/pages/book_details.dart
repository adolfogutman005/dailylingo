import 'package:flutter/material.dart';
import '../models/reader_models.dart';
import '../data/demo_data_books.dart';
import '../helpers/reader_helpers.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Go Back
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to reader
              print("Start Reading");
            },
            child: const Text(
              "READ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],

        // Book Information Text
        // Read Button
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SizedBox(
              width: 300,
              child: AspectRatio(
                aspectRatio: 1 / 1.414,
                child: Image.network(book.imagePath, fit: BoxFit.contain),
              ),
            ),
            // Title
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                book.title,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            // Actions
            Row(
              spacing: 8,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    print("Add to favorites: ${book.title}");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    print("Mark as read: ${book.title}");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    print("Share ${book.title}");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    print("Delete: ${book.title}");
                  },
                ),
              ],
            ),
            // Cites
            ExpansionTile(
              title: const Text(
                "Cites",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              children: dummyCites.map((cite) {
                return ListTile(
                  title: Text(
                    '"${cite.text}"',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(
                    "p. ${cite.page}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () => openReader(context, cite.page),
                );
              }).toList(),
            ),
            // Notes
            ExpansionTile(
              title: const Text(
                "Notes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              children: dummyNotes.map((note) {
                return ListTile(
                  title: Text(
                    '"${note.highlightedText}"',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(note.note),
                  trailing: Text(
                    "p. ${note.page}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () => openReader(context, note.page),
                );
              }).toList(),
            ),
            ExpansionTile(
              title: const Text(
                "Vocabulary",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              children: dummyVocabulary.map((item) {
                return ListTile(
                  title: Text(
                    item.term,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: TextButton(
                    onPressed: () => openVocabularyMore(context, item),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade200, // box color
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          6,
                        ), // set to 0 for sharp corners
                        side: const BorderSide(
                          color: Colors.grey,
                        ), // optional border
                      ),
                    ),
                    child: const Text(
                      "More",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  onTap: () => openReader(context, item.page),
                );
              }).toList(),
            ),
            // Information

            // Review Space
            // Statistics

            // Words Learned
          ],
        ),
      ),
    );
  }
}
