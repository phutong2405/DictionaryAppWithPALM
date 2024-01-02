import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DialogOption<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOption dialogOption,
}) {
  final options = dialogOption();
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((keys) {
          return CupertinoDialogAction(
            textStyle: TextStyle(
              color: options[keys] == true
                  ? Colors.red
                  : Theme.of(context).colorScheme.onPrimary,
            ),
            isDefaultAction: true,
            child: Text(keys),
            onPressed: () {
              if (options[keys] != null) {
                Navigator.of(context).pop(options[keys]);
              } else {
                Navigator.pop(context);
              }
            },
          );
          // return TextButton(
          //   style: ButtonStyle(
          //       textStyle: const MaterialStatePropertyAll(
          //           TextStyle(color: Colors.white)),
          //       backgroundColor: options[keys] == true
          //           ? MaterialStatePropertyAll(Colors.black.withRed(200))
          //           : const MaterialStatePropertyAll(Colors.blueGrey)),
          //   onPressed: () {
          //     if (options[keys] != null) {
          //       Navigator.of(context).pop(options[keys]);
          //     } else {
          //       Navigator.pop(context);
          //     }
          //   },
          //   child: Text(keys),
          // );
        }).toList(),
      );
    },
  );
}
