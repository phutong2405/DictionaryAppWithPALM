import 'package:dictionary_app_1110/models/chat_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ChatState {
  const ChatState();
}

abstract class ChatActionState {
  const ChatActionState();
}

class ChatInitialState implements ChatState {
  const ChatInitialState();
}

class ChatLoaddingState implements ChatState {
  const ChatLoaddingState();
}

class ChatLoaddedState implements ChatState {
  final bool havingNewContent;
  final Iterable<ChatMessage> chatMessages;
  const ChatLoaddedState(
      {required this.havingNewContent, required this.chatMessages});
}

class SendingButtonState implements ChatActionState {
  const SendingButtonState();
}

class MessageLoadded implements ChatState {
  const MessageLoadded();
}
