import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final chatController = TextEditingController();

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();

  }

  void _onSendMessage() {
    final _enteredMessage = chatController.text;

    if (_enteredMessage.trim().isEmpty) {
      return;
    }

    chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: "Kirim pesan..."),
                autocorrect: true,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,
                controller: chatController,
              )),
          IconButton(onPressed: _onSendMessage, icon: const Icon(Icons.send), color: Theme.of(context).colorScheme.primary,)
        ],
      ),
    );
  }
}
