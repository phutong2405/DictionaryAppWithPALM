import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/models/chat_model.dart';
import 'package:dictionary_app_1110/repositories/local_data/local_data.dart';

class ChatDataService {
  final ChatBloc chatBloc;

  const ChatDataService({required this.chatBloc});

  Future<void> initial() async {
    final localData = LocalData.instance();
    final localChatData = localData.getChatData();
    localData.initialOpenBox();
    if (localChatData.length == 0) {
    } else {
      for (var i = 0; i < localChatData.length; i++) {
        chatBloc.messageCubit.add(message: localChatData.values.elementAt(i));
      }
    }
  }

  void addChatData({required ChatMessage chatMessage}) {
    final localData = LocalData.instance();
    localData.addChatData(chatMessage: chatMessage);
  }

  Future<List<ChatMessage>> getChatData() async {
    final localData = LocalData.instance();
    return localData.getChatData().values.toList();
  }

  void resetData() {
    final localData = LocalData.instance();
    localData.resetData(TypeBox.chat);
  }
}
