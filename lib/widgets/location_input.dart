import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final Function(PlaceLocation pickedLocation) onSelectLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;

  void _takeLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData currentLocation;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    currentLocation = await location.getLocation();

    final lat = currentLocation.latitude;
    final lng = currentLocation.longitude;

    if (lat == null || lng == null) return;

    final apiUri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${dotenv.env['GOOGLE_MAP_API_KEY']}');
    final response = await http.get(apiUri);
    final decodedResponse = json.decode(response.body);
    final address = decodedResponse['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation =
          PlaceLocation(latitude: lat, longitude: lng, address: address);
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);
  }

  String get _locationImage {
    if (_pickedLocation == null) {
      return '';
    }

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=${dotenv.env['GOOGLE_MAP_API_KEY']}";
  }

  @override
  Widget build(BuildContext context) {
    Widget isPreviewContent = Text(
      "Lokasi tempat belum ditentukans",
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );

    if (_pickedLocation != null) {
      isPreviewContent = Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        width: double.infinity,
        height: 170,
        child: Image.network(_locationImage,
            width: double.infinity, height: double.infinity),
      );
    }

    if (_isGettingLocation) {
      isPreviewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2)),
            ),
            alignment: Alignment.center,
            height: 170,
            child: isPreviewContent),
        Row(
          children: [
            TextButton.icon(
              onPressed: _takeLocation,
              label: const Text("Gunakan lokasi saat ini"),
              icon: const Icon(Icons.location_pin),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () {},
                label: const Text(
                  "Tentukan lokasi melalui Map",
                ),
                icon: const Icon(Icons.map),
              ),
            )
          ],
        )
      ],
    );
  }
}
