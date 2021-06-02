import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  String label;
  IconData icon;
  Color color;
  Function fun;
  GlobalKey key;

  Buttons({
    @required this.label,
    @required this.icon,
    @required this.fun,
    @required this.key,
    this.color = Colors.blue,
  });

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ElevatedButton(
        onPressed: fun,
        child: Container(
          height: 57.0,
          width: 57.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Icon(icon),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: CircleBorder(),
          shadowColor: Colors.black,
        ),
      ),
      SizedBox(
        height: 12.0,
      ),
      Text(label)
    ]);
  }
}
