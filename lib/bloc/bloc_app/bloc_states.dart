import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppState {
  const AppState();
}

class MainActionState implements AppState {
  const MainActionState();
}

class InitialState implements AppState {
  const InitialState();
}

class LoadingState implements AppState {
  const LoadingState();
}

class LoadedState implements AppState {
  final Iterable<DictionaryEntry> entries;

  const LoadedState({required this.entries});
}

class ErrorState implements AppState {
  const ErrorState();
}

class SettingsState implements MainActionState {
  final bool darkMode;
  final bool simpleMode;
  final bool autoLookup;
  final Languages language;
  const SettingsState(
      {required this.darkMode,
      required this.simpleMode,
      required this.autoLookup,
      required this.language});
}

class OutState implements MainActionState {
  const OutState();
}

class TapToItemState implements MainActionState {
  final DictionaryEntry entry;
  const TapToItemState({required this.entry});
}

class ShareButtonTappedState implements MainActionState {
  final DictionaryEntry entry;
  const ShareButtonTappedState({required this.entry});
}

class HistorySheetState implements MainActionState {
  const HistorySheetState();
}

class FavoriteSheetState implements MainActionState {
  const FavoriteSheetState();
}

class TranslateSheetState implements MainActionState {
  const TranslateSheetState();
}

class FavoriteButtonTappedState implements MainActionState {
  final ModalType type;
  final DictionaryEntry entry;
  const FavoriteButtonTappedState({required this.entry, required this.type});
}

class DeleteAllState implements MainActionState {
  const DeleteAllState();
}

class SettingsChangesState implements MainActionState {
  final Iterable<dynamic> settingsData;
  const SettingsChangesState(this.settingsData);
}

class LanguageChoicesChangesState implements MainActionState {
  final Iterable<dynamic> languageChoices;
  const LanguageChoicesChangesState({required this.languageChoices});
}

class SearchingState implements MainActionState {
  final Iterable<DictionaryEntry> searchIterable;
  const SearchingState({required this.searchIterable});
}

class LoginState implements MainActionState {
  const LoginState();
}

class LoginLoadingState implements MainActionState {
  const LoginLoadingState();
}

class LoginSuccessState implements MainActionState {
  const LoginSuccessState();
}

class LoginErrorState implements MainActionState {
  final String title;
  final String content;
  const LoginErrorState(this.title, this.content);
}

class LoggedState implements MainActionState {
  final bool isLogged;
  const LoggedState({required this.isLogged});
}

class LogoutState implements MainActionState {
  const LogoutState();
}

class LogoutSuccessState implements MainActionState {
  const LogoutSuccessState();
}

class RegisterState implements MainActionState {
  final TextEditingController email;
  final TextEditingController password;
  final String? text;
  const RegisterState({
    required this.email,
    required this.password,
    required this.text,
  });
}

class RegisterButtonState implements MainActionState {
  const RegisterButtonState();
}

class RegisterErrorState implements MainActionState {
  final String errorText;
  const RegisterErrorState({required this.errorText});
}
