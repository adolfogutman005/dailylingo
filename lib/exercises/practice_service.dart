import '../../services/vocabulary_service.dart';
import 'exercise.dart';
import 'practice_levels.dart';
import 'vocabulary_exercises_templates.dart';
import 'grammar_exercises_templates.dart';

class PracticeService {
  final VocabularyService vocab;

  PracticeService(this.vocab);

  Future<List<Exercise>> getGrammarExercises(String concept) async {
    return [
      await GrammarExerciseTemplates.exampleSentence(vocab, concept),
      await GrammarExerciseTemplates.multipleChoice(vocab, concept),
    ];
  }

  Future<List<Exercise>> getItemExercises(int wordId) async {
    final learning = await vocab.getLearningData(wordId);
    final times = learning?.timesPracticed ?? 0;

    final level = _resolveLevel(times);
    final handler = levelHandlers[level] ?? getLevelOneExercises;

    return handler(vocab, wordId);
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
