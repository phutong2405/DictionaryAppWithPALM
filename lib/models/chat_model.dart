import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 3)
class ChatMessage {
  @HiveField(0)
  String messageContent;
  @HiveField(1)
  MessageType messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

@HiveType(typeId: 4)
enum MessageType {
  @HiveField(0)
  sender,
  @HiveField(1)
  receiver
}
