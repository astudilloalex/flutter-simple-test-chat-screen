import 'package:whatsapp_clone/src/chat/domain/chat.dart';

class ChatState {
  const ChatState({
    this.chats = const [],
    this.loading = false,
  });

  final List<Chat> chats;
  final bool loading;

  ChatState copyWith({
    List<Chat>? chats,
    bool? loading,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      loading: loading ?? this.loading,
    );
  }
}
