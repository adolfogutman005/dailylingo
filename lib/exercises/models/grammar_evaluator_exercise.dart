import 'grammar_feedback.dart';
import 'base_exercise.dart';

class GrammarEvaluatorExercise implements BaseExercise {
  @override
  final String question;

  final Future<GrammarFeedback> Function(String userAnswer) evaluator;

  GrammarEvaluatorExercise({
    required this.question,
    required this.evaluator,
  });
}
