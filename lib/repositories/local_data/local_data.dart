import 'package:dictionary_app_1110/models/chat_model.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:hive/hive.dart';

enum TypeBox { entries, settings, favorites, history, cache, chat }

class LocalData {
  late Box<String> _cache;
  late Box<DictionaryEntry> _entriesBox;
  late Box<DictionaryEntry> _favoritesBox;
  late Box<DictionaryEntry> _historyBox;
  late Box<ChatMessage> _chatBox;
  late Box<dynamic> _settingsBox;
  LocalData._sharedInstance();
  static final LocalData _shared = LocalData._sharedInstance();
  factory LocalData.instance() => _shared;

  Future<void> initialOpenBox() async {
    _entriesBox = await Hive.openBox('entries');
    _settingsBox = await Hive.openBox('setting');
    _favoritesBox = await Hive.openBox('favorites');
    _historyBox = await Hive.openBox('history');
    _cache = await Hive.openBox('cache');
    _chatBox = await Hive.openBox('chat');
  }

  Future<void> disposeCloseBox() async {
    _entriesBox.close();
    _settingsBox.close();
    _favoritesBox.close();
    _historyBox.close();
    _chatBox.close();
    _cache.close();
  }

  Box<DictionaryEntry>? getData({required TypeBox typeBox}) {
    if (_entriesBox.isOpen) {
      switch (typeBox) {
        case TypeBox.entries:
          return _entriesBox;

        case TypeBox.favorites:
          return _favoritesBox;

        case TypeBox.history:
          return _historyBox;

        default:
          return null;
      }
    } else {
      return null;
    }
  }

  Box<dynamic>? getSettingsData() {
    return _settingsBox;
  }

  Box<String>? getCacheData() {
    return _cache;
  }

  Box<ChatMessage> getChatData() {
    return _chatBox;
  }

  void addChatData({required ChatMessage chatMessage}) {
    _chatBox.add(chatMessage);
  }

  void addCollectionBoxData(
      {required DictionaryEntry entry, required TypeBox typeBox}) {
    if (_entriesBox.isOpen) {
      switch (typeBox) {
        case TypeBox.entries:
          _entriesBox.add(entry);

        case TypeBox.favorites:
          _favoritesBox.add(entry);

        case TypeBox.history:
          _historyBox.add(entry);

        default:
      }
    }
  }

  void addSettingsData(List<dynamic> settingsData) {
    if (_settingsBox.isOpen) {
      _settingsBox.clear();
      _settingsBox.add(settingsData);
    }
  }

  void addCache(String url) {
    _cache.add(url);
  }

  void removeCollectionBoxData(
      {required DictionaryEntry entry, required TypeBox typeBox}) {
    switch (typeBox) {
      case TypeBox.entries:
        final item = _entriesBox.values
            .where(
              (element) => element.word == entry.word,
            )
            .first;
        final index = _entriesBox.values.toList().indexOf(item);
        _entriesBox.deleteAt(index);

      case TypeBox.favorites:
        final item = _favoritesBox.values
            .where(
              (element) => element.word == entry.word,
            )
            .first;
        final index = _favoritesBox.values.toList().indexOf(item);
        _favoritesBox.deleteAt(index);

      case TypeBox.history:
        final item = _historyBox.values
            .where(
              (element) => element.word == entry.word,
            )
            .first;
        final index = _historyBox.values.toList().indexOf(item);
        _historyBox.deleteAt(index);
      default:
    }
  }

  void resetData(TypeBox typeBox) {
    switch (typeBox) {
      case TypeBox.entries:
        _entriesBox.clear();

      case TypeBox.favorites:
        _favoritesBox.clear();

      case TypeBox.history:
        _historyBox.clear();

      case TypeBox.cache:
        _cache.clear();

      case TypeBox.chat:
        _chatBox.clear();
      default:
    }
  }
}

///////////////////////////////////////////////////

