import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_states.dart';
import 'package:dictionary_app_1110/bloc/data_in_cubit.dart';
import 'package:dictionary_app_1110/models/chat_model.dart';
import 'package:dictionary_app_1110/repositories/chat_repo.dart';
import 'package:dictionary_app_1110/services/hive_service/local_chat_data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  bool isLoading = false;
  // bool isConnected = true;
  late MessageCubit messageCubit;
  ChatBloc() : super(const ChatInitialState()) {
    on<ChatInitialEvent>(chatInitialEvent);
    on<ChatSendButtonEvent>(chatSendButtonEvent);
    on<ChatCleanEvent>(chatCleanEvent);
    on<ChatRefreshEvent>(chatRefreshEvent);
  }

  FutureOr<void> chatInitialEvent(
      ChatInitialEvent event, Emitter<ChatState> emit) async {
    messageCubit = MessageCubit();
    await ChatDataService(chatBloc: this).initial();
    emit(ChatLoaddedState(
        havingNewContent: false, chatMessages: messageCubit.state));
  }

  FutureOr<void> chatSendButtonEvent(
      ChatSendButtonEvent event, Emitter<ChatState> emit) async {
    final localChatData = ChatDataService(chatBloc: this);
    final sender = ChatMessage(
        messageContent: event.content, messageType: MessageType.sender);
    messageCubit.add(message: sender);
    localChatData.addChatData(chatMessage: sender);

    emit(ChatLoaddedState(
        havingNewContent: true, chatMessages: messageCubit.state));
    isLoading = true;
    final receiverMessage = await getAnswer(content: event.content);
    messageCubit.add(message: receiverMessage);
    localChatData.addChatData(chatMessage: receiverMessage);

    emit(ChatLoaddedState(
        havingNewContent: true, chatMessages: messageCubit.state));
    isLoading = false;
    emit(const MessageLoadded());
  }

  FutureOr<void> chatCleanEvent(
      ChatCleanEvent event, Emitter<ChatState> emit) async {
    emit(const ChatLoaddingState());
    final localChatData = ChatDataService(chatBloc: this);
    localChatData.resetData();
    messageCubit.reset();
    await Future.delayed(
      const Duration(seconds: 1),
      () => emit(ChatLoaddedState(
          havingNewContent: true, chatMessages: messageCubit.state)),
    );
  }

  FutureOr<void> chatRefreshEvent(
      ChatRefreshEvent event, Emitter<ChatState> emit) async {
    emit(const ChatLoaddingState());
    await Future.delayed(
      const Duration(seconds: 1),
      () => emit(ChatLoaddedState(
          havingNewContent: false, chatMessages: messageCubit.state)),
    );
  }
}
