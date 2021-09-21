import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dishcord/firestore/model/chatroom.dart';
import 'package:dishcord/icon_set_up.dart';

class ChatRoomListItem extends StatelessWidget {
  final ChatRoom chatRoom;
  final Function(ChatRoom) onTapped;
  ChatRoomListItem({Key key, this.chatRoom, this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconInfo = IconHelper.getIconFromIconName(chatRoom.icon);
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 3, right: 8, left: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0)
          ),
          color: Colors.brown[100],
          child: InkWell(
            splashColor: Colors.amber[200],
            onTap: () {
              onTapped(chatRoom);
            },
            child: SizedBox(
              height: 110,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: iconInfo.color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: iconInfo.color,
                            width: 4
                          ),
                          //borderRadius: BorderRadius.all(Radius.circular(4))
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(iconInfo.iconData, size: 40),
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(chatRoom.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ]),
                  Spacer(),
                  Icon(Icons.navigate_next, color:  Colors.black,),
                  SizedBox(width: 13),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
