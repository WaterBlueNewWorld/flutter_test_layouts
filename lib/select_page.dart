import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_layouts/landing_page.dart';
import 'package:test_layouts/prueba_form.dart';

import 'form.dart';
import 'map_page.dart';

class Seleccion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccione actividad"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Text("Mapa"),
            ),
            ElevatedButton(
              child: Text("Formulario"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Formulario()));
              }
            ),
            ElevatedButton(
              child: Text("Prueba Formulario"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ObservacionForm(idFatiga: 45,)));
              },
            ),
            ElevatedButton(
              child: Text("Prueba OnBoardFragment"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OnBoardScreen()));
              },
            ),

          ],
        ),
      ),
    );
  }

}
