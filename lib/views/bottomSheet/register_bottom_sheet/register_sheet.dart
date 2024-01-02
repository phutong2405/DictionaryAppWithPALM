import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/views/bottomSheet/log_in_sheet/log_in_modal_bottom.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:flutter/material.dart';

void registerBottomSheet({
  required BuildContext context,
  required AppBloc appBloc,
}) {
  showModalBottomSheet(
    enableDrag: false,
    showDragHandle: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35))),
    context: context,
    builder: (context) {
      final TextEditingController emailController = TextEditingController();
      final TextEditingController passwordController = TextEditingController();
      final TextEditingController passwordAgainController =
          TextEditingController();
      return FractionallySizedBox(
        heightFactor: 0.93,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              divineSpace(height: 10),
              textFieldTitle(title: 'email'),
              divineSpace(height: 10),
              userTextField(textController: emailController, context: context),
              divineSpace(height: 10),
              textFieldTitle(title: 'password'),
              divineSpace(height: 10),
              passwordTextField(
                  textController: passwordController, context: context),
              divineSpace(height: 10),
              textFieldTitle(title: 'password again'),
              divineSpace(height: 10),
              passwordTextField(
                  textController: passwordAgainController, context: context),
              divineSpace(height: 30),
              Center(
                child: genericTextButton(
                  icon: Icons.app_registration,
                  text: 'Register With Your Email',
                  bgcolor: Colors.blueGrey,
                  sized: 35,
                  func: () {
                    appBloc.add(
                      RegisterEvent(
                        email: emailController,
                        password: passwordController,
                        passwordAgain: passwordAgainController,
                      ),
                    );
                  },
                ),
              ),
              divineSpace(height: 20),
            ],
          ),
        ),
      );
    },
  );
}
