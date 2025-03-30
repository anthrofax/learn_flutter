import 'package:favorite_places/widgets/chat_input.dart';
import 'package:favorite_places/widgets/chat_messages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            child: const Text('Ya'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tidak'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          IconButton( 
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
