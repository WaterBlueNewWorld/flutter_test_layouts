import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_layouts/landing_page.dart';
import 'package:test_layouts/prueba_form.dart';
import 'package:test_layouts/test_shadow_offset.dart';

import 'form.dart';
import 'google_map_tests.dart';
import 'map_page.dart';

class Seleccion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccione Widget"),
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
              child: Text("Alineaciones"),
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
            ElevatedButton(
              child: Text("Prueba Google Maps"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GoogleMapsTest()));
              },
            ),
            ElevatedButton(
              child: Text("Prueba Shadow Offset"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ShadowDemo()));
              },
            ),
          ],
        ),
      ),
    );
  }

}
