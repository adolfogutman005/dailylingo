import 'corrections.dart';

class FeedbackData {
  final String title;
  final String originalContent;
  final String correctedContent;
  final List<Correction> corrections;
  final List<String> conceptsLearned;

  FeedbackData({
    required this.title,
    required this.originalContent,
    required this.correctedContent,
    required this.corrections,
    required this.conceptsLearned,
  });
}
