import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quake_app/model/quake.dart';
import 'package:quake_app/network/network.dart';
import 'package:quake_app/ui/widgets/build_maps.dart';
import 'package:quake_app/ui/widgets/zoom_minus.dart';

class QuakesApp extends StatefulWidget {
  const QuakesApp({Key? key}) : super(key: key);

  @override
  _QuakesAppState createState() => _QuakesAppState();
}

class _QuakesAppState extends State<QuakesApp> {
  late Future<Quake> _quakeData;

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markerList = <Marker>[];
  double _zoomval = 5.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quakeData = Network().getAllQuakes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildGoogleMap(context, _controller, _markerList),
          zoomMinus(_zoomval, _controller),
          zoomPlus(_zoomval, _controller)
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _findQuakes();
        },
        label: Text('Find Quakes'),
      ),
    );
  }

  _findQuakes() {
    setState(() {
      _markerList.clear();
      _handleResponse();
    });
  }

  void _handleResponse() {
    setState(() {
      _quakeData.then((quakes) => {
            quakes.features.forEach((quake) {
              return _markerList.add(Marker(
                markerId: MarkerId(quake.id.toString()),
                infoWindow: InfoWindow(
                    title: quake.properties?.mag.toString(),
                    snippet: quake.properties?.title),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
                position: LatLng(quake.geometry!.coordinates![1].toDouble(),
                    quake.geometry!.coordinates![0]),
                onTap: () {},
              ));
            })
          });
    });
  }
}
