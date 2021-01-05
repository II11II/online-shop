import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:easy_localization/easy_localization.dart';
class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("shops".tr()),),
        body: FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Icon(Icons.location_on)
            ),
          ],
        ),
      ],
      children: <Widget>[
        TileLayerWidget(
            options: TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'])),
        MarkerLayerWidget(
            options: MarkerLayerOptions(
          markers: [
            Marker(
              width: 10.0,
              height: 10.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Icon(Icons.location_on),
            ),
          ],
        )),
      ],
    ));
  }
}
