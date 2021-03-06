import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:latlong/latlong.dart';
import 'package:test_layouts/drawer.dart';
import 'package:test_layouts/Buttons.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _openSize = 0;
  double _closeSize = 80.0;
  double _initSize = 100.0;
  double _fabHeight = 0;
  final GlobalKey<ScaffoldState> _state = new GlobalKey<ScaffoldState>();
  final GlobalKey _lvState = new GlobalKey();
  final PanelController _pc = new PanelController();
  final GlobalKey keybtn1 = new GlobalKey();
  final GlobalKey keybtn2 = new GlobalKey();
  final GlobalKey keybtn3 = new GlobalKey();
  ScrollController scontroller = new ScrollController();

  void initState() {
    super.initState();
    _fabHeight = _initSize;
  }

  @override
  Widget build(BuildContext context) {
    _openSize = MediaQuery.of(context).size.height * .76;
    PopupMenu.context = context;

    return Scaffold(
      key: _state,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            controller: _pc,
            parallaxEnabled: true,
            parallaxOffset: .5,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            backdropTapClosesPanel: true,
            backdropEnabled: true,
            backdropColor: Colors.black,
            backdropOpacity: 0.5,
            maxHeight: _openSize,
            minHeight: _closeSize,
            body: _body(),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_openSize - _closeSize) + _initSize;
            }),
            panelBuilder: (sc) => _panel(sc),
            onPanelClosed: () {scontroller.animateTo(scontroller.position.minScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);},
            collapsed: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.0),
                    Container(
                        width: 30,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius:
                            BorderRadius.all(Radius.circular(30.0))))
                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
              top: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.transparent,
                      )))),
          Positioned(
            top: 35.0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 18.0),
              child: Text(
                "Lector QR PECUU",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
                ],
              ),
            ),
          ),
          Positioned(
              top: 15,
              left: 20.0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(6.0, 20.0, 0, 0),
                child: FloatingActionButton(
                  child: Icon(Icons.menu, color: Colors.blue),
                  backgroundColor: Colors.white,
                  onPressed: () => {_state.currentState!.openDrawer()},
                ),
              ))
        ],
      ),
      drawer: MainPageDrawer(),
    );
  }

  Widget _panel(ScrollController sc2) {
    scontroller = sc2;
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: scontroller,
          children: <Widget>[
            SizedBox(
              height: 36.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Adelitas",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 36.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Buttons(
                    label: "Leer",
                    icon: Icons.qr_code,
                    key: keybtn1,
                    fun: () => {

                    }),
                Buttons(
                    label: "Informacion",
                    icon: Icons.drag_indicator,
                    color: Colors.red,
                    key: keybtn2,
                    fun: () => {

                    }),
                Buttons(
                    label: "M??s",
                    icon: Icons.more_horiz,
                    color: Colors.green,
                    key: keybtn3,
                    fun: () => {

                    }),
              ],
            ),
            SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Images",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl:
                        "https://upload.wikimedia.org/wikipedia/commons/0/06/Las_adelitas.jpg",
                        height: MediaQuery.of(context).size.height / 2,
                        width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                        fit: BoxFit.cover,
                      ),
                      CachedNetworkImage(
                        imageUrl:
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Museo_Nacional_de_la_Revoluci%C3%B3n_-_Adelita.jpg/800px-Museo_Nacional_de_la_Revoluci%C3%B3n_-_Adelita.jpg",
                        width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                        height: MediaQuery.of(context).size.height / 2,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("About",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    """Se conoce como adelitas o soldaderas a las mujeres que participaron en la Revoluci??n mexicana, en los contingentes militares de grupos revolucionarios como soldados, cocineras, enfermeras o ayudantes. La mejor adelita. Adela Velarde P??rez fue la mujer cuyo nombre representar??a a todas las enfermeras que prestaron sus servicios no s??lo para cuidar de los enfermos y heridos durante la Revoluci??n Mexicana, sino para cargar armas, encargarse de los alimentos e incluso participar en batallas si as?? se requer??a, seg??n la Secretar??a de Cultura. Versiones historiogr??ficas y period??sticas coinciden en se??alar a Adela Velarde P??rez, enfermera oriunda de Ciudad Ju??rez, como la persona que inspir?? el corrido popular ??Adelita??. Fue nieta de Rafael Velarde, amiga de Benito Ju??rez, quien dio alojamiento al Benem??rito de las Am??ricas en su exilio en Paso del Norte (hoy Ciudad Ju??rez). En 1914, "Adelita" atendi?? al soldado herido Antonio del R??o Armenta, quien le compuso la famosa canci??n-marcha.
Adelita atend??a a los heridos villistas de la Divisi??n del Norte, como parte de la Brigada de la Cruz que form?? la se??ora Leonor Villegas de Man??n.
 
Al concluir la lucha armada, Adela Velarde P??rez, perfectamente identificada, recibi?? a??os despu??s un homenaje como veterana de guerra. 
Es importante se??alar que el verdadero autor de la letra de la canci??n "Adelita" fue Guadalupe Barajas Romero, originario de Huecorio, Municipio de P??tzcuaro, Michoac??n, M??xico, sin que haya evidencia de que Adela Velarde P??rez haya sido su musa inspiradora. Familiares del se??or Barajas tienen en su poder la letra original firmada por su autor.
Cada 20 de noviembre, muchas ni??as se disfrazan de adelitas como parte de las actividades para la celebraci??n del d??a de la Revoluci??n mexicana.

Adem??s de la ya conocida Adelita, existen otras soldaderas de relevancia en la historia de la Revoluci??n Mexicana. Tal es el caso de Petra Herrera, quien tuvo que luchar disfrazada de hombre y bajo el seud??nimo de Pedro Herrera, pero gracias a sus notables haza??as gan?? reconocimiento por parte de sus compa??eros de batalla.
                  """,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ));
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  Widget _body() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(28.656734, -106.07949787470359),
        zoom: 13,
        maxZoom: 18,
        interactiveFlags: InteractiveFlag.pinchZoom |
        InteractiveFlag.drag |
        InteractiveFlag.doubleTapZoom,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(markers: [
          Marker(
              point: LatLng(28.656734, -106.079497),
              builder: (ctx) => Container(
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 48.0,
                ),
              ),
              height: 60,
              width: 60),
        ]),
      ],
    );
  }
}
