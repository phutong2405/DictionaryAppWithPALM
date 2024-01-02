import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:flutter/material.dart';

void logInBottomSheet({
  required BuildContext context,
  required AppBloc appBloc,
  String? username,

  // required StreamController<Iterable<LanguagesItem>> controller,
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
      final TextEditingController emailController =
          TextEditingController(text: username ?? "");
      final TextEditingController passwordController = TextEditingController();
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
                    'Login',
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
              userTextField(
                  textController: emailController,
                  context: context,
                  username: username),
              divineSpace(height: 10),
              textFieldTitle(title: 'password'),
              divineSpace(height: 10),
              passwordTextField(
                textController: passwordController,
                context: context,
              ),
              divineSpace(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genericTextButton(
                    icon: Icons.app_registration,
                    text: 'Register',
                    bgcolor: Colors.blueGrey,
                    sized: 35,
                    func: () {
                      appBloc.add(const RegisterButtonEvent());
                    },
                  ),
                  divineSpace(width: 20),
                  genericTextButton(
                    icon: Icons.login,
                    text: 'Login',
                    bgcolor: Colors.green,
                    sized: 40,
                    func: () {
                      appBloc.add(LogInButtonEvent(
                          email: emailController.text,
                          password: passwordController.text));
                    },
                  ),
                ],
              ),
              divineSpace(height: 20),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    genericTextButton(
                      icon: Icons.apple,
                      text: 'Login with Apple',
                      bgcolor: Colors.grey,
                      sized: 40,
                      func: () {},
                    ),
                    divineSpace(height: 20),
                    genericTextButton(
                      icon: Icons.tiktok,
                      text: 'Login with Tiktok',
                      bgcolor: Colors.grey,
                      sized: 40,
                      func: () {},
                    ),
                    divineSpace(height: 10),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'forgot password ?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget textFieldTitle({required String title, double? size}) {
  return Text(
    title,
    style: TextStyle(
        fontWeight: FontWeight.w400, color: Colors.grey, fontSize: size ?? 18),
  );
}

Widget userTextField({
  required TextEditingController textController,
  required BuildContext context,
  String? username,
}) {
  return TextField(
      controller: textController,
      cursorColor: Colors.blueGrey,
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        hintText: username ?? "",
        prefixIcon: const Icon(
          Icons.account_circle,
          size: 22,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
            splashColor: Colors.grey,
            onPressed: () {
              textController.clear();
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
              size: 22,
            )),
        fillColor: Theme.of(context).colorScheme.onBackground,
        iconColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
      onChanged: (value) {
        textController.text = value;
      });
}

Widget passwordTextField({
  required TextEditingController textController,
  required BuildContext context,
}) {
  return TextField(
      cursorColor: Colors.blueGrey,
      controller: textController,
      textAlignVertical: TextAlignVertical.center,
      obscureText: true,
      obscuringCharacter: 'X',
      maxLines: 1,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        prefixIcon: const Icon(
          Icons.password_rounded,
          size: 22,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
            splashColor: Colors.grey,
            onPressed: () {
              textController.clear();
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
              size: 22,
            )),
        // fillColor: Colors.white,
        fillColor: Theme.of(context).colorScheme.onBackground,

        iconColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
      onChanged: (value) {
        textController.text = value;
      });
}
