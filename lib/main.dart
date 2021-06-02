import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:latlong/latlong.dart';
import 'package:test_layouts/drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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
  

  void initState() {
    super.initState();
    _fabHeight = _initSize;
  }

  final ScrollController scontroller = new ScrollController();
  
  @override
  Widget build(BuildContext context) {
    _openSize = MediaQuery.of(context).size.height * .80;
    PopupMenu.context = context;
    
    return Scaffold(
      key: _state,
      body: Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SlidingUpPanel(
          parallaxEnabled: true,
          parallaxOffset: .5,
          borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
          backdropTapClosesPanel: false,
          backdropEnabled: true,
          backdropColor: Colors.black,
          backdropOpacity: 0.5,
          maxHeight: _openSize,
          minHeight: _closeSize,
          body: _body(),
          onPanelSlide: (double pos) => setState((){
            _fabHeight = pos * (_openSize - _closeSize) + _initSize;
          }),
          panelBuilder: (scontroller) => _panel(scontroller),
          onPanelClosed: () {
            //scontroller.animateTo(scontroller.position.minScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
          },
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
                          borderRadius: BorderRadius.all(Radius.circular(30.0))
                      )
                  )
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
                    )
                )
            )
        ),
        Positioned(
          top: 35.0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
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
            padding: const EdgeInsets.fromLTRB(6.0, 18.0, 0, 0),
            child: FloatingActionButton(
              child: Icon(Icons.menu, color: Colors.blue),
              backgroundColor: Colors.white,
              onPressed: () => {_state.currentState.openDrawer()},
            ),
          )
        )
      ],
    ),
      drawer: MainPageDrawer(),
    );
  }


  Widget _panel(ScrollController sc){
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
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
                _button("Leer", Icons.qr_code, Colors.blue),
                _button("Indicaciones", Icons.drag_indicator, Colors.red),
                _button("Más", Icons.more_horiz, Colors.green),
                
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
                    """Se conoce como adelitas o soldaderas a las mujeres que participaron en la Revolución mexicana, en los contingentes militares de grupos revolucionarios como soldados, cocineras, enfermeras o ayudantes. La mejor adelita. Adela Velarde Pérez fue la mujer cuyo nombre representaría a todas las enfermeras que prestaron sus servicios no sólo para cuidar de los enfermos y heridos durante la Revolución Mexicana, sino para cargar armas, encargarse de los alimentos e incluso participar en batallas si así se requería, según la Secretaría de Cultura. Versiones historiográficas y periodísticas coinciden en señalar a Adela Velarde Pérez, enfermera oriunda de Ciudad Juárez, como la persona que inspiró el corrido popular «Adelita». Fue nieta de Rafael Velarde, amiga de Benito Juárez, quien dio alojamiento al Benemérito de las Américas en su exilio en Paso del Norte (hoy Ciudad Juárez). En 1914, "Adelita" atendió al soldado herido Antonio del Río Armenta, quien le compuso la famosa canción-marcha.
Adelita atendía a los heridos villistas de la División del Norte, como parte de la Brigada de la Cruz que formó la señora Leonor Villegas de Manón.
 
Al concluir la lucha armada, Adela Velarde Pérez, perfectamente identificada, recibió años después un homenaje como veterana de guerra. 
Es importante señalar que el verdadero autor de la letra de la canción "Adelita" fue Guadalupe Barajas Romero, originario de Huecorio, Municipio de Pátzcuaro, Michoacán, México, sin que haya evidencia de que Adela Velarde Pérez haya sido su musa inspiradora. Familiares del señor Barajas tienen en su poder la letra original firmada por su autor.
Cada 20 de noviembre, muchas niñas se disfrazan de adelitas como parte de las actividades para la celebración del día de la Revolución mexicana.

Además de la ya conocida Adelita, existen otras soldaderas de relevancia en la historia de la Revolución Mexicana. Tal es el caso de Petra Herrera, quien tuvo que luchar disfrazada de hombre y bajo el seudónimo de Pedro Herrera, pero gracias a sus notables hazañas ganó reconocimiento por parte de sus compañeros de batalla.
                  """,
                    softWrap: true,
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

  Widget _button(String label, IconData icon, Color color) {

    return Column(
      children: <Widget>[
      ElevatedButton(
        onPressed: () => {
          popupMenu()
        }, 
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
        SizedBox(height: 12.0,),
        Text(label)
      ]
    );
  }
  
  void popupMenu(){
    PopupMenu menu = PopupMenu(
      items: [
        MenuItem(title: 'Copy', image: Icon(Icons.copy)), 
        MenuItem(title: 'Home', image: Icon(Icons.home, color: Colors.white,)), 
        MenuItem(title: 'Mail', image: Icon(Icons.mail, color: Colors.white,)), 
        MenuItem(title: 'Power', image: Icon(Icons.power, color: Colors.white,)),
        MenuItem(title: 'Setting', image: Icon(Icons.settings, color: Colors.white,)), 
        MenuItem(title: 'Traffic', image: Icon(Icons.traffic, color: Colors.white,))], 
      onClickMenu: onClickMenu, 
      stateChanged: stateChanged,
      onDismiss: onDismiss
      );

    menu.show(rect:const Offset(1.0, 2.0) & const Size(3.0, 4.0));
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');

  Widget _body() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(28.656734, -106.07949787470359),
        zoom: 13,
        maxZoom: 15,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(markers: [
          Marker(
              point: LatLng(28.656734, -106.07949787470359),
              builder: (ctx) => Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 48.0,
              ),
              height: 60
            ),
          ]
        ),
      ],
    );
  }
}