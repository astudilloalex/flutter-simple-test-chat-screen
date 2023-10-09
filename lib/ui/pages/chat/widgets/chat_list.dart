import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/ui/pages/chat/cubits/chat_cubit.dart';
import 'package:whatsapp_clone/ui/pages/chat/states/chat_state.dart';
import 'package:whatsapp_clone/ui/pages/chat/widgets/chat_bubble.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ChatBubble(chat: state.chats[index]),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8.0);
          },
          itemCount: state.chats.length,
        );
      },
    );
  }
}
