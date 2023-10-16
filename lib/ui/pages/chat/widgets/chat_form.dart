import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:record/record.dart';
import 'package:whatsapp_clone/ui/pages/chat/cubits/chat_cubit.dart';

class ChatForm extends StatefulWidget {
  const ChatForm({super.key});

  @override
  State<ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController messageController = TextEditingController();

  final AudioRecorder audioRecorder = AudioRecorder();

  bool canRec = true;
  Offset offset = Offset.zero;

  double blockRecHeight = 110.0;

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
    audioRecorder.dispose();
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
          SizedBox(
            width: 45.0,
            height: 110.0,
            child: Stack(
              children: [
                Transform.translate(
                  offset: const Offset(8.5, -10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red,
                    ),
                    height: blockRecHeight,
                    width: 30.0,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      if (messageController.text.trim().isNotEmpty) {
                        context
                            .read<ChatCubit>()
                            .sendMessage(messageController.text.trim());
                        messageController.text = '';
                      }
                    },
                    onLongPressStart: (details) async {
                      // await audioRecorder.start(
                      //   const RecordConfig(encoder: AudioEncoder.wav),
                      //   path: 'C:/Users/alex-/Documents/Scanned Documents/test.wav',
                      // );
                    },
                    onLongPressMoveUpdate: (details) {
                      if (details.localPosition.dy > -50 &&
                          details.localPosition.dy < 0) {
                        setState(() {
                          offset = Offset(offset.dx, details.localPosition.dy);
                          if (blockRecHeight > 30.0) {
                            blockRecHeight += offset.dy * 0.5;
                          }
                        });
                      }
                    },
                    onLongPressEnd: (details) async {
                      setState(() {
                        offset = Offset.zero;
                        blockRecHeight = 110;
                      });
                    },
                    child: Transform.translate(
                      offset: offset,
                      child: Container(
                        width: 45.0,
                        height: 45.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00A884),
                        ),
                        child: Icon(
                          canRec ? Icons.mic_outlined : Icons.send_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /* Stack(
            alignment: AlignmentDirectional.center,
            children: [
              const Icon(
                Icons.circle,
                color: Color(0xFF00A884),
                size: 50.0,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  canRec ? Icons.mic_outlined : Icons.send_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ), */
        ],
      ),
    );
  }
}
