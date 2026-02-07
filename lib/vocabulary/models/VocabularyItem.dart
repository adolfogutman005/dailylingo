class VocabularyItem {
  final String id;
  final String text;
  final DateTime createdAt;
  final String language;
  final String source;

  final String translation;

  final String? explanation;
  final List<String> examples;
  final List<String> synonyms;
  final List<String> notes;

  final String status;
  final DateTime? lastReviewed;
  final int timesPracticed;

  VocabularyItem({
    required this.id,
    required this.text,
    required this.translation,
    required this.source,
    this.explanation,
    this.examples = const [],
    this.synonyms = const [],
    this.notes = const [],
    this.status = "new",
    this.language = "English",
    required this.createdAt,
    this.lastReviewed,
    this.timesPracticed = 0,
  });
}
