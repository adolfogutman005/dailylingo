import '../models/reader_models.dart';
import 'package:flutter/material.dart';
import '../pages/book_details.dart';

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
