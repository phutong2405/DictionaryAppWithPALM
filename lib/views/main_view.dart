import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_states.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/controlling_view/bottom_navbar.dart';
import 'package:dictionary_app_1110/homepage.dart';
import 'package:dictionary_app_1110/views/controlling_view/search_view.dart';
import 'package:dictionary_app_1110/views/state_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  final AppBloc appBloc;
  final ChatBloc chatBloc;
  const MainView({super.key, required this.appBloc, required this.chatBloc});

  Widget mainView({required Iterable<DictionaryEntry> entries, Widget? body}) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        toolbarHeight: 60,
        title: Container(
          height: 50,
          width: 320,
          padding: const EdgeInsets.all(1),
          margin: const EdgeInsets.all(10),
          child: SearchFieldView(
            appBloc: appBloc,
            chatBloc: chatBloc,
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: BottomNav(
        appBloc: appBloc,
        data: entries,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("main build");
    return BlocConsumer(
      bloc: appBloc,
      listenWhen: (previous, current) =>
          current is MainActionState || previous is SearchingState,
      buildWhen: (previous, current) =>
          current is! MainActionState ||
          previous is LanguageChoicesChangesState, // ||
      listener: (context, state) {
        stateHandle(
          context,
          appBloc,
          chatBloc,
          state,
        );
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadedState:
            print("Loadded");
            state as LoadedState;
            Iterable<DictionaryEntry> entries = state.entries;
            // final dataLength = entries.length;
            // print(dataLength);
            return mainView(
              entries: entries,
              body: HomePage(
                  appBloc: appBloc,
                  data: entries,
                  // dataLength: dataLength,
                  func: (DictionaryEntry entry) {
                    appBloc.add(TapToItemEvent(entry: entry));
                  }),
            );

          case LoadingState:
            return mainView(
              entries: [],
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );

          case ErrorState:
            return mainView(
                entries: [],
                body: const Center(
                  child: Text(stringErrorState),
                ));

          default:
            return mainView(
              entries: [],
            );
        }
      },
    );
  }
}
