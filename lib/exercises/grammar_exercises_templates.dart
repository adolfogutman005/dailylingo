import 'exercise.dart';
import '../../services/vocabulary_service.dart';

class GrammarExerciseTemplates {
  // ---------------- WRITE EXAMPLE SENTENCE ----------------
  static Future<Exercise> exampleSentence(
    VocabularyService vocab,
    String concept,
  ) async {
    // For now, dummy answer
    final answer = 'This is a correct example.';

    return Exercise.writeAnswer(
      question: 'Write a sentence using "$concept"',
      answer: answer,
    );
  }

  // ---------------- MULTIPLE CHOICE ----------------
  static Future<Exercise> multipleChoice(
    VocabularyService vocab,
    String concept,
  ) async {
    final options = [
      'Incorrect example 1',
      'Correct example',
      'Incorrect example 2',
      'Incorrect example 3',
    ];

    return Exercise.fourOptions(
      question: 'Which sentence uses "$concept" correctly?',
      options: options..shuffle(), // shuffle for randomness
      answer: 'Correct example',
    );
  }
}
