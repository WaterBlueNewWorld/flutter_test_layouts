import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardScreen extends StatefulWidget{

  @override
  _StateOnBoardScreen createState() => _StateOnBoardScreen();
}

class _StateOnBoardScreen extends State<OnBoardScreen>{
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
            useScrollView: true,
            decoration: PageDecoration(
              imagePadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0)
            ),
            title: "PRUEBA PRUEBA",
            body: "Prueba de tutorial de agregado de negocio \n"
                "sdfsdfsdf",
            image: Center(
              child: Image.asset('assets/aaaaAAAAAAAAAAAAA.png'),
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
