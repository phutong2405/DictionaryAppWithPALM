import 'dart:async';
import 'package:dictionary_app_1110/services/authentication/auth.dart';
import 'package:dictionary_app_1110/services/authentication/auth_error.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_states.dart';
import 'package:dictionary_app_1110/bloc/data_in_cubit.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/repositories/local_data/local_data.dart';
import 'package:dictionary_app_1110/services/hive_service/local_data_service.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  // User user = FirebaseAuth.instance.currentUser!;
  late User? user;
  late final HistoryCubit historyCubit;
  late final AllDataCubit allDataCubit;
  late final FavoriteCubit favoriteCubit;
  late final SettingsCubit settingsCubit;
  late final LanguageChoices languageChoices;
  late List<DictionaryEntry> searchList;

  AppBloc() : super(const InitialState()) {
    on<InitialEvent>(initialEvent);
    on<TapToItemEvent>(tapToItemEvent);
    on<SettingsTappedEvent>(settingsTappedEvent);
    on<HistoryTappedEvent>(historyTappedEvent);
    on<FavoriteTappedEvent>(favoriteTappedEvent);
    on<TranslateTappedEvent>(translateTappedEvent);
    on<FavoriteButtonTappedEvent>(favoriteButtonTappedEvent);
    on<DeleteAllEvent>(deleteAllEvent);
    on<SettingsChangesEvent>(settingsChangesEvent);
    on<LanguageChoicesChangesEvent>(languageChoicesChangesEvent);
    on<ShareButtonTappedEvent>(shareButtonTappedEvent);
    on<LogInEvent>(logInEvent);

    on<SearchingEvent>(searchingEvent);
    on<LogInButtonEvent>(logInButtonEvent);
    on<LogOutEvent>(logOutEvent);
    on<LogOutProcessEvent>(logOutProcessEvent);
    on<RegisterEvent>(registerEvent);
    on<RegisterButtonEvent>(registerButtonEvent);
  }

  //////////////////////////////////////////////////////////////////////////////

  Future<void> initialFetchData() async {
    final localDataService = LocalDataService();
    var entries = await localDataService.getDataInBox(typeBox: TypeBox.entries);
    if (entries != null) {
      List<DictionaryEntry> data = [];
      for (var i = 0; i < entries.length - 1; i++) {
        data.add(entries[i]);
      }
      allDataCubit.englishDictionary = data;
    }
    allDataCubit.update(allDataCubit.englishDictionary);
  }

  Future<void> initialLogin() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      user = FirebaseAuth.instance.currentUser;
    } else {
      user = null;
    }
  }

  Future<void> initialSettings() async {
    var localDataService = LocalDataService();
    var localSettingsData = await localDataService.getSettingsData();
    if (localSettingsData.length == 0) {
      localDataService.addSettingsData([
        false,
        false,
        false,
        [true, false]
      ]);
      settingsCubit.setData(settingsData: [
        false,
        false,
        false,
        [true, false]
      ]);
    } else {
      settingsCubit.setData(settingsData: localSettingsData[0]);
    }
  }

  Future<void> initialCubitData() async {
    var localDataService = LocalDataService();
    var historyLocal =
        await localDataService.getDataInBox(typeBox: TypeBox.history);
    var favoriteLocal =
        await localDataService.getDataInBox(typeBox: TypeBox.favorites);
    if (historyLocal != [] && historyLocal != null) {
      for (var entry in historyLocal) {
        historyCubit.add(entry: entry);
      }
    }
    if (favoriteLocal != [] && favoriteLocal != null) {
      for (var entry in favoriteLocal) {
        favoriteCubit.add(entry: entry);
      }
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  FutureOr<void> initialEvent(
      InitialEvent event, Emitter<AppState> emit) async {
    searchList = [];
    emit(const LoadingState());
    await initialFetchData();
    await initialLogin();

    Future.delayed(const Duration(seconds: 5));
    if (allDataCubit.state.isEmpty) {
      emit(const ErrorState());
    } else {
      for (var element in favoriteCubit.state) {
        allDataCubit.setInFavorite(entry: element);
        historyCubit.setInFavorite(entry: element);
      }
      emit(
        LoadedState(entries: allDataCubit.state),
      );
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  FutureOr<void> tapToItemEvent(TapToItemEvent event, Emitter<AppState> emit) {
    historyCubit.add(entry: event.entry);
    LocalDataService()
        .addDataToBox(entry: event.entry, typeBox: TypeBox.history);
    emit(TapToItemState(entry: event.entry));
    emit(const OutState());
  }

  FutureOr<void> settingsTappedEvent(
      SettingsTappedEvent event, Emitter<AppState> emit) {
    emit(const SettingsState(
        darkMode: false,
        autoLookup: false,
        language: Languages.english,
        simpleMode: false));
    emit(const OutState());
  }

  FutureOr<void> historyTappedEvent(
      HistoryTappedEvent event, Emitter<AppState> emit) {
    emit(const HistorySheetState());
    emit(const OutState());
  }

  FutureOr<void> translateTappedEvent(
      TranslateTappedEvent event, Emitter<AppState> emit) async {
    emit(const TranslateSheetState());
    emit(const OutState());
  }

  FutureOr<void> favoriteTappedEvent(
      FavoriteTappedEvent event, Emitter<AppState> emit) {
    emit(const FavoriteSheetState());
    emit(const OutState());
  }

  FutureOr<void> favoriteButtonTappedEvent(
      FavoriteButtonTappedEvent event, Emitter<AppState> emit) {
    ////// Update history local

    LocalDataService()
        .removeDataFromBox(entry: event.entry, typeBox: TypeBox.history);

    ////// Update data in Favorite

    event.entry.inFavorite = !event.entry.inFavorite;
    if (event.entry.inFavorite == true) {
      favoriteCubit.add(entry: event.entry);
      LocalDataService()
          .addDataToBox(entry: event.entry, typeBox: TypeBox.favorites);
    } else {
      favoriteCubit.remove(entry: event.entry);
      LocalDataService()
          .removeDataFromBox(entry: event.entry, typeBox: TypeBox.favorites);
    }

    ////// Update All Data List
    allDataCubit.setInFavorite(entry: event.entry);

    ////// Update history local
    historyCubit.setInFavorite(entry: event.entry);

    LocalDataService()
        .addDataToBox(entry: event.entry, typeBox: TypeBox.history);

    ///// in Searching View
    if (searchList.isEmpty) {
      emit(
        LoadedState(entries: allDataCubit.state),
      );
      emit(
        FavoriteButtonTappedState(entry: event.entry, type: event.type),
      );
    } else {
      emit(
        LoadedState(entries: searchList),
      );
      emit(FavoriteButtonTappedState(entry: event.entry, type: event.type));
    }
  }

  FutureOr<void> deleteAllEvent(
      DeleteAllEvent event, Emitter<AppState> emit) async {
    if (historyCubit.state.isNotEmpty) {
      historyCubit.removeAll();
      LocalDataService().resetData(typeBox: TypeBox.history);
      emit(const DeleteAllState());
    }
  }

  FutureOr<void> settingsChangesEvent(
      SettingsChangesEvent event, Emitter<AppState> emit) {
    final data = event.data;
    switch (event.type) {
      case SwitchType.darkMode:
        settingsCubit.setDarkMode(data);
      case SwitchType.simpleMode:
        settingsCubit.setSimpleMode(simpleMode: data);
      case SwitchType.autoLookup:
        settingsCubit.setAutoLookup(autoLookup: data);
      case SwitchType.languages:
        settingsCubit.setLanguages(list: data);
      default:
    }
    final localDataService = LocalDataService();

    localDataService.addSettingsData(settingsCubit.state.toList());

    // print(localSettingsData.settingsBox);
    emit(SettingsChangesState(settingsCubit.state));
    emit(LoadedState(entries: allDataCubit.state));
  }

  FutureOr<void> languageChoicesChangesEvent(
      LanguageChoicesChangesEvent event, Emitter<AppState> emit) {
    languageChoices.chooseById(id: event.id);
    emit(LanguageChoicesChangesState(
        languageChoices: languageChoices.state.elementAt(1)));
    if (languageChoices.state.elementAt(1).first.title == 'English') {
      emit(LoadedState(entries: allDataCubit.englishDictionary));
    } else if (languageChoices.state.elementAt(1).first.title == 'Vietnamese') {
      emit(LoadedState(entries: allDataCubit.vietnameseDictionary));
    }
  }

  //////////////////////////////////////////////////////////////////////
  //SEARCH ITEM

  FutureOr<void> searchingEvent(SearchingEvent event, Emitter<AppState> emit) {
    searchList = [];
    final value = event.value.toLowerCase();
    if (value == '') {
      emit(
        SearchingState(searchIterable: allDataCubit.state),
      );
      emit(
        LoadedState(entries: allDataCubit.state),
      );
      emit(const OutState());
    } else {
      for (var item in allDataCubit.state) {
        if (item.word.startsWith(value)) {
          searchList.add(item);
        }
      }
      emit(
        SearchingState(searchIterable: searchList),
      );

      emit(
        LoadedState(entries: searchList),
      );
      emit(const OutState());
    }
  }

  //////////////////////////////////////////////////////////////////////
  //LOG IN / OUT

  FutureOr<void> logInEvent(LogInEvent event, Emitter<AppState> emit) {
    emit(const LoginState());
    emit(const OutState());
  }

  FutureOr<void> logInButtonEvent(
      LogInButtonEvent event, Emitter<AppState> emit) async {
    emit(const LoginLoadingState());

    final email = event.email;
    final password = event.password;

    var (userFromAuth, eFromAuth) =
        await AuthService().login(email: email, password: password);

    if (userFromAuth != null && eFromAuth == null) {
      user = userFromAuth;
      emit(const LoginSuccessState());
    } else {
      final eTitle = AuthError.from(eFromAuth!).dialogTitle;
      final eText = AuthError.from(eFromAuth).dialogText;
      emit(
        LoginErrorState(eTitle, eText),
      );
    }

    emit(const OutState());
  }

  FutureOr<void> logOutEvent(LogOutEvent event, Emitter<AppState> emit) async {
    emit(const LogoutState());
    emit(const OutState());
  }

  FutureOr<void> registerEvent(
      RegisterEvent event, Emitter<AppState> emit) async {
    emit(const LoginLoadingState());
    final text = await AuthService().registration(
        email: event.email.text,
        password: event.password.text,
        passwordAgain: event.passwordAgain.text);
    if (text == "") {
      emit(
        RegisterState(
          email: event.email,
          password: event.password,
          text: text,
        ),
      );
    } else {
      emit(RegisterErrorState(errorText: text!));
    }
    emit(const OutState());
  }

  FutureOr<void> registerButtonEvent(
      RegisterButtonEvent event, Emitter<AppState> emit) {
    emit(const RegisterButtonState());
    emit(const OutState());
  }

  FutureOr<void> shareButtonTappedEvent(
      ShareButtonTappedEvent event, Emitter<AppState> emit) {
    emit(ShareButtonTappedState(entry: event.entry));
  }

  FutureOr<void> logOutProcessEvent(
      LogOutProcessEvent event, Emitter<AppState> emit) async {
    emit(const LoginLoadingState());
    // log the user out
    final logout = await AuthService().logout(user: user);
    if (logout == 1) {
      user = null;
      emit(
        const LogoutSuccessState(),
      );
    }
    emit(const OutState());
  }
}
