// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_word_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DictionaryEntryAdapter extends TypeAdapter<DictionaryEntry> {
  @override
  final int typeId = 0;

  @override
  DictionaryEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DictionaryEntry(
      word: fields[0] as String,
      pronunciation: fields[1] as Pronunciation,
      meanings: (fields[2] as List).cast<Meaning>(),
      examples: (fields[3] as List).cast<String>(),
    )
      ..inHistory = fields[4] as bool
      ..inFavorite = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, DictionaryEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.pronunciation)
      ..writeByte(2)
      ..write(obj.meanings)
      ..writeByte(3)
      ..write(obj.examples)
      ..writeByte(4)
      ..write(obj.inHistory)
      ..writeByte(5)
      ..write(obj.inFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DictionaryEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PronunciationAdapter extends TypeAdapter<Pronunciation> {
  @override
  final int typeId = 1;

  @override
  Pronunciation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pronunciation(
      ipa: fields[0] as String,
      audio: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pronunciation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ipa)
      ..writeByte(1)
      ..write(obj.audio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PronunciationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MeaningAdapter extends TypeAdapter<Meaning> {
  @override
  final int typeId = 2;

  @override
  Meaning read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meaning(
      tag: fields[0] as String,
      values: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Meaning obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.tag)
      ..writeByte(1)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeaningAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
