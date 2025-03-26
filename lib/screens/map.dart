import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key, this.isSelecting = true, this.location});

  final bool isSelecting;
  final PlaceLocation? location;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Tentukan lokasi' : 'Lokasi Tempat'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () async {
                if (_pickedLocation == null) {
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Belum ada lokasi yang dipilih'),
                      content:
                          const Text('Silahkan pilih lokasi terlebih dahulu'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                      titleTextStyle: Theme.of(context).textTheme.titleLarge,
                      contentTextStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: Theme.of(context).colorScheme.onSurface),
                    ),
                  );
                }

                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
          onTap: !widget.isSelecting
              ? null
              : (argument) {
                  setState(() {
                    _pickedLocation =
                        LatLng(argument.latitude, argument.longitude);
                  });
                },
          initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.location!.latitude, widget.location!.longitude),
            zoom: 16,
          ),
          markers: _pickedLocation == null && widget.isSelecting
              ? {}
              : {
                  Marker(
                    markerId: const MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(widget.location!.latitude,
                            widget.location!.longitude),
                  ),
                }),
    );
  }
}
