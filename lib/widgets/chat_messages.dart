import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

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
            itemCount: loadedMessages.length,
            itemBuilder: (context, index) {
              return Text(loadedMessages[index].data()['text']);
            },
          );
        });
  }
}
