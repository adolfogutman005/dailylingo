import '../../services/vocabulary_service.dart';
import 'templates/vocabulary_exercises_templates.dart';
import 'models/exercise.dart';

typedef LevelExerciseBuilder = Future<List<Exercise>> Function(
  VocabularyService vocab,
  int wordId,
);

final Map<int, LevelExerciseBuilder> levelHandlers = {
  1: getLevelOneExercises,
};

Future<List<Exercise>> getLevelOneExercises(
  VocabularyService vocab,
  int wordId,
) async {
  return [
    await ExerciseTemplates.writeTranslation(vocab, wordId),
    await ExerciseTemplates.writeExistingExample(vocab, wordId),
    await ExerciseTemplates.pickDefinition(vocab, wordId),
  ];
}
