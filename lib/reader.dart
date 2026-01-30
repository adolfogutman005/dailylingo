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

  const BookCard({super.key, required this.book});

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
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(
        // Go Back
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

            // Information
            // Review Space
            // Statistics
            // Cites and Notes
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
    return MaterialApp(home: MainPage());
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
          onPressed: () => print("Add Book"),
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
