import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/src/chat/domain/chat.dart';
import 'package:whatsapp_clone/ui/pages/chat/cubits/chat_cubit.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final String myId = context.read<ChatCubit>().myId;
    return Align(
      alignment:
          myId == chat.senderId ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        color: myId == chat.senderId
            ? const Color(0xFFE7FFDB)
            : const Color(0xFFFFFFFD),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(chat.message),
        ),
      ),
    );
  }
}
