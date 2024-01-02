import 'dart:async';

import 'package:dictionary_app_1110/dialogs/loading_controller.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingController? controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.updateOptions(text) ?? false) {
      return;
    } else {
      controller = showOverlay(context: context, text: text);
    }
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  LoadingController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final _text = StreamController<String>();
    _text.add(text);

    final overlayState = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.8,
                maxWidth: size.width * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                // color: Colors.white,
                color: Theme.of(context).colorScheme.onBackground,

                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder(
                        stream: _text.stream,
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlay);

    return LoadingController(
      closeOptions: () {
        _text.close();
        overlay.remove();
        return true;
      },
      updateOptions: (text) {
        _text.add(text);
        return true;
      },
    );
  }
}
