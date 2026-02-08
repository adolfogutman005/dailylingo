import '../../services/vocabulary_service.dart';
import 'exercise.dart';
import 'practice_levels.dart';

class PracticeService {
  final VocabularyService vocab;

  PracticeService(this.vocab);

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
}
