import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key, this.isSelecting = false, location})
      : location =
            PlaceLocation(latitude: 37.422, longitude: -122.084, address: '');

  final bool isSelecting;
  final PlaceLocation? location;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Tentukan lokasi' : 'Lokasi Tempat'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.location!.latitude, widget.location!.longitude),
            zoom: 16,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('m1'),
              position:
                  LatLng(widget.location!.latitude, widget.location!.longitude),
            ),
          }),
    );
  }
}
