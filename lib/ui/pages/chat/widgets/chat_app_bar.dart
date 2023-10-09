import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/ui/pages/chat/cubits/chat_cubit.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF3A5664),
      foregroundColor: Colors.white,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://public.alexastudillo.com/ai-avatar.jpg',
            ),
          ),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AI Assistant'),
          Text(
            context.watch<ChatCubit>().state.loading ? 'typing...' : 'online',
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
