import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_states.dart';
import 'package:dictionary_app_1110/models/chat_model.dart';
import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/views/ai_chat_view/message_text_field_view.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AIChating extends StatelessWidget {
  final ChatBloc chatBloc;
  final AppBloc appBloc;
  const AIChating({super.key, required this.chatBloc, required this.appBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        flexibleSpace: SafeArea(
          child: chatAppBar(context: context, chatBloc: chatBloc),
        ),
      ),
      body: BlocBuilder(
        bloc: chatBloc,
        buildWhen: (previous, current) =>
            current is ChatState && current is! MessageLoadded,
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatLoaddingState:
              return Center(
                  child: Lottie.asset("lib/assets/loadingcirle.json"));

            case ChatLoaddedState:
              state as ChatLoaddedState;
              return chatBloc.messageCubit.state.isEmpty ||
                      // ignore: unrelated_type_equality_checks
                      chatBloc.messageCubit.state == []
                  ? Center(
                      child: Text(
                      stringNoChat,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ))
                  : chatList(
                      chatBloc: chatBloc, isAnimate: state.havingNewContent);

            case MessageLoadded:
              return chatList(chatBloc: chatBloc, isAnimate: false);

            default:
              return const SizedBox();
          }
        },
      ),
      bottomSheet: MessageTextField(chatBloc: chatBloc),
    );
  }
}

Widget chatAppBar({required BuildContext context, required ChatBloc chatBloc}) {
  return Container(
    padding: const EdgeInsets.only(
      right: 16,
    ),
    child: Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
          ),
        ),
        divineSpace(width: 15),
        const Text(
          stringChatTitle,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            chatBloc.add(const ChatRefreshEvent());
          },
          icon: Icon(
            Icons.refresh_outlined,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
          ),
        ),
        IconButton(
          onPressed: () {
            chatBloc.add(const ChatCleanEvent());
          },
          icon: Icon(
            Icons.cleaning_services_outlined,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

Widget chatList({required ChatBloc chatBloc, required bool isAnimate}) {
  final messages = chatBloc.messageCubit.state;
  return SingleChildScrollView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    reverse: true,
    padding: const EdgeInsets.only(bottom: 100),
    child: ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return chatBox(
            messages: messages,
            chatBloc: chatBloc,
            index: index,
            animation: isAnimate);
      },
    ),
  );
}

Widget chatBox(
    {required Iterable<ChatMessage> messages,
    required ChatBloc chatBloc,
    required int index,
    required bool animation}) {
  final bool isSender =
      messages.elementAt(index).messageType == MessageType.sender;

  return Container(
    margin: isSender
        ? const EdgeInsets.only(left: 70, right: 10, top: 10, bottom: 10)
        : const EdgeInsets.only(left: 10, right: 50, top: 10, bottom: 10),
    child: Align(
      alignment: !isSender ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              messages.elementAt(index).messageType == MessageType.receiver
                  ? const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
          color: (messages.elementAt(index).messageType == MessageType.receiver
              ? Colors.grey.shade200
              : Colors.blue[200]),
        ),
        padding: const EdgeInsets.all(12),
        child: (index == messages.length - 1 && animation != false)
            ? AnimatedTextKit(
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
                totalRepeatCount: 0,
                animatedTexts: [
                  chatBloc.isLoading
                      ? TyperAnimatedText('',
                          speed: const Duration(microseconds: 1))
                      : TyperAnimatedText('ooo',
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          speed: const Duration(seconds: 1)),
                  TyperAnimatedText(
                      speed: const Duration(milliseconds: 35),
                      messages.elementAt(index).messageContent,
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      )),
                ],
              )
            : Text(
                messages.elementAt(index).messageContent,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
      ),
    ),
  );
}
