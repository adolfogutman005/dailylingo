// write_translation (write the translation of the word in your native language)

// write_target_translation (write the translation of a word in your native language)

// write_existing_example

// definition matching: pick definition for word

// word matching: pick word for definition

// fill in the blank complete with word

// write_new_example

import '../../services/vocabulary_service.dart';
import 'exercise.dart';

class ExerciseTemplates {
  // ---------------- WRITE TRANSLATION ----------------
  static Future<Exercise> writeTranslation(
    VocabularyService vocab,
    int wordId,
  ) async {
    final word = await vocab.getWordText(wordId);
    final translation = await vocab.getPrimaryTranslation(wordId);

    return Exercise.writeAnswer(
      question: 'Translate: $word',
      answer: translation,
    );
  }

  static Future<Exercise> writeTargetTranslation(
    VocabularyService vocab,
    int wordId,
  ) async {
    final word = await vocab.getWordText(wordId);
    final translation = await vocab.getPrimaryTranslation(wordId);

    return Exercise.writeAnswer(
      question: 'Translate: $translation',
      answer: word,
    );
  }

  // ---------------- WRITE EXISTING EXAMPLE ----------------
  static Future<Exercise> writeExistingExample(
    VocabularyService vocab,
    int wordId,
  ) async {
    final word = await vocab.getWordText(wordId);
    final examples = await vocab.getExamples(wordId);

    return Exercise.writeAnswer(
      question: 'Write an example using "$word"',
      answer: examples.first,
      possibleAnswers: examples,
    );
  }

  // ---------------- PICK DEFINITION (DUMMY AI) ----------------
  static Future<Exercise> pickDefinition(
    VocabularyService vocab,
    int wordId,
  ) async {
    final word = await vocab.getWordText(wordId);
    final correct = await vocab.getDefinition(wordId) ?? 'Unknown meaning';

    // AI-generated wrong options
    final distractors = await vocab.getDefinitionDistractors(wordId);

    final options = [
      correct,
      ...distractors.take(3),
    ]..shuffle();

    return Exercise.fourOptions(
      question: 'Choose the correct definition for "$word"',
      options: options,
      answer: correct,
    );
  }

  static Future<Exercise> pickWordFromDefinition(
    VocabularyService vocab,
    int wordId,
  ) async {
    final word = await vocab.getWordText(wordId);
    final definition = await vocab.getDefinition(wordId) ?? 'Unknown meaning';

    final allIds = await vocab.getAllWordIds();
    allIds.remove(wordId);
    allIds.shuffle();

    final distractors = <String>[];
    for (final id in allIds.take(3)) {
      distractors.add(await vocab.getWordText(id));
    }

    final options = [word, ...distractors]..shuffle();

    return Exercise.fourOptions(
      question: 'Which word matches this definition?\n\n"$definition"',
      options: options,
      answer: word,
    );
  }

  static Future<Exercise> fillInTheBlank(
    VocabularyService vocab,
    int wordId,
  ) async {
    final word = await vocab.getWordText(wordId);
    final examples = await vocab.getExamples(wordId);

    if (examples.isEmpty) {
      return writeTargetTranslation(vocab, wordId);
    }

    final sentence = examples.first;
    final blankSentence =
        sentence.replaceAll(RegExp(word, caseSensitive: false), '_____');

    final allIds = await vocab.getAllWordIds();
    allIds.remove(wordId);
    allIds.shuffle();

    final distractors = <String>[];
    for (final id in allIds.take(3)) {
      distractors.add(await vocab.getWordText(id));
    }

    final options = [word, ...distractors]..shuffle();

    return Exercise.fourOptions(
      question: 'Fill in the blank:\n\n$blankSentence',
      options: options,
      answer: word,
    );
  }
}
