import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget zoomPlus(double _zoomVal, Completer<GoogleMapController> _controller) {
  return Padding(
    padding: EdgeInsets.only(top: 38),
    child: Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () {
          _zoomVal++;
          _plus(_zoomVal, _controller);
        },
        icon: Icon(FontAwesomeIcons.searchPlus),
      ),
    ),
  );
}

Future<void> _plus(
    double zoomVal, Completer<GoogleMapController> _controller) async {
  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(40.675176, -73.944590), zoom: zoomVal),
    ),
  );
}

Widget zoomMinus(double _zoomVal, Completer<GoogleMapController> _controller) {
  return Padding(
    padding: const EdgeInsets.only(top: 38.0),
    child: Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          print(_zoomVal);
          _zoomVal--;
          _minus(_zoomVal, _controller);
        },
        icon: Icon(FontAwesomeIcons.searchMinus),
        color: Colors.black87,
      ),
    ),
  );
}

Future<void> _minus(
    double zoomVal, Completer<GoogleMapController> _controller) async {
  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    target: LatLng(40.675176, -73.944590),
    zoom: zoomVal,
  )));
}
