import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_places/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({super.key});

  final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Anda belum mengirim pesan sama sekali'),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Terjadi kesalahan saat memuat pesan.'),
            );
          }

          final loadedMessages = snapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.only(left: 13, right: 13, bottom: 40),
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (context, index) {
              final messageData = loadedMessages[index].data();
              final nextChatMessage = index + 1 < loadedMessages.length
                  ? loadedMessages[index + 1].data()
                  : null;

              final currentMessageUserId = messageData['userId'];
              final nextMessageUserId =
                  nextChatMessage != null ? nextChatMessage['userId'] : null;
              final nextUserIsSame = currentMessageUserId == nextMessageUserId;

              final isMe = messageData['userId'] == _currentUser!.uid;

              if (nextUserIsSame) {
                return MessageBubble.next(
                  message: messageData['text'],
                  isMe: isMe,
                );
              } else {
                return MessageBubble.first(
                  userImage: messageData['userImage'],
                  username: messageData['username'],
                  message: messageData['text'],
                  isMe: isMe,
                );
              }
            },
          );
        });
  }
}
