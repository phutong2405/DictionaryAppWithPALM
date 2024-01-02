import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/controller/controller_bottomsheet.dart';
import 'package:dictionary_app_1110/views/bottomSheet/log_in_sheet/log_in_modal_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogInBottomSheet {
  LogInBottomSheet._sharedInstance();
  static final LogInBottomSheet _shared = LogInBottomSheet._sharedInstance();
  factory LogInBottomSheet.instance() => _shared;

  BottomSheetController? controller;

  void show(
      {required BuildContext context,
      required AppBloc appBloc,
      String? username,
      required Iterable<dynamic> settingsData}) {
    if (controller?.updateOptions(appBloc.settingsCubit.state) ?? false) {
      return;
    } else {
      controller = showDetailBottomSheet(
        context: context,
        appBloc: appBloc,
        settingsData: settingsData,
        username: username,
      );
    }
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  BottomSheetController showDetailBottomSheet(
      {required BuildContext context,
      required AppBloc appBloc,
      String? username,
      required Iterable<dynamic> settingsData}) {
    final settingsStream = StreamController<Iterable<dynamic>>();
    settingsStream.add(settingsData);

    logInBottomSheet(
      appBloc: appBloc,
      context: context,
      username: username,
    );

    return BottomSheetController(
      closeOptions: () {
        settingsStream.close();
        return true;
      },
      updateOptions: (state) {
        settingsStream.add(state);
        return true;
      },
    );
  }
}
