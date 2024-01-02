import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_events.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  final ChatBloc chatBloc;
  const MessageTextField({super.key, required this.chatBloc});

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  late final TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: Colors.blueGrey,
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 45,
              alignment: Alignment.center,
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                cursorColor: Colors.blueGrey,
                controller: textController,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  isDense: true,
                  filled: true,
                  prefixIcon: IconButton(
                      onPressed: () {
                        textController.clear();
                      },
                      icon: const Icon(
                        Icons.clear,
                        size: 22,
                        color: Colors.grey,
                      )),
                  suffixIcon: IconButton(
                      splashColor: Colors.grey,
                      onPressed: () {
                        if (widget.chatBloc.isLoading ||
                            textController.text == '') {
                        } else {
                          widget.chatBloc.add(ChatSendButtonEvent(
                              havingNewContent: true,
                              content: textController.text));
                          textController.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.lightBlue,
                        size: 22,
                      )),
                  fillColor: Theme.of(context).colorScheme.onBackground,
                  iconColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
                onChanged: (value) {
                  textController.text = value;
                },
              ),
            ),
            MediaQuery.of(context).viewInsets.bottom <= 30
                ? const Spacer()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      genericTextButton(
                        icon: Icons.arrow_upward,
                        text: 'More Details',
                        bgcolor: Colors.grey.withOpacity(0.8),
                        sized: textButtonSize[Size.small]!,
                        func: () {
                          if (widget.chatBloc.isLoading ||
                              textController.text == '') {
                          } else {
                            widget.chatBloc.add(ChatSendButtonEvent(
                                havingNewContent: true,
                                content:
                                    "Look up for this word and give some examples: ${textController.text}"));
                            textController.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                      divineSpace(width: 15),
                      genericTextButton(
                        icon: Icons.arrow_upward,
                        text: 'Check Grammar',
                        bgcolor: Colors.grey.withOpacity(0.8),
                        sized: textButtonSize[Size.small]!,
                        func: () {
                          if (widget.chatBloc.isLoading ||
                              textController.text == '') {
                          } else {
                            widget.chatBloc.add(ChatSendButtonEvent(
                                havingNewContent: true,
                                content:
                                    "Check grammar for this: ${textController.text}"));
                            textController.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                    ],
                  )
          ],
        ));
  }
}
