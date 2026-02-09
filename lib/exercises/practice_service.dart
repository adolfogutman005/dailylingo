import '../../services/vocabulary_service.dart';
import 'models/base_exercise.dart';
import 'models/exercise.dart';
import 'models/grammar_evaluator_exercise.dart';
import 'practice_levels.dart';
import 'vocabulary_exercises_templates.dart';
import 'grammar_exercises_templates.dart';

class PracticeService {
  final VocabularyService vocab;

  PracticeService(this.vocab);

  Future<List<BaseExercise>> getGrammarExercises(String concept) async {
    return [
      await GrammarExerciseTemplates.multipleChoice(vocab, concept),
      GrammarExerciseTemplates.writeAndGetFeedback(vocab, concept)
    ];
  }

  Future<List<BaseExercise>> getItemExercises(int wordId) async {
    final learning = await vocab.getLearningData(wordId);
    final times = learning?.timesPracticed ?? 0;

    final level = _resolveLevel(times);
    final handler = levelHandlers[level] ?? getLevelOneExercises;

    final exercises = await handler(vocab, wordId);

    return exercises; // List<Exercise> is OK here
  }

  int _resolveLevel(int times) {
    if (times < 3) return 1;
    if (times < 7) return 2;
    return 3;
  }

  Future<List<Exercise>> startRandomSession({int count = 5}) async {
    final allWordIds = await vocab.getAllWordIds();

    if (allWordIds.isEmpty) return [];

    allWordIds.shuffle();
    final selected = allWordIds.take(count).toList();

    final builders = [
      ExerciseTemplates.writeTargetTranslation,
      ExerciseTemplates.writeTranslation,
      ExerciseTemplates.pickWordFromDefinition,
      ExerciseTemplates.fillInTheBlank,
      ExerciseTemplates.fillInTheBlank,
    ];

    final exercises = <Exercise>[];

    for (int i = 0; i < selected.length; i++) {
      final builder = builders[i % builders.length];

      exercises.add(
        await builder(vocab, selected[i]),
      );
    }

    return exercises;
  }
}
