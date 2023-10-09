import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/src/chat/domain/chat.dart';
import 'package:whatsapp_clone/ui/pages/chat/states/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState()) {
    myId = _generateId(20);
  }

  String myId = '';

  Future<void> sendMessage(String message) async {
    // This simulate a identifier of the server.
    final String serverId = _generateId(20);
    final List<Chat> messages = [
      ...state.chats,
      Chat(message: message, senderId: myId, receiverId: serverId),
    ];
    emit(state.copyWith(chats: messages));
    try {
      emit(state.copyWith(loading: true));
      // This simulates a request to the backend that takes 2 seconds
      await Future.delayed(const Duration(seconds: 2));
      switch (message) {
        case 'Hello':
          messages.add(
            Chat(
              message: 'How can I help you?',
              senderId: serverId,
              receiverId: myId,
            ),
          );
        case 'What time is it?':
          messages.add(
            Chat(
              message: 'It is ${DateTime.now().hour}:${DateTime.now().minute}',
              senderId: serverId,
              receiverId: myId,
            ),
          );
        default:
          messages.add(
            Chat(
              message: "I don't understand your question, please repeat it.",
              senderId: serverId,
              receiverId: myId,
            ),
          );
      }
    } finally {
      emit(state.copyWith(loading: false, chats: messages));
    }
  }

  String _generateId(int length) {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random random = Random.secure();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }
}
