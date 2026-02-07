// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WordEntriesTable extends WordEntries
    with TableInfo<$WordEntriesTable, WordEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordTextMeta =
      const VerificationMeta('wordText');
  @override
  late final GeneratedColumn<String> wordText = GeneratedColumn<String>(
      'word_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entryTypeMeta =
      const VerificationMeta('entryType');
  @override
  late final GeneratedColumn<String> entryType = GeneratedColumn<String>(
      'entry_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, wordText, language, entryType, source, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_entries';
  @override
  VerificationContext validateIntegrity(Insertable<WordEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_text')) {
      context.handle(_wordTextMeta,
          wordText.isAcceptableOrUnknown(data['word_text']!, _wordTextMeta));
    } else if (isInserting) {
      context.missing(_wordTextMeta);
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('entry_type')) {
      context.handle(_entryTypeMeta,
          entryType.isAcceptableOrUnknown(data['entry_type']!, _entryTypeMeta));
    } else if (isInserting) {
      context.missing(_entryTypeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wordText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word_text'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      entryType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_type'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $WordEntriesTable createAlias(String alias) {
    return $WordEntriesTable(attachedDatabase, alias);
  }
}

class WordEntry extends DataClass implements Insertable<WordEntry> {
  final int id;
  final String wordText;
  final String language;
  final String entryType;
  final String source;
  final DateTime createdAt;
  const WordEntry(
      {required this.id,
      required this.wordText,
      required this.language,
      required this.entryType,
      required this.source,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_text'] = Variable<String>(wordText);
    map['language'] = Variable<String>(language);
    map['entry_type'] = Variable<String>(entryType);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WordEntriesCompanion toCompanion(bool nullToAbsent) {
    return WordEntriesCompanion(
      id: Value(id),
      wordText: Value(wordText),
      language: Value(language),
      entryType: Value(entryType),
      source: Value(source),
      createdAt: Value(createdAt),
    );
  }

  factory WordEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordEntry(
      id: serializer.fromJson<int>(json['id']),
      wordText: serializer.fromJson<String>(json['wordText']),
      language: serializer.fromJson<String>(json['language']),
      entryType: serializer.fromJson<String>(json['entryType']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordText': serializer.toJson<String>(wordText),
      'language': serializer.toJson<String>(language),
      'entryType': serializer.toJson<String>(entryType),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WordEntry copyWith(
          {int? id,
          String? wordText,
          String? language,
          String? entryType,
          String? source,
          DateTime? createdAt}) =>
      WordEntry(
        id: id ?? this.id,
        wordText: wordText ?? this.wordText,
        language: language ?? this.language,
        entryType: entryType ?? this.entryType,
        source: source ?? this.source,
        createdAt: createdAt ?? this.createdAt,
      );
  WordEntry copyWithCompanion(WordEntriesCompanion data) {
    return WordEntry(
      id: data.id.present ? data.id.value : this.id,
      wordText: data.wordText.present ? data.wordText.value : this.wordText,
      language: data.language.present ? data.language.value : this.language,
      entryType: data.entryType.present ? data.entryType.value : this.entryType,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordEntry(')
          ..write('id: $id, ')
          ..write('wordText: $wordText, ')
          ..write('language: $language, ')
          ..write('entryType: $entryType, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, wordText, language, entryType, source, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordEntry &&
          other.id == this.id &&
          other.wordText == this.wordText &&
          other.language == this.language &&
          other.entryType == this.entryType &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class WordEntriesCompanion extends UpdateCompanion<WordEntry> {
  final Value<int> id;
  final Value<String> wordText;
  final Value<String> language;
  final Value<String> entryType;
  final Value<String> source;
  final Value<DateTime> createdAt;
  const WordEntriesCompanion({
    this.id = const Value.absent(),
    this.wordText = const Value.absent(),
    this.language = const Value.absent(),
    this.entryType = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WordEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String wordText,
    required String language,
    required String entryType,
    required String source,
    required DateTime createdAt,
  })  : wordText = Value(wordText),
        language = Value(language),
        entryType = Value(entryType),
        source = Value(source),
        createdAt = Value(createdAt);
  static Insertable<WordEntry> custom({
    Expression<int>? id,
    Expression<String>? wordText,
    Expression<String>? language,
    Expression<String>? entryType,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordText != null) 'word_text': wordText,
      if (language != null) 'language': language,
      if (entryType != null) 'entry_type': entryType,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WordEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? wordText,
      Value<String>? language,
      Value<String>? entryType,
      Value<String>? source,
      Value<DateTime>? createdAt}) {
    return WordEntriesCompanion(
      id: id ?? this.id,
      wordText: wordText ?? this.wordText,
      language: language ?? this.language,
      entryType: entryType ?? this.entryType,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordText.present) {
      map['word_text'] = Variable<String>(wordText.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (entryType.present) {
      map['entry_type'] = Variable<String>(entryType.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordEntriesCompanion(')
          ..write('id: $id, ')
          ..write('wordText: $wordText, ')
          ..write('language: $language, ')
          ..write('entryType: $entryType, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TranslationsTable extends Translations
    with TableInfo<$TranslationsTable, Translation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
      'word_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES word_entries (id) ON DELETE CASCADE'));
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _translatedTextMeta =
      const VerificationMeta('translatedText');
  @override
  late final GeneratedColumn<String> translatedText = GeneratedColumn<String>(
      'translated_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, wordId, language, translatedText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'translations';
  @override
  VerificationContext validateIntegrity(Insertable<Translation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(_wordIdMeta,
          wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('translated_text')) {
      context.handle(
          _translatedTextMeta,
          translatedText.isAcceptableOrUnknown(
              data['translated_text']!, _translatedTextMeta));
    } else if (isInserting) {
      context.missing(_translatedTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Translation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Translation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wordId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_id'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      translatedText: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}translated_text'])!,
    );
  }

  @override
  $TranslationsTable createAlias(String alias) {
    return $TranslationsTable(attachedDatabase, alias);
  }
}

class Translation extends DataClass implements Insertable<Translation> {
  final int id;
  final int wordId;
  final String language;
  final String translatedText;
  const Translation(
      {required this.id,
      required this.wordId,
      required this.language,
      required this.translatedText});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['language'] = Variable<String>(language);
    map['translated_text'] = Variable<String>(translatedText);
    return map;
  }

  TranslationsCompanion toCompanion(bool nullToAbsent) {
    return TranslationsCompanion(
      id: Value(id),
      wordId: Value(wordId),
      language: Value(language),
      translatedText: Value(translatedText),
    );
  }

  factory Translation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Translation(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      language: serializer.fromJson<String>(json['language']),
      translatedText: serializer.fromJson<String>(json['translatedText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'language': serializer.toJson<String>(language),
      'translatedText': serializer.toJson<String>(translatedText),
    };
  }

  Translation copyWith(
          {int? id, int? wordId, String? language, String? translatedText}) =>
      Translation(
        id: id ?? this.id,
        wordId: wordId ?? this.wordId,
        language: language ?? this.language,
        translatedText: translatedText ?? this.translatedText,
      );
  Translation copyWithCompanion(TranslationsCompanion data) {
    return Translation(
      id: data.id.present ? data.id.value : this.id,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      language: data.language.present ? data.language.value : this.language,
      translatedText: data.translatedText.present
          ? data.translatedText.value
          : this.translatedText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Translation(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('language: $language, ')
          ..write('translatedText: $translatedText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wordId, language, translatedText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Translation &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.language == this.language &&
          other.translatedText == this.translatedText);
}

class TranslationsCompanion extends UpdateCompanion<Translation> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<String> language;
  final Value<String> translatedText;
  const TranslationsCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.language = const Value.absent(),
    this.translatedText = const Value.absent(),
  });
  TranslationsCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required String language,
    required String translatedText,
  })  : wordId = Value(wordId),
        language = Value(language),
        translatedText = Value(translatedText);
  static Insertable<Translation> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<String>? language,
    Expression<String>? translatedText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (language != null) 'language': language,
      if (translatedText != null) 'translated_text': translatedText,
    });
  }

  TranslationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? wordId,
      Value<String>? language,
      Value<String>? translatedText}) {
    return TranslationsCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      language: language ?? this.language,
      translatedText: translatedText ?? this.translatedText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (translatedText.present) {
      map['translated_text'] = Variable<String>(translatedText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TranslationsCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('language: $language, ')
          ..write('translatedText: $translatedText')
          ..write(')'))
        .toString();
  }
}

class $WordMeaningsTable extends WordMeanings
    with TableInfo<$WordMeaningsTable, WordMeaning> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordMeaningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
      'word_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES word_entries (id) ON DELETE CASCADE'));
  static const VerificationMeta _definitionMeta =
      const VerificationMeta('definition');
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
      'definition', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, wordId, definition];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_meanings';
  @override
  VerificationContext validateIntegrity(Insertable<WordMeaning> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(_wordIdMeta,
          wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
          _definitionMeta,
          definition.isAcceptableOrUnknown(
              data['definition']!, _definitionMeta));
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordMeaning map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordMeaning(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wordId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_id'])!,
      definition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}definition'])!,
    );
  }

  @override
  $WordMeaningsTable createAlias(String alias) {
    return $WordMeaningsTable(attachedDatabase, alias);
  }
}

class WordMeaning extends DataClass implements Insertable<WordMeaning> {
  final int id;
  final int wordId;
  final String definition;
  const WordMeaning(
      {required this.id, required this.wordId, required this.definition});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['definition'] = Variable<String>(definition);
    return map;
  }

  WordMeaningsCompanion toCompanion(bool nullToAbsent) {
    return WordMeaningsCompanion(
      id: Value(id),
      wordId: Value(wordId),
      definition: Value(definition),
    );
  }

  factory WordMeaning.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordMeaning(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      definition: serializer.fromJson<String>(json['definition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'definition': serializer.toJson<String>(definition),
    };
  }

  WordMeaning copyWith({int? id, int? wordId, String? definition}) =>
      WordMeaning(
        id: id ?? this.id,
        wordId: wordId ?? this.wordId,
        definition: definition ?? this.definition,
      );
  WordMeaning copyWithCompanion(WordMeaningsCompanion data) {
    return WordMeaning(
      id: data.id.present ? data.id.value : this.id,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      definition:
          data.definition.present ? data.definition.value : this.definition,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordMeaning(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wordId, definition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordMeaning &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.definition == this.definition);
}

class WordMeaningsCompanion extends UpdateCompanion<WordMeaning> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<String> definition;
  const WordMeaningsCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.definition = const Value.absent(),
  });
  WordMeaningsCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required String definition,
  })  : wordId = Value(wordId),
        definition = Value(definition);
  static Insertable<WordMeaning> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<String>? definition,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (definition != null) 'definition': definition,
    });
  }

  WordMeaningsCompanion copyWith(
      {Value<int>? id, Value<int>? wordId, Value<String>? definition}) {
    return WordMeaningsCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      definition: definition ?? this.definition,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordMeaningsCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }
}

class $WordExamplesTable extends WordExamples
    with TableInfo<$WordExamplesTable, WordExample> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordExamplesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
      'word_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES word_entries (id) ON DELETE CASCADE'));
  static const VerificationMeta _exampleTextMeta =
      const VerificationMeta('exampleText');
  @override
  late final GeneratedColumn<String> exampleText = GeneratedColumn<String>(
      'example_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, wordId, exampleText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_examples';
  @override
  VerificationContext validateIntegrity(Insertable<WordExample> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(_wordIdMeta,
          wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('example_text')) {
      context.handle(
          _exampleTextMeta,
          exampleText.isAcceptableOrUnknown(
              data['example_text']!, _exampleTextMeta));
    } else if (isInserting) {
      context.missing(_exampleTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordExample map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordExample(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wordId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_id'])!,
      exampleText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}example_text'])!,
    );
  }

  @override
  $WordExamplesTable createAlias(String alias) {
    return $WordExamplesTable(attachedDatabase, alias);
  }
}

class WordExample extends DataClass implements Insertable<WordExample> {
  final int id;
  final int wordId;
  final String exampleText;
  const WordExample(
      {required this.id, required this.wordId, required this.exampleText});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['example_text'] = Variable<String>(exampleText);
    return map;
  }

  WordExamplesCompanion toCompanion(bool nullToAbsent) {
    return WordExamplesCompanion(
      id: Value(id),
      wordId: Value(wordId),
      exampleText: Value(exampleText),
    );
  }

  factory WordExample.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordExample(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      exampleText: serializer.fromJson<String>(json['exampleText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'exampleText': serializer.toJson<String>(exampleText),
    };
  }

  WordExample copyWith({int? id, int? wordId, String? exampleText}) =>
      WordExample(
        id: id ?? this.id,
        wordId: wordId ?? this.wordId,
        exampleText: exampleText ?? this.exampleText,
      );
  WordExample copyWithCompanion(WordExamplesCompanion data) {
    return WordExample(
      id: data.id.present ? data.id.value : this.id,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      exampleText:
          data.exampleText.present ? data.exampleText.value : this.exampleText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordExample(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('exampleText: $exampleText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wordId, exampleText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordExample &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.exampleText == this.exampleText);
}

class WordExamplesCompanion extends UpdateCompanion<WordExample> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<String> exampleText;
  const WordExamplesCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.exampleText = const Value.absent(),
  });
  WordExamplesCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required String exampleText,
  })  : wordId = Value(wordId),
        exampleText = Value(exampleText);
  static Insertable<WordExample> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<String>? exampleText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (exampleText != null) 'example_text': exampleText,
    });
  }

  WordExamplesCompanion copyWith(
      {Value<int>? id, Value<int>? wordId, Value<String>? exampleText}) {
    return WordExamplesCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      exampleText: exampleText ?? this.exampleText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (exampleText.present) {
      map['example_text'] = Variable<String>(exampleText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordExamplesCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('exampleText: $exampleText')
          ..write(')'))
        .toString();
  }
}

class $WordSynonymsTable extends WordSynonyms
    with TableInfo<$WordSynonymsTable, WordSynonym> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordSynonymsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
      'word_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES word_entries (id) ON DELETE CASCADE'));
  static const VerificationMeta _synonymTextMeta =
      const VerificationMeta('synonymText');
  @override
  late final GeneratedColumn<String> synonymText = GeneratedColumn<String>(
      'synonym_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, wordId, synonymText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_synonyms';
  @override
  VerificationContext validateIntegrity(Insertable<WordSynonym> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(_wordIdMeta,
          wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('synonym_text')) {
      context.handle(
          _synonymTextMeta,
          synonymText.isAcceptableOrUnknown(
              data['synonym_text']!, _synonymTextMeta));
    } else if (isInserting) {
      context.missing(_synonymTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordSynonym map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordSynonym(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wordId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_id'])!,
      synonymText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}synonym_text'])!,
    );
  }

  @override
  $WordSynonymsTable createAlias(String alias) {
    return $WordSynonymsTable(attachedDatabase, alias);
  }
}

class WordSynonym extends DataClass implements Insertable<WordSynonym> {
  final int id;
  final int wordId;
  final String synonymText;
  const WordSynonym(
      {required this.id, required this.wordId, required this.synonymText});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['synonym_text'] = Variable<String>(synonymText);
    return map;
  }

  WordSynonymsCompanion toCompanion(bool nullToAbsent) {
    return WordSynonymsCompanion(
      id: Value(id),
      wordId: Value(wordId),
      synonymText: Value(synonymText),
    );
  }

  factory WordSynonym.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordSynonym(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      synonymText: serializer.fromJson<String>(json['synonymText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'synonymText': serializer.toJson<String>(synonymText),
    };
  }

  WordSynonym copyWith({int? id, int? wordId, String? synonymText}) =>
      WordSynonym(
        id: id ?? this.id,
        wordId: wordId ?? this.wordId,
        synonymText: synonymText ?? this.synonymText,
      );
  WordSynonym copyWithCompanion(WordSynonymsCompanion data) {
    return WordSynonym(
      id: data.id.present ? data.id.value : this.id,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      synonymText:
          data.synonymText.present ? data.synonymText.value : this.synonymText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordSynonym(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('synonymText: $synonymText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wordId, synonymText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordSynonym &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.synonymText == this.synonymText);
}

class WordSynonymsCompanion extends UpdateCompanion<WordSynonym> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<String> synonymText;
  const WordSynonymsCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.synonymText = const Value.absent(),
  });
  WordSynonymsCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required String synonymText,
  })  : wordId = Value(wordId),
        synonymText = Value(synonymText);
  static Insertable<WordSynonym> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<String>? synonymText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (synonymText != null) 'synonym_text': synonymText,
    });
  }

  WordSynonymsCompanion copyWith(
      {Value<int>? id, Value<int>? wordId, Value<String>? synonymText}) {
    return WordSynonymsCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      synonymText: synonymText ?? this.synonymText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (synonymText.present) {
      map['synonym_text'] = Variable<String>(synonymText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordSynonymsCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('synonymText: $synonymText')
          ..write(')'))
        .toString();
  }
}

class $WordNotesTable extends WordNotes
    with TableInfo<$WordNotesTable, WordNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
      'word_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES word_entries (id) ON DELETE CASCADE'));
  static const VerificationMeta _noteTextMeta =
      const VerificationMeta('noteText');
  @override
  late final GeneratedColumn<String> noteText = GeneratedColumn<String>(
      'note_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, wordId, noteText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_notes';
  @override
  VerificationContext validateIntegrity(Insertable<WordNote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(_wordIdMeta,
          wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('note_text')) {
      context.handle(_noteTextMeta,
          noteText.isAcceptableOrUnknown(data['note_text']!, _noteTextMeta));
    } else if (isInserting) {
      context.missing(_noteTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordNote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wordId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_id'])!,
      noteText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_text'])!,
    );
  }

  @override
  $WordNotesTable createAlias(String alias) {
    return $WordNotesTable(attachedDatabase, alias);
  }
}

class WordNote extends DataClass implements Insertable<WordNote> {
  final int id;
  final int wordId;
  final String noteText;
  const WordNote(
      {required this.id, required this.wordId, required this.noteText});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['note_text'] = Variable<String>(noteText);
    return map;
  }

  WordNotesCompanion toCompanion(bool nullToAbsent) {
    return WordNotesCompanion(
      id: Value(id),
      wordId: Value(wordId),
      noteText: Value(noteText),
    );
  }

  factory WordNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordNote(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      noteText: serializer.fromJson<String>(json['noteText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'noteText': serializer.toJson<String>(noteText),
    };
  }

  WordNote copyWith({int? id, int? wordId, String? noteText}) => WordNote(
        id: id ?? this.id,
        wordId: wordId ?? this.wordId,
        noteText: noteText ?? this.noteText,
      );
  WordNote copyWithCompanion(WordNotesCompanion data) {
    return WordNote(
      id: data.id.present ? data.id.value : this.id,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      noteText: data.noteText.present ? data.noteText.value : this.noteText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordNote(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('noteText: $noteText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wordId, noteText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordNote &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.noteText == this.noteText);
}

class WordNotesCompanion extends UpdateCompanion<WordNote> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<String> noteText;
  const WordNotesCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.noteText = const Value.absent(),
  });
  WordNotesCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required String noteText,
  })  : wordId = Value(wordId),
        noteText = Value(noteText);
  static Insertable<WordNote> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<String>? noteText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (noteText != null) 'note_text': noteText,
    });
  }

  WordNotesCompanion copyWith(
      {Value<int>? id, Value<int>? wordId, Value<String>? noteText}) {
    return WordNotesCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      noteText: noteText ?? this.noteText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (noteText.present) {
      map['note_text'] = Variable<String>(noteText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordNotesCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('noteText: $noteText')
          ..write(')'))
        .toString();
  }
}

class $WordLearningDataTable extends WordLearningData
    with TableInfo<$WordLearningDataTable, WordLearningDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordLearningDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
      'word_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES word_entries (id) ON DELETE CASCADE'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastReviewedMeta =
      const VerificationMeta('lastReviewed');
  @override
  late final GeneratedColumn<DateTime> lastReviewed = GeneratedColumn<DateTime>(
      'last_reviewed', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _timesPracticedMeta =
      const VerificationMeta('timesPracticed');
  @override
  late final GeneratedColumn<int> timesPracticed = GeneratedColumn<int>(
      'times_practiced', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [wordId, status, lastReviewed, timesPracticed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_learning_data';
  @override
  VerificationContext validateIntegrity(
      Insertable<WordLearningDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_id')) {
      context.handle(_wordIdMeta,
          wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('last_reviewed')) {
      context.handle(
          _lastReviewedMeta,
          lastReviewed.isAcceptableOrUnknown(
              data['last_reviewed']!, _lastReviewedMeta));
    }
    if (data.containsKey('times_practiced')) {
      context.handle(
          _timesPracticedMeta,
          timesPracticed.isAcceptableOrUnknown(
              data['times_practiced']!, _timesPracticedMeta));
    } else if (isInserting) {
      context.missing(_timesPracticedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordId};
  @override
  WordLearningDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordLearningDataData(
      wordId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}word_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      lastReviewed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_reviewed']),
      timesPracticed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_practiced'])!,
    );
  }

  @override
  $WordLearningDataTable createAlias(String alias) {
    return $WordLearningDataTable(attachedDatabase, alias);
  }
}

class WordLearningDataData extends DataClass
    implements Insertable<WordLearningDataData> {
  final int wordId;
  final String status;
  final DateTime? lastReviewed;
  final int timesPracticed;
  const WordLearningDataData(
      {required this.wordId,
      required this.status,
      this.lastReviewed,
      required this.timesPracticed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_id'] = Variable<int>(wordId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastReviewed != null) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed);
    }
    map['times_practiced'] = Variable<int>(timesPracticed);
    return map;
  }

  WordLearningDataCompanion toCompanion(bool nullToAbsent) {
    return WordLearningDataCompanion(
      wordId: Value(wordId),
      status: Value(status),
      lastReviewed: lastReviewed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewed),
      timesPracticed: Value(timesPracticed),
    );
  }

  factory WordLearningDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordLearningDataData(
      wordId: serializer.fromJson<int>(json['wordId']),
      status: serializer.fromJson<String>(json['status']),
      lastReviewed: serializer.fromJson<DateTime?>(json['lastReviewed']),
      timesPracticed: serializer.fromJson<int>(json['timesPracticed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordId': serializer.toJson<int>(wordId),
      'status': serializer.toJson<String>(status),
      'lastReviewed': serializer.toJson<DateTime?>(lastReviewed),
      'timesPracticed': serializer.toJson<int>(timesPracticed),
    };
  }

  WordLearningDataData copyWith(
          {int? wordId,
          String? status,
          Value<DateTime?> lastReviewed = const Value.absent(),
          int? timesPracticed}) =>
      WordLearningDataData(
        wordId: wordId ?? this.wordId,
        status: status ?? this.status,
        lastReviewed:
            lastReviewed.present ? lastReviewed.value : this.lastReviewed,
        timesPracticed: timesPracticed ?? this.timesPracticed,
      );
  WordLearningDataData copyWithCompanion(WordLearningDataCompanion data) {
    return WordLearningDataData(
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      status: data.status.present ? data.status.value : this.status,
      lastReviewed: data.lastReviewed.present
          ? data.lastReviewed.value
          : this.lastReviewed,
      timesPracticed: data.timesPracticed.present
          ? data.timesPracticed.value
          : this.timesPracticed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordLearningDataData(')
          ..write('wordId: $wordId, ')
          ..write('status: $status, ')
          ..write('lastReviewed: $lastReviewed, ')
          ..write('timesPracticed: $timesPracticed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(wordId, status, lastReviewed, timesPracticed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordLearningDataData &&
          other.wordId == this.wordId &&
          other.status == this.status &&
          other.lastReviewed == this.lastReviewed &&
          other.timesPracticed == this.timesPracticed);
}

class WordLearningDataCompanion extends UpdateCompanion<WordLearningDataData> {
  final Value<int> wordId;
  final Value<String> status;
  final Value<DateTime?> lastReviewed;
  final Value<int> timesPracticed;
  const WordLearningDataCompanion({
    this.wordId = const Value.absent(),
    this.status = const Value.absent(),
    this.lastReviewed = const Value.absent(),
    this.timesPracticed = const Value.absent(),
  });
  WordLearningDataCompanion.insert({
    this.wordId = const Value.absent(),
    required String status,
    this.lastReviewed = const Value.absent(),
    required int timesPracticed,
  })  : status = Value(status),
        timesPracticed = Value(timesPracticed);
  static Insertable<WordLearningDataData> custom({
    Expression<int>? wordId,
    Expression<String>? status,
    Expression<DateTime>? lastReviewed,
    Expression<int>? timesPracticed,
  }) {
    return RawValuesInsertable({
      if (wordId != null) 'word_id': wordId,
      if (status != null) 'status': status,
      if (lastReviewed != null) 'last_reviewed': lastReviewed,
      if (timesPracticed != null) 'times_practiced': timesPracticed,
    });
  }

  WordLearningDataCompanion copyWith(
      {Value<int>? wordId,
      Value<String>? status,
      Value<DateTime?>? lastReviewed,
      Value<int>? timesPracticed}) {
    return WordLearningDataCompanion(
      wordId: wordId ?? this.wordId,
      status: status ?? this.status,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      timesPracticed: timesPracticed ?? this.timesPracticed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastReviewed.present) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed.value);
    }
    if (timesPracticed.present) {
      map['times_practiced'] = Variable<int>(timesPracticed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordLearningDataCompanion(')
          ..write('wordId: $wordId, ')
          ..write('status: $status, ')
          ..write('lastReviewed: $lastReviewed, ')
          ..write('timesPracticed: $timesPracticed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordEntriesTable wordEntries = $WordEntriesTable(this);
  late final $TranslationsTable translations = $TranslationsTable(this);
  late final $WordMeaningsTable wordMeanings = $WordMeaningsTable(this);
  late final $WordExamplesTable wordExamples = $WordExamplesTable(this);
  late final $WordSynonymsTable wordSynonyms = $WordSynonymsTable(this);
  late final $WordNotesTable wordNotes = $WordNotesTable(this);
  late final $WordLearningDataTable wordLearningData =
      $WordLearningDataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        wordEntries,
        translations,
        wordMeanings,
        wordExamples,
        wordSynonyms,
        wordNotes,
        wordLearningData
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('word_entries',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('translations', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('word_entries',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('word_meanings', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('word_entries',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('word_examples', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('word_entries',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('word_synonyms', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('word_entries',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('word_notes', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('word_entries',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('word_learning_data', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$WordEntriesTableCreateCompanionBuilder = WordEntriesCompanion
    Function({
  Value<int> id,
  required String wordText,
  required String language,
  required String entryType,
  required String source,
  required DateTime createdAt,
});
typedef $$WordEntriesTableUpdateCompanionBuilder = WordEntriesCompanion
    Function({
  Value<int> id,
  Value<String> wordText,
  Value<String> language,
  Value<String> entryType,
  Value<String> source,
  Value<DateTime> createdAt,
});

final class $$WordEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $WordEntriesTable, WordEntry> {
  $$WordEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TranslationsTable, List<Translation>>
      _translationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.translations,
          aliasName:
              $_aliasNameGenerator(db.wordEntries.id, db.translations.wordId));

  $$TranslationsTableProcessedTableManager get translationsRefs {
    final manager = $$TranslationsTableTableManager($_db, $_db.translations)
        .filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_translationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WordMeaningsTable, List<WordMeaning>>
      _wordMeaningsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.wordMeanings,
          aliasName:
              $_aliasNameGenerator(db.wordEntries.id, db.wordMeanings.wordId));

  $$WordMeaningsTableProcessedTableManager get wordMeaningsRefs {
    final manager = $$WordMeaningsTableTableManager($_db, $_db.wordMeanings)
        .filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordMeaningsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WordExamplesTable, List<WordExample>>
      _wordExamplesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.wordExamples,
          aliasName:
              $_aliasNameGenerator(db.wordEntries.id, db.wordExamples.wordId));

  $$WordExamplesTableProcessedTableManager get wordExamplesRefs {
    final manager = $$WordExamplesTableTableManager($_db, $_db.wordExamples)
        .filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordExamplesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WordSynonymsTable, List<WordSynonym>>
      _wordSynonymsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.wordSynonyms,
          aliasName:
              $_aliasNameGenerator(db.wordEntries.id, db.wordSynonyms.wordId));

  $$WordSynonymsTableProcessedTableManager get wordSynonymsRefs {
    final manager = $$WordSynonymsTableTableManager($_db, $_db.wordSynonyms)
        .filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordSynonymsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WordNotesTable, List<WordNote>>
      _wordNotesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.wordNotes,
              aliasName:
                  $_aliasNameGenerator(db.wordEntries.id, db.wordNotes.wordId));

  $$WordNotesTableProcessedTableManager get wordNotesRefs {
    final manager = $$WordNotesTableTableManager($_db, $_db.wordNotes)
        .filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordNotesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WordLearningDataTable, List<WordLearningDataData>>
      _wordLearningDataRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.wordLearningData,
              aliasName: $_aliasNameGenerator(
                  db.wordEntries.id, db.wordLearningData.wordId));

  $$WordLearningDataTableProcessedTableManager get wordLearningDataRefs {
    final manager =
        $$WordLearningDataTableTableManager($_db, $_db.wordLearningData)
            .filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_wordLearningDataRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WordEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WordEntriesTable> {
  $$WordEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wordText => $composableBuilder(
      column: $table.wordText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entryType => $composableBuilder(
      column: $table.entryType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> translationsRefs(
      Expression<bool> Function($$TranslationsTableFilterComposer f) f) {
    final $$TranslationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.translations,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TranslationsTableFilterComposer(
              $db: $db,
              $table: $db.translations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> wordMeaningsRefs(
      Expression<bool> Function($$WordMeaningsTableFilterComposer f) f) {
    final $$WordMeaningsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordMeanings,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordMeaningsTableFilterComposer(
              $db: $db,
              $table: $db.wordMeanings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> wordExamplesRefs(
      Expression<bool> Function($$WordExamplesTableFilterComposer f) f) {
    final $$WordExamplesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordExamples,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordExamplesTableFilterComposer(
              $db: $db,
              $table: $db.wordExamples,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> wordSynonymsRefs(
      Expression<bool> Function($$WordSynonymsTableFilterComposer f) f) {
    final $$WordSynonymsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordSynonyms,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordSynonymsTableFilterComposer(
              $db: $db,
              $table: $db.wordSynonyms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> wordNotesRefs(
      Expression<bool> Function($$WordNotesTableFilterComposer f) f) {
    final $$WordNotesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordNotes,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordNotesTableFilterComposer(
              $db: $db,
              $table: $db.wordNotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> wordLearningDataRefs(
      Expression<bool> Function($$WordLearningDataTableFilterComposer f) f) {
    final $$WordLearningDataTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordLearningData,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordLearningDataTableFilterComposer(
              $db: $db,
              $table: $db.wordLearningData,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WordEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WordEntriesTable> {
  $$WordEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wordText => $composableBuilder(
      column: $table.wordText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entryType => $composableBuilder(
      column: $table.entryType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$WordEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordEntriesTable> {
  $$WordEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get wordText =>
      $composableBuilder(column: $table.wordText, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get entryType =>
      $composableBuilder(column: $table.entryType, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> translationsRefs<T extends Object>(
      Expression<T> Function($$TranslationsTableAnnotationComposer a) f) {
    final $$TranslationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.translations,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TranslationsTableAnnotationComposer(
              $db: $db,
              $table: $db.translations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> wordMeaningsRefs<T extends Object>(
      Expression<T> Function($$WordMeaningsTableAnnotationComposer a) f) {
    final $$WordMeaningsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordMeanings,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordMeaningsTableAnnotationComposer(
              $db: $db,
              $table: $db.wordMeanings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> wordExamplesRefs<T extends Object>(
      Expression<T> Function($$WordExamplesTableAnnotationComposer a) f) {
    final $$WordExamplesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordExamples,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordExamplesTableAnnotationComposer(
              $db: $db,
              $table: $db.wordExamples,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> wordSynonymsRefs<T extends Object>(
      Expression<T> Function($$WordSynonymsTableAnnotationComposer a) f) {
    final $$WordSynonymsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordSynonyms,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordSynonymsTableAnnotationComposer(
              $db: $db,
              $table: $db.wordSynonyms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> wordNotesRefs<T extends Object>(
      Expression<T> Function($$WordNotesTableAnnotationComposer a) f) {
    final $$WordNotesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordNotes,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordNotesTableAnnotationComposer(
              $db: $db,
              $table: $db.wordNotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> wordLearningDataRefs<T extends Object>(
      Expression<T> Function($$WordLearningDataTableAnnotationComposer a) f) {
    final $$WordLearningDataTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wordLearningData,
        getReferencedColumn: (t) => t.wordId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordLearningDataTableAnnotationComposer(
              $db: $db,
              $table: $db.wordLearningData,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WordEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordEntriesTable,
    WordEntry,
    $$WordEntriesTableFilterComposer,
    $$WordEntriesTableOrderingComposer,
    $$WordEntriesTableAnnotationComposer,
    $$WordEntriesTableCreateCompanionBuilder,
    $$WordEntriesTableUpdateCompanionBuilder,
    (WordEntry, $$WordEntriesTableReferences),
    WordEntry,
    PrefetchHooks Function(
        {bool translationsRefs,
        bool wordMeaningsRefs,
        bool wordExamplesRefs,
        bool wordSynonymsRefs,
        bool wordNotesRefs,
        bool wordLearningDataRefs})> {
  $$WordEntriesTableTableManager(_$AppDatabase db, $WordEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> wordText = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<String> entryType = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              WordEntriesCompanion(
            id: id,
            wordText: wordText,
            language: language,
            entryType: entryType,
            source: source,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String wordText,
            required String language,
            required String entryType,
            required String source,
            required DateTime createdAt,
          }) =>
              WordEntriesCompanion.insert(
            id: id,
            wordText: wordText,
            language: language,
            entryType: entryType,
            source: source,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WordEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {translationsRefs = false,
              wordMeaningsRefs = false,
              wordExamplesRefs = false,
              wordSynonymsRefs = false,
              wordNotesRefs = false,
              wordLearningDataRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (translationsRefs) db.translations,
                if (wordMeaningsRefs) db.wordMeanings,
                if (wordExamplesRefs) db.wordExamples,
                if (wordSynonymsRefs) db.wordSynonyms,
                if (wordNotesRefs) db.wordNotes,
                if (wordLearningDataRefs) db.wordLearningData
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (translationsRefs)
                    await $_getPrefetchedData<WordEntry, $WordEntriesTable,
                            Translation>(
                        currentTable: table,
                        referencedTable: $$WordEntriesTableReferences
                            ._translationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WordEntriesTableReferences(db, table, p0)
                                .translationsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wordId == item.id),
                        typedResults: items),
                  if (wordMeaningsRefs)
                    await $_getPrefetchedData<WordEntry, $WordEntriesTable,
                            WordMeaning>(
                        currentTable: table,
                        referencedTable: $$WordEntriesTableReferences
                            ._wordMeaningsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WordEntriesTableReferences(db, table, p0)
                                .wordMeaningsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wordId == item.id),
                        typedResults: items),
                  if (wordExamplesRefs)
                    await $_getPrefetchedData<WordEntry, $WordEntriesTable,
                            WordExample>(
                        currentTable: table,
                        referencedTable: $$WordEntriesTableReferences
                            ._wordExamplesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WordEntriesTableReferences(db, table, p0)
                                .wordExamplesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wordId == item.id),
                        typedResults: items),
                  if (wordSynonymsRefs)
                    await $_getPrefetchedData<WordEntry, $WordEntriesTable,
                            WordSynonym>(
                        currentTable: table,
                        referencedTable: $$WordEntriesTableReferences
                            ._wordSynonymsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WordEntriesTableReferences(db, table, p0)
                                .wordSynonymsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wordId == item.id),
                        typedResults: items),
                  if (wordNotesRefs)
                    await $_getPrefetchedData<WordEntry, $WordEntriesTable,
                            WordNote>(
                        currentTable: table,
                        referencedTable: $$WordEntriesTableReferences
                            ._wordNotesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WordEntriesTableReferences(db, table, p0)
                                .wordNotesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wordId == item.id),
                        typedResults: items),
                  if (wordLearningDataRefs)
                    await $_getPrefetchedData<WordEntry, $WordEntriesTable,
                            WordLearningDataData>(
                        currentTable: table,
                        referencedTable: $$WordEntriesTableReferences
                            ._wordLearningDataRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WordEntriesTableReferences(db, table, p0)
                                .wordLearningDataRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wordId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WordEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordEntriesTable,
    WordEntry,
    $$WordEntriesTableFilterComposer,
    $$WordEntriesTableOrderingComposer,
    $$WordEntriesTableAnnotationComposer,
    $$WordEntriesTableCreateCompanionBuilder,
    $$WordEntriesTableUpdateCompanionBuilder,
    (WordEntry, $$WordEntriesTableReferences),
    WordEntry,
    PrefetchHooks Function(
        {bool translationsRefs,
        bool wordMeaningsRefs,
        bool wordExamplesRefs,
        bool wordSynonymsRefs,
        bool wordNotesRefs,
        bool wordLearningDataRefs})>;
typedef $$TranslationsTableCreateCompanionBuilder = TranslationsCompanion
    Function({
  Value<int> id,
  required int wordId,
  required String language,
  required String translatedText,
});
typedef $$TranslationsTableUpdateCompanionBuilder = TranslationsCompanion
    Function({
  Value<int> id,
  Value<int> wordId,
  Value<String> language,
  Value<String> translatedText,
});

final class $$TranslationsTableReferences
    extends BaseReferences<_$AppDatabase, $TranslationsTable, Translation> {
  $$TranslationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordEntriesTable _wordIdTable(_$AppDatabase db) =>
      db.wordEntries.createAlias(
          $_aliasNameGenerator(db.translations.wordId, db.wordEntries.id));

  $$WordEntriesTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordEntriesTableTableManager($_db, $_db.wordEntries)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $TranslationsTable> {
  $$TranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get translatedText => $composableBuilder(
      column: $table.translatedText,
      builder: (column) => ColumnFilters(column));

  $$WordEntriesTableFilterComposer get wordId {
    final $$WordEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableFilterComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $TranslationsTable> {
  $$TranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translatedText => $composableBuilder(
      column: $table.translatedText,
      builder: (column) => ColumnOrderings(column));

  $$WordEntriesTableOrderingComposer get wordId {
    final $$WordEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TranslationsTable> {
  $$TranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get translatedText => $composableBuilder(
      column: $table.translatedText, builder: (column) => column);

  $$WordEntriesTableAnnotationComposer get wordId {
    final $$WordEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TranslationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TranslationsTable,
    Translation,
    $$TranslationsTableFilterComposer,
    $$TranslationsTableOrderingComposer,
    $$TranslationsTableAnnotationComposer,
    $$TranslationsTableCreateCompanionBuilder,
    $$TranslationsTableUpdateCompanionBuilder,
    (Translation, $$TranslationsTableReferences),
    Translation,
    PrefetchHooks Function({bool wordId})> {
  $$TranslationsTableTableManager(_$AppDatabase db, $TranslationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TranslationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TranslationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TranslationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> wordId = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<String> translatedText = const Value.absent(),
          }) =>
              TranslationsCompanion(
            id: id,
            wordId: wordId,
            language: language,
            translatedText: translatedText,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int wordId,
            required String language,
            required String translatedText,
          }) =>
              TranslationsCompanion.insert(
            id: id,
            wordId: wordId,
            language: language,
            translatedText: translatedText,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TranslationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wordId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wordId,
                    referencedTable:
                        $$TranslationsTableReferences._wordIdTable(db),
                    referencedColumn:
                        $$TranslationsTableReferences._wordIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TranslationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TranslationsTable,
    Translation,
    $$TranslationsTableFilterComposer,
    $$TranslationsTableOrderingComposer,
    $$TranslationsTableAnnotationComposer,
    $$TranslationsTableCreateCompanionBuilder,
    $$TranslationsTableUpdateCompanionBuilder,
    (Translation, $$TranslationsTableReferences),
    Translation,
    PrefetchHooks Function({bool wordId})>;
typedef $$WordMeaningsTableCreateCompanionBuilder = WordMeaningsCompanion
    Function({
  Value<int> id,
  required int wordId,
  required String definition,
});
typedef $$WordMeaningsTableUpdateCompanionBuilder = WordMeaningsCompanion
    Function({
  Value<int> id,
  Value<int> wordId,
  Value<String> definition,
});

final class $$WordMeaningsTableReferences
    extends BaseReferences<_$AppDatabase, $WordMeaningsTable, WordMeaning> {
  $$WordMeaningsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordEntriesTable _wordIdTable(_$AppDatabase db) =>
      db.wordEntries.createAlias(
          $_aliasNameGenerator(db.wordMeanings.wordId, db.wordEntries.id));

  $$WordEntriesTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordEntriesTableTableManager($_db, $_db.wordEntries)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WordMeaningsTableFilterComposer
    extends Composer<_$AppDatabase, $WordMeaningsTable> {
  $$WordMeaningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get definition => $composableBuilder(
      column: $table.definition, builder: (column) => ColumnFilters(column));

  $$WordEntriesTableFilterComposer get wordId {
    final $$WordEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableFilterComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordMeaningsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordMeaningsTable> {
  $$WordMeaningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get definition => $composableBuilder(
      column: $table.definition, builder: (column) => ColumnOrderings(column));

  $$WordEntriesTableOrderingComposer get wordId {
    final $$WordEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordMeaningsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordMeaningsTable> {
  $$WordMeaningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get definition => $composableBuilder(
      column: $table.definition, builder: (column) => column);

  $$WordEntriesTableAnnotationComposer get wordId {
    final $$WordEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordMeaningsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordMeaningsTable,
    WordMeaning,
    $$WordMeaningsTableFilterComposer,
    $$WordMeaningsTableOrderingComposer,
    $$WordMeaningsTableAnnotationComposer,
    $$WordMeaningsTableCreateCompanionBuilder,
    $$WordMeaningsTableUpdateCompanionBuilder,
    (WordMeaning, $$WordMeaningsTableReferences),
    WordMeaning,
    PrefetchHooks Function({bool wordId})> {
  $$WordMeaningsTableTableManager(_$AppDatabase db, $WordMeaningsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordMeaningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordMeaningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordMeaningsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> wordId = const Value.absent(),
            Value<String> definition = const Value.absent(),
          }) =>
              WordMeaningsCompanion(
            id: id,
            wordId: wordId,
            definition: definition,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int wordId,
            required String definition,
          }) =>
              WordMeaningsCompanion.insert(
            id: id,
            wordId: wordId,
            definition: definition,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WordMeaningsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wordId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wordId,
                    referencedTable:
                        $$WordMeaningsTableReferences._wordIdTable(db),
                    referencedColumn:
                        $$WordMeaningsTableReferences._wordIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WordMeaningsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordMeaningsTable,
    WordMeaning,
    $$WordMeaningsTableFilterComposer,
    $$WordMeaningsTableOrderingComposer,
    $$WordMeaningsTableAnnotationComposer,
    $$WordMeaningsTableCreateCompanionBuilder,
    $$WordMeaningsTableUpdateCompanionBuilder,
    (WordMeaning, $$WordMeaningsTableReferences),
    WordMeaning,
    PrefetchHooks Function({bool wordId})>;
typedef $$WordExamplesTableCreateCompanionBuilder = WordExamplesCompanion
    Function({
  Value<int> id,
  required int wordId,
  required String exampleText,
});
typedef $$WordExamplesTableUpdateCompanionBuilder = WordExamplesCompanion
    Function({
  Value<int> id,
  Value<int> wordId,
  Value<String> exampleText,
});

final class $$WordExamplesTableReferences
    extends BaseReferences<_$AppDatabase, $WordExamplesTable, WordExample> {
  $$WordExamplesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordEntriesTable _wordIdTable(_$AppDatabase db) =>
      db.wordEntries.createAlias(
          $_aliasNameGenerator(db.wordExamples.wordId, db.wordEntries.id));

  $$WordEntriesTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordEntriesTableTableManager($_db, $_db.wordEntries)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WordExamplesTableFilterComposer
    extends Composer<_$AppDatabase, $WordExamplesTable> {
  $$WordExamplesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exampleText => $composableBuilder(
      column: $table.exampleText, builder: (column) => ColumnFilters(column));

  $$WordEntriesTableFilterComposer get wordId {
    final $$WordEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableFilterComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordExamplesTableOrderingComposer
    extends Composer<_$AppDatabase, $WordExamplesTable> {
  $$WordExamplesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exampleText => $composableBuilder(
      column: $table.exampleText, builder: (column) => ColumnOrderings(column));

  $$WordEntriesTableOrderingComposer get wordId {
    final $$WordEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordExamplesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordExamplesTable> {
  $$WordExamplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exampleText => $composableBuilder(
      column: $table.exampleText, builder: (column) => column);

  $$WordEntriesTableAnnotationComposer get wordId {
    final $$WordEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordExamplesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordExamplesTable,
    WordExample,
    $$WordExamplesTableFilterComposer,
    $$WordExamplesTableOrderingComposer,
    $$WordExamplesTableAnnotationComposer,
    $$WordExamplesTableCreateCompanionBuilder,
    $$WordExamplesTableUpdateCompanionBuilder,
    (WordExample, $$WordExamplesTableReferences),
    WordExample,
    PrefetchHooks Function({bool wordId})> {
  $$WordExamplesTableTableManager(_$AppDatabase db, $WordExamplesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordExamplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordExamplesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordExamplesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> wordId = const Value.absent(),
            Value<String> exampleText = const Value.absent(),
          }) =>
              WordExamplesCompanion(
            id: id,
            wordId: wordId,
            exampleText: exampleText,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int wordId,
            required String exampleText,
          }) =>
              WordExamplesCompanion.insert(
            id: id,
            wordId: wordId,
            exampleText: exampleText,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WordExamplesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wordId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wordId,
                    referencedTable:
                        $$WordExamplesTableReferences._wordIdTable(db),
                    referencedColumn:
                        $$WordExamplesTableReferences._wordIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WordExamplesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordExamplesTable,
    WordExample,
    $$WordExamplesTableFilterComposer,
    $$WordExamplesTableOrderingComposer,
    $$WordExamplesTableAnnotationComposer,
    $$WordExamplesTableCreateCompanionBuilder,
    $$WordExamplesTableUpdateCompanionBuilder,
    (WordExample, $$WordExamplesTableReferences),
    WordExample,
    PrefetchHooks Function({bool wordId})>;
typedef $$WordSynonymsTableCreateCompanionBuilder = WordSynonymsCompanion
    Function({
  Value<int> id,
  required int wordId,
  required String synonymText,
});
typedef $$WordSynonymsTableUpdateCompanionBuilder = WordSynonymsCompanion
    Function({
  Value<int> id,
  Value<int> wordId,
  Value<String> synonymText,
});

final class $$WordSynonymsTableReferences
    extends BaseReferences<_$AppDatabase, $WordSynonymsTable, WordSynonym> {
  $$WordSynonymsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordEntriesTable _wordIdTable(_$AppDatabase db) =>
      db.wordEntries.createAlias(
          $_aliasNameGenerator(db.wordSynonyms.wordId, db.wordEntries.id));

  $$WordEntriesTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordEntriesTableTableManager($_db, $_db.wordEntries)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WordSynonymsTableFilterComposer
    extends Composer<_$AppDatabase, $WordSynonymsTable> {
  $$WordSynonymsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get synonymText => $composableBuilder(
      column: $table.synonymText, builder: (column) => ColumnFilters(column));

  $$WordEntriesTableFilterComposer get wordId {
    final $$WordEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableFilterComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordSynonymsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordSynonymsTable> {
  $$WordSynonymsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get synonymText => $composableBuilder(
      column: $table.synonymText, builder: (column) => ColumnOrderings(column));

  $$WordEntriesTableOrderingComposer get wordId {
    final $$WordEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordSynonymsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordSynonymsTable> {
  $$WordSynonymsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get synonymText => $composableBuilder(
      column: $table.synonymText, builder: (column) => column);

  $$WordEntriesTableAnnotationComposer get wordId {
    final $$WordEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordSynonymsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordSynonymsTable,
    WordSynonym,
    $$WordSynonymsTableFilterComposer,
    $$WordSynonymsTableOrderingComposer,
    $$WordSynonymsTableAnnotationComposer,
    $$WordSynonymsTableCreateCompanionBuilder,
    $$WordSynonymsTableUpdateCompanionBuilder,
    (WordSynonym, $$WordSynonymsTableReferences),
    WordSynonym,
    PrefetchHooks Function({bool wordId})> {
  $$WordSynonymsTableTableManager(_$AppDatabase db, $WordSynonymsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordSynonymsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordSynonymsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordSynonymsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> wordId = const Value.absent(),
            Value<String> synonymText = const Value.absent(),
          }) =>
              WordSynonymsCompanion(
            id: id,
            wordId: wordId,
            synonymText: synonymText,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int wordId,
            required String synonymText,
          }) =>
              WordSynonymsCompanion.insert(
            id: id,
            wordId: wordId,
            synonymText: synonymText,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WordSynonymsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wordId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wordId,
                    referencedTable:
                        $$WordSynonymsTableReferences._wordIdTable(db),
                    referencedColumn:
                        $$WordSynonymsTableReferences._wordIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WordSynonymsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordSynonymsTable,
    WordSynonym,
    $$WordSynonymsTableFilterComposer,
    $$WordSynonymsTableOrderingComposer,
    $$WordSynonymsTableAnnotationComposer,
    $$WordSynonymsTableCreateCompanionBuilder,
    $$WordSynonymsTableUpdateCompanionBuilder,
    (WordSynonym, $$WordSynonymsTableReferences),
    WordSynonym,
    PrefetchHooks Function({bool wordId})>;
typedef $$WordNotesTableCreateCompanionBuilder = WordNotesCompanion Function({
  Value<int> id,
  required int wordId,
  required String noteText,
});
typedef $$WordNotesTableUpdateCompanionBuilder = WordNotesCompanion Function({
  Value<int> id,
  Value<int> wordId,
  Value<String> noteText,
});

final class $$WordNotesTableReferences
    extends BaseReferences<_$AppDatabase, $WordNotesTable, WordNote> {
  $$WordNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordEntriesTable _wordIdTable(_$AppDatabase db) =>
      db.wordEntries.createAlias(
          $_aliasNameGenerator(db.wordNotes.wordId, db.wordEntries.id));

  $$WordEntriesTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordEntriesTableTableManager($_db, $_db.wordEntries)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WordNotesTableFilterComposer
    extends Composer<_$AppDatabase, $WordNotesTable> {
  $$WordNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get noteText => $composableBuilder(
      column: $table.noteText, builder: (column) => ColumnFilters(column));

  $$WordEntriesTableFilterComposer get wordId {
    final $$WordEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableFilterComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $WordNotesTable> {
  $$WordNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get noteText => $composableBuilder(
      column: $table.noteText, builder: (column) => ColumnOrderings(column));

  $$WordEntriesTableOrderingComposer get wordId {
    final $$WordEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordNotesTable> {
  $$WordNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get noteText =>
      $composableBuilder(column: $table.noteText, builder: (column) => column);

  $$WordEntriesTableAnnotationComposer get wordId {
    final $$WordEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordNotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordNotesTable,
    WordNote,
    $$WordNotesTableFilterComposer,
    $$WordNotesTableOrderingComposer,
    $$WordNotesTableAnnotationComposer,
    $$WordNotesTableCreateCompanionBuilder,
    $$WordNotesTableUpdateCompanionBuilder,
    (WordNote, $$WordNotesTableReferences),
    WordNote,
    PrefetchHooks Function({bool wordId})> {
  $$WordNotesTableTableManager(_$AppDatabase db, $WordNotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> wordId = const Value.absent(),
            Value<String> noteText = const Value.absent(),
          }) =>
              WordNotesCompanion(
            id: id,
            wordId: wordId,
            noteText: noteText,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int wordId,
            required String noteText,
          }) =>
              WordNotesCompanion.insert(
            id: id,
            wordId: wordId,
            noteText: noteText,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WordNotesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wordId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wordId,
                    referencedTable:
                        $$WordNotesTableReferences._wordIdTable(db),
                    referencedColumn:
                        $$WordNotesTableReferences._wordIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WordNotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordNotesTable,
    WordNote,
    $$WordNotesTableFilterComposer,
    $$WordNotesTableOrderingComposer,
    $$WordNotesTableAnnotationComposer,
    $$WordNotesTableCreateCompanionBuilder,
    $$WordNotesTableUpdateCompanionBuilder,
    (WordNote, $$WordNotesTableReferences),
    WordNote,
    PrefetchHooks Function({bool wordId})>;
typedef $$WordLearningDataTableCreateCompanionBuilder
    = WordLearningDataCompanion Function({
  Value<int> wordId,
  required String status,
  Value<DateTime?> lastReviewed,
  required int timesPracticed,
});
typedef $$WordLearningDataTableUpdateCompanionBuilder
    = WordLearningDataCompanion Function({
  Value<int> wordId,
  Value<String> status,
  Value<DateTime?> lastReviewed,
  Value<int> timesPracticed,
});

final class $$WordLearningDataTableReferences extends BaseReferences<
    _$AppDatabase, $WordLearningDataTable, WordLearningDataData> {
  $$WordLearningDataTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WordEntriesTable _wordIdTable(_$AppDatabase db) =>
      db.wordEntries.createAlias(
          $_aliasNameGenerator(db.wordLearningData.wordId, db.wordEntries.id));

  $$WordEntriesTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordEntriesTableTableManager($_db, $_db.wordEntries)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WordLearningDataTableFilterComposer
    extends Composer<_$AppDatabase, $WordLearningDataTable> {
  $$WordLearningDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastReviewed => $composableBuilder(
      column: $table.lastReviewed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesPracticed => $composableBuilder(
      column: $table.timesPracticed,
      builder: (column) => ColumnFilters(column));

  $$WordEntriesTableFilterComposer get wordId {
    final $$WordEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableFilterComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordLearningDataTableOrderingComposer
    extends Composer<_$AppDatabase, $WordLearningDataTable> {
  $$WordLearningDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastReviewed => $composableBuilder(
      column: $table.lastReviewed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesPracticed => $composableBuilder(
      column: $table.timesPracticed,
      builder: (column) => ColumnOrderings(column));

  $$WordEntriesTableOrderingComposer get wordId {
    final $$WordEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordLearningDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordLearningDataTable> {
  $$WordLearningDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReviewed => $composableBuilder(
      column: $table.lastReviewed, builder: (column) => column);

  GeneratedColumn<int> get timesPracticed => $composableBuilder(
      column: $table.timesPracticed, builder: (column) => column);

  $$WordEntriesTableAnnotationComposer get wordId {
    final $$WordEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wordId,
        referencedTable: $db.wordEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WordEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.wordEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WordLearningDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordLearningDataTable,
    WordLearningDataData,
    $$WordLearningDataTableFilterComposer,
    $$WordLearningDataTableOrderingComposer,
    $$WordLearningDataTableAnnotationComposer,
    $$WordLearningDataTableCreateCompanionBuilder,
    $$WordLearningDataTableUpdateCompanionBuilder,
    (WordLearningDataData, $$WordLearningDataTableReferences),
    WordLearningDataData,
    PrefetchHooks Function({bool wordId})> {
  $$WordLearningDataTableTableManager(
      _$AppDatabase db, $WordLearningDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordLearningDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordLearningDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordLearningDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> wordId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> lastReviewed = const Value.absent(),
            Value<int> timesPracticed = const Value.absent(),
          }) =>
              WordLearningDataCompanion(
            wordId: wordId,
            status: status,
            lastReviewed: lastReviewed,
            timesPracticed: timesPracticed,
          ),
          createCompanionCallback: ({
            Value<int> wordId = const Value.absent(),
            required String status,
            Value<DateTime?> lastReviewed = const Value.absent(),
            required int timesPracticed,
          }) =>
              WordLearningDataCompanion.insert(
            wordId: wordId,
            status: status,
            lastReviewed: lastReviewed,
            timesPracticed: timesPracticed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WordLearningDataTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wordId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wordId,
                    referencedTable:
                        $$WordLearningDataTableReferences._wordIdTable(db),
                    referencedColumn:
                        $$WordLearningDataTableReferences._wordIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WordLearningDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordLearningDataTable,
    WordLearningDataData,
    $$WordLearningDataTableFilterComposer,
    $$WordLearningDataTableOrderingComposer,
    $$WordLearningDataTableAnnotationComposer,
    $$WordLearningDataTableCreateCompanionBuilder,
    $$WordLearningDataTableUpdateCompanionBuilder,
    (WordLearningDataData, $$WordLearningDataTableReferences),
    WordLearningDataData,
    PrefetchHooks Function({bool wordId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WordEntriesTableTableManager get wordEntries =>
      $$WordEntriesTableTableManager(_db, _db.wordEntries);
  $$TranslationsTableTableManager get translations =>
      $$TranslationsTableTableManager(_db, _db.translations);
  $$WordMeaningsTableTableManager get wordMeanings =>
      $$WordMeaningsTableTableManager(_db, _db.wordMeanings);
  $$WordExamplesTableTableManager get wordExamples =>
      $$WordExamplesTableTableManager(_db, _db.wordExamples);
  $$WordSynonymsTableTableManager get wordSynonyms =>
      $$WordSynonymsTableTableManager(_db, _db.wordSynonyms);
  $$WordNotesTableTableManager get wordNotes =>
      $$WordNotesTableTableManager(_db, _db.wordNotes);
  $$WordLearningDataTableTableManager get wordLearningData =>
      $$WordLearningDataTableTableManager(_db, _db.wordLearningData);
}
