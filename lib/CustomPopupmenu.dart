import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

class CustomPopupmenu {
  Rect pos;
  List<MenuItem> items;
  int cantidad;
  Function onClick;
  Function onState;
  Function onClose;

  CustomPopupmenu(
      {this.pos,
      @required this.items,
      @required this.cantidad,
      this.onClick,
      this.onClose,
      this.onState});

  static Rect getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  popupmenu() {
    PopupMenu(
            maxColumn: cantidad,
            items: items,
            onClickMenu: onClick,
            onDismiss: onClose,
            stateChanged: onState)
        .show(rect: pos);
  }
}
