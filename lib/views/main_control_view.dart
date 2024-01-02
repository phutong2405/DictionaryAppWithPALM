import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_states.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_events.dart';
import 'package:dictionary_app_1110/bloc/data_in_cubit.dart';
import 'package:dictionary_app_1110/repositories/local_data/local_data.dart';
import 'package:dictionary_app_1110/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ControlView extends StatefulWidget {
  final AppBloc appBloc;
  const ControlView({super.key, required this.appBloc});

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  late bool isDarkMode;
  late AppBloc appBloc;
  late ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    appBloc = widget.appBloc;
    appBloc.languageChoices = LanguageChoices();

    appBloc.add(const InitialEvent());
    chatBloc = ChatBloc();
    chatBloc.add(const ChatInitialEvent());
  }

  @override
  void dispose() {
    super.dispose();
    LocalData.instance().disposeCloseBox();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: appBloc,
      buildWhen: (previous, current) => previous is SettingsChangesState,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: appBloc.settingsCubit.isDarkMode() != false
                ? const ColorScheme(
                    brightness: Brightness.dark,
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    secondary: Colors.white,
                    onSecondary: Colors.black,
                    error: Colors.red,
                    onError: Colors.white,
                    background: Colors.white,
                    onBackground: Colors.black,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  )
                : const ColorScheme(
                    brightness: Brightness.light,
                    primary: Colors.white,
                    onPrimary: Colors.black87,
                    secondary: Colors.black87,
                    onSecondary: Colors.white,
                    error: Colors.red,
                    onError: Colors.black87,
                    background: Colors.black87,
                    onBackground: Colors.white,
                    surface: Colors.black87,
                    onSurface: Colors.white,
                  ),
            useMaterial3: false,
          ),
          home: MainView(appBloc: appBloc, chatBloc: chatBloc),
        );
      },
    );
  }
}
