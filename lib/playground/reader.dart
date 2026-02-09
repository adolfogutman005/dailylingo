import 'package:flutter/material.dart';

class Book {
  final int id;
  final String title;
  final String author;
  final String path;
  final String filePath;
  final String imagePath;
  final DateTime addedAt;
  final double progress;
  final DateTime lastRead;
  final String state;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.path,
    required this.filePath,
    required this.imagePath,
    required this.addedAt,
    required this.progress,
    required this.lastRead,
    required this.state,
  });

  factory Book.fromMap(Map<String, Object?> map) {
    return Book(
      id: map["id"] as int,
      title: map["title"] as String,
      author: map["author"] as String,
      path: map["path"] as String,
      filePath: map["file_path"] as String,
      imagePath: map["image_path"] as String,
      addedAt: DateTime.parse(map["added_at"] as String),
      progress: (map["progress"] as num).toDouble(),
      lastRead: DateTime.parse(map["last_read"] as String),
      state: map["state"] as String,
    );
  }
}

class VocabularyItem {
  final String term;
  final int page;

  VocabularyItem({required this.term, required this.page});
}

class Cite {
  final String text;
  final int page;

  Cite({required this.text, required this.page});
}

class Note {
  final String highlightedText;
  final String note;
  final int page;

  Note({required this.highlightedText, required this.note, required this.page});
}

// Define Demo Books
final List<Map<String, Object?>> demoData = [
  {
    "id": 1,
    "title": "Deep Work",
    "author": "Cal Newport",
    "path": "/books/deep_work.epub",
    "file_path": "/storage/books/deep_work.epub",
    "image_path": "https://picsum.photos/201/300",
    "added_at": "2025-01-10T14:32:00",
    "progress": 0.35,
    "last_read": "2025-01-20T21:10:00",
    "state": "reading",
  },
  {
    "id": 2,
    "title": "Atomic Habits",
    "author": "James Clear",
    "path": "/books/atomic_habits.epub",
    "file_path": "/storage/books/atomic_habits.epub",
    "image_path": "https://picsum.photos/200/300",
    "added_at": "2025-01-05T10:00:00",
    "progress": 1.0,
    "last_read": "2025-01-18T18:42:00",
    "state": "finished",
  },
];

final List<Book> books = demoData.map((e) => Book.fromMap(e)).toList();

final List<Cite> dummyCites = [
  Cite(text: "All men by nature desire to know.", page: 1),
  Cite(
    text: "The roots of education are bitter, but the fruit is sweet.",
    page: 23,
  ),
];

final List<Note> dummyNotes = [
  Note(
    highlightedText: "Virtue is a kind of mean",
    note: "This reminds me of Aristotle's ethics",
    page: 45,
  ),
  Note(
    highlightedText: "Music gives soul to the universe",
    note: "Plato again connecting music and morality",
    page: 78,
  ),
];

final List<VocabularyItem> dummyVocabulary = [
  VocabularyItem(term: "Telos", page: 12),
  VocabularyItem(term: "Prima facie", page: 34),
  VocabularyItem(term: "State of nature", page: 67),
];

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

class AddBookDialog extends StatelessWidget {
  const AddBookDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      insetPadding: const EdgeInsets.all(24), // margin from screen edges
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: size.width * 0.85,
        height: size.height * 0.85,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    "Add Book",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Body
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // Top-centered Add Book button
                  ElevatedButton(
                    onPressed: () {
                      print("Add Book pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Add Book",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),

                  // List of local books (UI placeholder)
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: books.length, // later: local PDFs / EPUBs
                      itemBuilder: (context, index) {
                        final book = books[index];

                        return BookCard(
                          book: book,
                          trailingAction: TextButton(
                            onPressed: () {
                              print("Add ${book.title}");
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Add",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  final double progress;

  const ProgressLine({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    const double dotSize = 5;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final usableWidth = width - dotSize;

        return SizedBox(
          height: 20,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Line
              Container(height: 3, width: width, color: Colors.grey.shade300),

              // Start dot
              _dot(0, dotSize),

              // End dot
              _dot(usableWidth, dotSize),

              // Progress dot
              _dot(usableWidth * progress, dotSize),
            ],
          ),
        );
      },
    );
  }

  Widget _dot(double left, double size) {
    return Positioned(
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;
  final Widget? trailingAction;

  const BookCard({super.key, required this.book, this.trailingAction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  print("Open book reader: ${book.title}");
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                  child: Image.network(
                    book.imagePath,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailsPage(book: book),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const Spacer(),

                      ProgressLine(progress: book.progress),

                      const SizedBox(height: 8),

                      // Buttons aligned to right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () {
                              print("Share ${book.title}");
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              print("Mark as read: ${book.title}");
                            },
                          ),
                          PopupMenuButton(
                            onSelected: print,
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'Add to Favorites',
                                child: Text('Add to Favorites'),
                              ),
                              PopupMenuItem(
                                value: 'Delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                          if (trailingAction != null) trailingAction!,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SortBar extends StatefulWidget {
  const SortBar({super.key});

  @override
  State<SortBar> createState() => _SortBarState();
}

class _SortBarState extends State<SortBar> {
  String selectedSort = "Last read";

  final List<String> options = ["Last read", "Date added", "Title", "Progress"];

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return ListTile(
              title: Text(option),
              trailing: option == selectedSort ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => selectedSort = option);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Your books",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: _showSortSheet,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.sort, size: 18),
                  const SizedBox(width: 6),
                  Text(selectedSort),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

void main() {
  return (runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

class ReaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> filters;
  final String selected;
  final Function(String) onFilterSelected;

  const ReaderAppBar({
    super.key,
    required this.filters,
    required this.selected,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("E-Reader"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => print("Search"),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true, // tap outside to close
              builder: (context) => const AddBookDialog(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => print("Settings"),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: filters.map((filter) {
              return ChoiceChip(
                label: Text(filter),
                shape: const StadiumBorder(),
                selected: filter == selected,
                onSelected: (_) => onFilterSelected(filter),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
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
