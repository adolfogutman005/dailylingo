class VocabularyItem {
  final String id;
  final String text;
  final String translation;
  final String source;
  final String pronunciation;
  final String? explanation;
  final List<String> examples;
  final List<String> synonyms;
  final String status;
  final DateTime createdAt;
  final DateTime? lastReviewed;
  final int timesPracticed;
  final String? notes;

  VocabularyItem({
    required this.id,
    required this.text,
    required this.translation,
    required this.source,
    required this.pronunciation,
    this.explanation,
    this.examples = const [],
    this.synonyms = const [],
    this.status = "new",
    required this.createdAt,
    this.lastReviewed,
    this.timesPracticed = 0,
    this.notes,
  });
}
