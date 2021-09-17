import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardScreen extends StatefulWidget{

  @override
  StateOnBoardScreen createState() => StateOnBoardScreen();
}

class StateOnBoardScreen extends State<OnBoardScreen>{
  GlobalKey keyIntro = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        key: keyIntro,
        done: const Text("Done"),
        skip: const Text("Skip"),
        next: const Icon(Icons.navigate_next),
        pages: [
          PageViewModel(
            title: "PRUEBA PRUEBA",
            body: "sdjlfhskdfg",
              image: const Center(
                child: Icon(Icons.android),
              )
          ),
          PageViewModel(
            title: "dos dos",
            body: "sklafwegvhdafkgakfgafgk",
            image: const Center(
              child: Icon(Icons.android),
            )
          )
        ],
        onDone: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
