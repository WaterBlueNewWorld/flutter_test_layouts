import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
      title: 'Flutter Demo',
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
  ScrollController controller;
  final GlobalKey<ScaffoldState> _state = new GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    _fabHeight = _initSize;
  }
  
  @override
  Widget build(BuildContext context) {
    _openSize = MediaQuery.of(context).size.height * .80;
    
    return Scaffold(
      key: _state,
      body: col(),
      drawer: MainPageDrawer(),
    );
  }

  Widget _body() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(28.441753, -106.011476),
        zoom: 13,
        maxZoom: 15,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"),
        MarkerLayerOptions(markers: [
          Marker(
              point: LatLng(28.441753, -106.011476),
              builder: (ctx) => Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 48.0,
              ),
              height: 60),
        ]),
      ],
    );
  }

  Widget col(){
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SlidingUpPanel(
          renderPanelSheet: false,
          parallaxEnabled: true,
          parallaxOffset: .5,
          backdropTapClosesPanel: true,
          backdropEnabled: true,
          backdropColor: Colors.black,
          backdropOpacity: 0.5,
          maxHeight: _openSize,
          minHeight: _closeSize,
          body: _body(),
          onPanelSlide: (double pos) => setState((){
            _fabHeight = pos * (_openSize - _closeSize) + _initSize;
          }),
          panel: Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                )
              ],
            ),
            margin: const EdgeInsets.fromLTRB(2.0, 15.0, 2.0, 0),
          ),
          collapsed: Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 55.0),
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
    );
  }
}