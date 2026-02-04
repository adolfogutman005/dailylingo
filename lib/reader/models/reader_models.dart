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
