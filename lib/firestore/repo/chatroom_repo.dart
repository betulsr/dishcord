import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishcord/firestore/model/chatroom.dart';

class ChatRoomRepo {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('chat_rooms');

  void incrementSnacksSent(String chatRoomId) async {
    //final doc = await _ref.doc(chatRoomId).get();
    //final int currentSent = doc['snacks_sent'];
    //_ref.doc(chatRoomId).update({'snacks_sent': currentSent + 1});
    
    _ref.doc(chatRoomId).update({'snacks_sent': FieldValue.increment(1)});
  }

  Stream<List<ChatRoom>> getChatRooms() async* {
    final snapshots = _ref.snapshots();

    await for (final snapshot in snapshots) {
      yield snapshot.docs
          .map(
            (doc) => ChatRoom(
              id: doc.data()['id'],
              icon: doc.data()['icon'],
              title: doc.data()['title'],
              snacksSent: doc.data()['snacks_sent'],
            ),
          )
          .toList();
    }
  }
}
