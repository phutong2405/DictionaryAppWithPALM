import 'package:hive/hive.dart';

part 'new_word_model.g.dart';

@HiveType(typeId: 0)
class DictionaryEntry {
  @HiveField(0)
  final String word;

  @HiveField(1)
  final Pronunciation pronunciation;

  @HiveField(2)
  final List<Meaning> meanings;

  @HiveField(3)
  final List<String> examples;

  @HiveField(4)
  bool inHistory;

  @HiveField(5)
  bool inFavorite;

  DictionaryEntry({
    required this.word,
    required this.pronunciation,
    required this.meanings,
    required this.examples,
  })  : inHistory = false,
        inFavorite = false;

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) {
    return DictionaryEntry(
        word: json['word'] ?? '',
        pronunciation: Pronunciation.fromJson(json['pronunciation']),
        meanings: List<Meaning>.from(
          json['meaning'].map((meaning) => Meaning.fromJson(meaning)),
        ),
        examples: List<String>.from(json['examples']));
  }

  @override
  bool operator ==(covariant DictionaryEntry other) => word == other.word;

  @override
  int get hashCode => word.hashCode;
}

@HiveType(typeId: 1)
class Pronunciation {
  @HiveField(0)
  final String ipa;
  @HiveField(1)
  final String audio;

  Pronunciation({required this.ipa, required this.audio});

  factory Pronunciation.fromJson(Map<String, dynamic> json) {
    return Pronunciation(
      ipa: json['ipa'] ?? '',
      audio: json['audio'] ?? '',
    );
  }
}

@HiveType(typeId: 2)
class Meaning {
  @HiveField(0)
  final String tag;
  @HiveField(1)
  final List<String> values;

  Meaning({required this.tag, required this.values});

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      tag: json['tag'] ?? '',
      values: List<String>.from(json['values']),
    );
  }
}
