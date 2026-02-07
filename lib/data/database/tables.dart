import 'package:drift/drift.dart';

class WordEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get wordText => text()();
  TextColumn get language => text()();
  TextColumn get entryType => text()(); // word | phrase
  TextColumn get source => text()(); // translator, reading, etc
  DateTimeColumn get createdAt => dateTime()();
}

class Translations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordId =>
      integer().references(WordEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get language => text()();
  TextColumn get translatedText => text()();
}

class WordMeanings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordId =>
      integer().references(WordEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get definition => text()();
}

class WordExamples extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordId =>
      integer().references(WordEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get exampleText => text()();
}

class WordSynonyms extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordId =>
      integer().references(WordEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get synonymText => text()();
}

class WordNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordId =>
      integer().references(WordEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get noteText => text()();
}

class WordLearningData extends Table {
  IntColumn get wordId =>
      integer().references(WordEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get status => text()();
  DateTimeColumn get lastReviewed => dateTime().nullable()();
  IntColumn get timesPracticed => integer()();

  @override
  Set<Column> get primaryKey => {wordId};
}
