import 'package:flutter/material.dart';
import 'package:dishcord/firestore/model/chatroom.dart';
import 'package:dishcord/firestore/repo/chatroom_repo.dart';
import 'package:dishcord/log_in/auth/auth_service.dart';
import 'package:dishcord/widgets/chat/chat.dart';
import 'package:dishcord/widgets/chatroom/chatroom_list_item.dart';
import 'package:dishcord/widgets/chatroom/chatroom_set.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatelessWidget {
  final viewModel = ChatRoomViewModel(chatRoomRepo: ChatRoomRepo());

  void _onChatRoomItemTapped(BuildContext context, ChatRoom chatRoom) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ChatPage(chatRoom: chatRoom, title: chatRoom.title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatRoom>>(
      stream: viewModel.chatRooms,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.brown[200],
            appBar: AppBar(
              backgroundColor: Colors.brown[300],
              title: Text('Dish Channels'),
              actions: <Widget>[
                IconButton(
                    key: const ValueKey("signOut"),
                    icon: Icon(Icons.logout), onPressed: () {
                  context.read<AuthService>().signOut();
                })
              ],
            ),
            body: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return StickyHeader(
                  header: Container(
                    height: 20.0,
                    color: Colors.brown[200],
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.bottomLeft,
                  ),
                  content: Column(
                    children: snapshot.data
                        .map(
                          (item) => ChatRoomListItem(
                            chatRoom: item,
                            onTapped: (chatRoom) =>
                                _onChatRoomItemTapped(context, chatRoom),
                          ),
                        )
                        .toList(growable: false),
                  ),
                );
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
