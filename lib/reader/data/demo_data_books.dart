import '../models/reader_models.dart';

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
