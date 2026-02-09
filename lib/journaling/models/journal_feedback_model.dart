import 'corrections.dart';

class JournalFeedback {
  final String originalContent;
  final String correctedContent;
  final List<Correction> corrections;
  final List<String> conceptsLearned;

  JournalFeedback({
    required this.originalContent,
    required this.correctedContent,
    required this.corrections,
    required this.conceptsLearned,
  });
}
