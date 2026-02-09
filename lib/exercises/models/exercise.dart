import 'base_exercise.dart';

enum ExerciseType {
  fourOptions,
  writeAnswer,
}

class Exercise extends BaseExercise {
  @override
  final String question;

  final ExerciseType type;
  final List<String>? options;
  final String answer;
  final List<String> possibleAnswers;

  Exercise({
    required this.type,
    required this.question,
    required this.answer,
    this.options,
    List<String>? possibleAnswers,
  }) : possibleAnswers = possibleAnswers ?? [answer];

  factory Exercise.fourOptions({
    required String question,
    required List<String> options,
    required String answer,
    List<String>? possibleAnswers,
  }) =>
      Exercise(
        type: ExerciseType.fourOptions,
        question: question,
        options: options,
        answer: answer,
        possibleAnswers: possibleAnswers,
      );

  factory Exercise.writeAnswer({
    required String question,
    required String answer,
    List<String>? possibleAnswers,
  }) =>
      Exercise(
        type: ExerciseType.writeAnswer,
        question: question,
        answer: answer,
        possibleAnswers: possibleAnswers,
      );
}
