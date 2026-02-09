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
    final result = await vocab.getGrammarMultipleChoice(concept);

    final options = [
      result.correct,
      ...result.distractors,
    ]..shuffle();

    return Exercise.fourOptions(
      question: 'Which sentence uses "$concept" correctly?',
      options: options,
      answer: result.correct,
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
