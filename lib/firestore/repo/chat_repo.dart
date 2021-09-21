import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishcord/firestore/model/chat.dart';

class ChatRepo {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('chat');

  void saveMessage(ChatMessage message) async {
    await _ref.add(message.toMap());
  }

  Stream<ChatMessage> getMessageUpdates(String chatRoomId) async* {
    final snapshots =
        _ref.where('chatroom_id', isEqualTo: chatRoomId).snapshots();

    await for (final snapshot in snapshots) {
      for (final changes in snapshot.docChanges) {
        final Timestamp date = changes.doc.data()['send_date'];
        yield ChatMessage(
          id: changes.doc.id,
          date: date.toDate(),
          message: changes.doc.data()['message'],
          username: changes.doc.data()['username'],
          userEmail: changes.doc.data()['user_email'],
          chatIconColor: changes.doc.data()['chat_icon_color']
        );
      }
    }
  }
}
