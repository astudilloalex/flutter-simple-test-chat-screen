import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whatsapp_clone/ui/pages/chat/cubits/chat_cubit.dart';

class ChatForm extends StatefulWidget {
  const ChatForm({super.key});

  @override
  State<ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController messageController = TextEditingController();

  bool canRec = true;

  @override
  void initState() {
    super.initState();
    messageController.addListener(() {
      if (messageController.text.trim().isEmpty) {
        if (!canRec) setState(() => canRec = true);
      } else {
        if (canRec) setState(() => canRec = false);
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.message,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                isDense: true,
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ),
          const SizedBox(width: 8.0),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              const Icon(
                Icons.circle,
                color: Color(0xFF00A884),
                size: 50.0,
              ),
              IconButton(
                onPressed: () {
                  if (messageController.text.trim().isNotEmpty) {
                    context
                        .read<ChatCubit>()
                        .sendMessage(messageController.text.trim());
                    messageController.text = '';
                  }
                },
                icon: Icon(
                  canRec ? Icons.mic_outlined : Icons.send_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
