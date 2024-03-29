import 'package:dictionary_app_1110/models/chat_model.dart';
import 'package:dictionary_app_1110/data/dummy_translation_data.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDataCubit extends Cubit<Iterable<DictionaryEntry>> {
  Iterable<DictionaryEntry> englishDictionary = [];
  Iterable<DictionaryEntry> vietnameseDictionary = [];

  AllDataCubit() : super([]);

  void update(Iterable<DictionaryEntry> entries) {
    emit(entries);
  }

  void setInHistory({required DictionaryEntry entry}) {
    List<DictionaryEntry> tmpList = state.toList();
    if (tmpList.contains(entry)) {
      emit(state.remove(entry: entry));
      emit(state.addAtElement(
          entry: entry, indexToInsert: tmpList.indexOf(entry)));
    }
  }

  void setInFavorite({required DictionaryEntry entry}) {
    List<DictionaryEntry> tmpList = state.toList();
    if (tmpList.contains(entry)) {
      emit(state.addAtElement(
          entry: entry, indexToInsert: tmpList.indexOf(entry)));
    }
  }

  void clearInHistory() {
    for (var element in state) {
      element.inHistory = false;
    }
    emit(state);
  }
}

class HistoryCubit extends Cubit<Iterable<DictionaryEntry>> {
  HistoryCubit() : super([]);

  void add({required DictionaryEntry entry}) {
    if (state.contains(entry)) {
      final List<DictionaryEntry> entries = state.toList();
      entries.removeAt(entries.indexOf(entry));
      emit(entries);
    }
    emit(
      state.addAtFirst(
        entry: entry,
      ),
    );
  }

  void setInFavorite({required DictionaryEntry entry}) {
    List<DictionaryEntry> tmpList = state.toList();
    if (tmpList.contains(entry)) {
      emit(state.addAtElement(
          entry: entry, indexToInsert: tmpList.indexOf(entry)));
    }
  }

  void removeAll() {
    final Iterable<DictionaryEntry> tmp = [];
    emit(tmp);
  }
}

class FavoriteCubit extends Cubit<Iterable<DictionaryEntry>> {
  FavoriteCubit() : super([]);

  void add({required DictionaryEntry entry}) {
    if (!state.contains(entry)) {
      emit(
        state.addAtFirst(
          entry: entry,
        ),
      );
    }
  }

  void remove({required DictionaryEntry entry}) {
    emit(state.remove(entry: entry));
  }
}

class SettingsCubit extends Cubit<Iterable<dynamic>> {
  SettingsCubit()
      : super([
          false,
          false,
          false,
          [true, false]
        ]);

  void setDarkMode(bool darkMode) {
    emit(
        [darkMode, state.elementAt(1), state.elementAt(2), state.elementAt(3)]);
  }

  bool isDarkMode() {
    return state.elementAt(0);
  }

  void setData({required List<dynamic> settingsData}) {
    emit(settingsData);
  }

  void setSimpleMode({required bool simpleMode}) {
    emit([
      state.elementAt(0),
      simpleMode,
      state.elementAt(2),
      state.elementAt(3)
    ]);
  }

  void setAutoLookup({required bool autoLookup}) {
    emit([
      state.elementAt(0),
      state.elementAt(1),
      autoLookup,
      state.elementAt(3)
    ]);
  }

  void setLanguages({required List<bool> list}) {
    emit([state.elementAt(0), state.elementAt(1), state.elementAt(2), list]);
  }

  bool isEnglish() {
    return state.elementAt(3)[0];
  }
}

class LanguageChoices extends Cubit<List<Iterable<LanguagesItem>>> {
  LanguageChoices()
      : super([
          languageIterable,
          [
            const LanguagesItem(
                title: 'English', status: true, icon: '🇺🇸', id: '1'),
          ]
        ]);

  void chooseById({required String id}) {
    List<Iterable<LanguagesItem>> list = state.toList();
    for (LanguagesItem element in list[0]) {
      if (element.id == id) {
        emit([
          languageIterable,
          [element]
        ]);
        break;
      }
    }
  }
}

class MessageCubit extends Cubit<Iterable<ChatMessage>> {
  MessageCubit() : super([]);

  void add({required ChatMessage message}) {
    emit([...state, message]);
  }

  void reset() {
    emit([]);
  }
}
