import '../models/exercise.dart';
import '../../../services/vocabulary_service.dart';
import '../models/grammar_evaluator_exercise.dart';

class GrammarExerciseTemplates {
  // ---------------- WRITE EXAMPLE SENTENCE ----------------
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

  static GrammarEvaluatorExercise writeAndGetFeedback(
    VocabularyService vocab,
    String concept,
  ) {
    return GrammarEvaluatorExercise(
      question: 'Write a sentence using "$concept"',
      evaluator: (userAnswer) async {
        return vocab.checkGrammar(
          concept: concept,
          sentence: userAnswer,
        );
      },
    );
  }
}
