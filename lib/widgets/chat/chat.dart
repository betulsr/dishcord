import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dishcord/firestore/model/chat.dart';
import 'package:dishcord/firestore/model/chatroom.dart';
import 'package:dishcord/firestore/repo/chat_repo.dart';
import 'package:dishcord/firestore/repo/chatroom_repo.dart';
import 'package:dishcord/firestore/repo/user_repo.dart';
import 'package:dishcord/widgets/chat/chat_list_item.dart';
import 'package:dishcord/widgets/chat/chat_set.dart';

class ChatPage extends StatelessWidget {
  final String title;
  final ChatRoom chatRoom;

  ChatPage({Key key, this.title, this.chatRoom}) : super(key: key);
  final viewModel = ChatViewModel(ChatRepo(), UserRepo(), ChatRoomRepo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        title: Text(title),
      ),
      body: Column(
        children: [
          StreamBuilder<List<ChatMessage>>(
            stream: viewModel.getChatMessages(chatRoom.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ChatListItem(chatMessage: snapshot.data[index]);
                    },
                  ),
                );
              }
              return Expanded(
                child: Center(
                  child: Text(
                    ' ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              );
            },
          ),
          Container(height: 1, color: Colors.brown[500]),
          SizedBox(height: 8),
          _textInput(context),
          SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _textInput(BuildContext context) {
    final controller = TextEditingController();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Flexible(
          child: TextFormField(
            key: const ValueKey("typeMessage"),
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            obscureText: false,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              labelStyle: TextStyle(color: Colors.grey.shade100),
              hintText: 'Send message',
            ),
          ),
        ),
        SizedBox(width: 12),
        IconButton(
          icon: Icon(viewModel.getIconInfo(chatRoom.icon).iconData),
          onPressed: () {
            FirebaseAnalytics().logEvent(name: 'send_message',parameters:null);
            viewModel.saveIconMessage(chatRoom.id, chatRoom.icon);
          },
        ),
        IconButton(
          key: const ValueKey("sendButton"),
          icon: Icon(Icons.send_rounded),
          onPressed: () {
            viewModel.saveMessage(chatRoom.id, controller.value.text);
            controller.text = "";
            FirebaseAnalytics().logEvent(name: 'send_message',parameters:null);
          },
        ),
        SizedBox(width: 16)
      ],
    );
  }
}
