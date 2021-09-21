import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dishcord/widgets/chat/icon/food_icon_icons.dart';

class IconInfo {
  Color color;
  IconData iconData;
  IconInfo({this.iconData, this.color});
}

class IconHelper {
  IconHelper._();
  static const List<String> _iconMessages = [
    ':ramen:',
    ':lahmacun:',
    ':grape:',
  ];

  static IconInfo getIconFromMessage(String message) {
    return getIconFromIconName(message.replaceAll(':', ''));
  }

  static IconInfo getIconFromIconName(String iconName) {
    switch (iconName) {
      case 'ramen':
        return IconInfo(iconData: FoodIcon.ramen, color: Colors.orange[200]);
      case 'lahmacun':
        return IconInfo(iconData: FoodIcon.pizza, color: Colors.brown);
      case 'grape':
        return IconInfo(iconData: FoodIcon.grape, color: Colors.green[800]);
    }
    return null;
  }

  static String getMessageFromIconName(String iconName) {
    switch (iconName) {
      case 'ramen':
        return _iconMessages[0];
      case 'lahmacun':
        return _iconMessages[1];
      case 'grape':
        return _iconMessages[2];
    }
    return null;
  }

  static bool isIcon(String message) {
    return _iconMessages.contains(message);
  }
}