import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget buildGoogleMap(BuildContext context,
    Completer<GoogleMapController> controller, List<Marker> markerList) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: GoogleMap(
      initialCameraPosition:
          CameraPosition(target: LatLng(40.675176, -73.944590), zoom: 3),
      markers: Set<Marker>.of(markerList),
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController _controller) {
        controller.complete(_controller);
      },
    ),
  );
}
