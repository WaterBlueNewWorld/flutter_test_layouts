import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

class CustomPopupmenu {
  Rect pos;
  List<MenuItem> items;
  int cantidad;
  ValueChanged<MenuItemProvider> onClick;
  ValueChanged<bool> onState;
  VoidCallback onClose;

  CustomPopupmenu(
      {required this.pos,
      required this.items,
      required this.cantidad,
      required this.onClick,
      required this.onClose,
      required this.onState});

  static Rect getWidgetGlobalRect(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
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
