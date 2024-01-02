import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/repositories/fetching_entry.dart';
import 'package:dictionary_app_1110/repositories/local_data/local_data.dart';

class LocalDataService {
  Future<void> initial({
    required String url,
  }) async {
    LocalData localData = LocalData.instance();
    await localData.initialOpenBox();

    if (!localData.getCacheData()!.values.contains(url) ||
        localData.getCacheData() == null) {
      Iterable<DictionaryEntry> data = await fetchWord(url);
      for (var element in data) {
        localData.addCollectionBoxData(
            entry: element, typeBox: TypeBox.entries);
      }
      localData.addCache(url);
    }
  }

  Future<List<DictionaryEntry>?> getDataInBox(
      {required TypeBox typeBox}) async {
    LocalData localData = LocalData.instance();
    await localData.initialOpenBox();
    switch (typeBox) {
      case TypeBox.entries:
        return localData.getData(typeBox: TypeBox.entries)?.values.toList();

      case TypeBox.favorites:
        return localData.getData(typeBox: TypeBox.favorites)?.values.toList();

      case TypeBox.history:
        return localData.getData(typeBox: TypeBox.history)?.values.toList();

      default:
        return localData.getData(typeBox: TypeBox.entries)?.values.toList();
    }
  }

  Future<dynamic> getSettingsData() async {
    LocalData localData = LocalData.instance();
    await localData.initialOpenBox();
    return localData.getSettingsData()!.values.toList();
  }

  Future<void> addSettingsData(List<dynamic> settingsData) async {
    LocalData localData = LocalData.instance();
    await localData.initialOpenBox();
    localData.addSettingsData(settingsData);
  }

  Future<void> addDataToBox(
      {required DictionaryEntry entry, required TypeBox typeBox}) async {
    LocalData localData = LocalData.instance();
    await localData.initialOpenBox();
    localData.addCollectionBoxData(entry: entry, typeBox: typeBox);
  }

  Future<void> removeDataFromBox(
      {required DictionaryEntry entry, required TypeBox typeBox}) async {
    LocalData localData = LocalData.instance();
    await localData.initialOpenBox();
    localData.removeCollectionBoxData(entry: entry, typeBox: typeBox);
  }

  Future<void> resetData({required TypeBox typeBox}) async {
    LocalData localData = LocalData.instance();
    await localData.initialOpenBox();
    localData.resetData(typeBox);
  }
}
