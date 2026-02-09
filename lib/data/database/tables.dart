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

class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get contentOriginal => text().named('content_original')();
  TextColumn get contentCorrected =>
      text().nullable().named('content_corrected')();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime).named('created_at')();
}

class Corrections extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get journalId =>
      integer().customConstraint('REFERENCES journals(id) ON DELETE CASCADE')();
  IntColumn get start => integer()();
  IntColumn get end => integer()();
  TextColumn get wrong => text()();
  TextColumn get right => text()();
  TextColumn get example => text()();
  TextColumn get explanation => text()();
  TextColumn get type => text()();
}

class GrammarConcepts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class JournalConcepts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get journalId =>
      integer().customConstraint('REFERENCES journals(id) ON DELETE CASCADE')();
  IntColumn get grammarConceptId => integer()
      .customConstraint('REFERENCES grammar_concepts(id) ON DELETE CASCADE')();
}
