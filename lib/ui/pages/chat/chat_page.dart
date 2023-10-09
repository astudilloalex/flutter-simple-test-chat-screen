import 'package:flutter/material.dart';
import 'package:whatsapp_clone/ui/pages/chat/widgets/chat_app_bar.dart';
import 'package:whatsapp_clone/ui/pages/chat/widgets/chat_form.dart';
import 'package:whatsapp_clone/ui/pages/chat/widgets/chat_list.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatAppBar(),
      body: Column(
        children: [
          Expanded(child: ChatList()),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ChatForm(),
          ),
        ],
      ),
    );
  }
}
