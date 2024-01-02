import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/controller/controller_bottomsheet.dart';
import 'package:dictionary_app_1110/views/bottomSheet/register_bottom_sheet/register_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterBottomSheet {
  RegisterBottomSheet._sharedInstance();
  static final RegisterBottomSheet _shared =
      RegisterBottomSheet._sharedInstance();
  factory RegisterBottomSheet.instance() => _shared;

  BottomSheetController? controller;

  void show(
      {required BuildContext context,
      required AppBloc appBloc,
      required Iterable<dynamic> settingsData}) {
    if (controller?.updateOptions(appBloc.settingsCubit.state) ?? false) {
      return;
    } else {
      controller = showDetailBottomSheet(
          context: context, appBloc: appBloc, settingsData: settingsData);
    }
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  BottomSheetController showDetailBottomSheet(
      {required BuildContext context,
      required AppBloc appBloc,
      required Iterable<dynamic> settingsData}) {
    final settingsStream = StreamController<Iterable<dynamic>>();
    settingsStream.add(settingsData);

    registerBottomSheet(
      appBloc: appBloc,
      context: context,
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
