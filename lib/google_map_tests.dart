import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsTest extends StatefulWidget {
  @override
  _StateGoogleMapsTest createState() => _StateGoogleMapsTest();
}

class _StateGoogleMapsTest extends State<GoogleMapsTest>{
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markerss = {
    Marker(
      markerId: MarkerId("1"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(28.70597003310992, -106.12205351138263)
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: markerss,
        rotateGesturesEnabled: false,
        mapType: MapType.normal,
        myLocationEnabled: false,
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(28.70597003310992, -106.12205351138263)
        ),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(28.684683759247577, -106.11137847015385),
                bearing: 192,
                tilt: 59,
                zoom: 19
              )
            )
          );
        },
        label: Text("AAA")
      )
    );
  }
}
