import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _pickedLocation;
  bool _isGettingLocation = false;

  void _takeLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

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

    locationData = await location.getLocation();

    setState(() {
      _pickedLocation = locationData;
      _isGettingLocation = false;
    });

    final lat = _pickedLocation?.latitude;
    final lng = _pickedLocation?.longitude;
    print('test');

    final apiUri  = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${dotenv.env['GOOGLE_MAP_API_KEY']}');
    final response = await http.get(apiUri);
    final decodedResponse = json.decode(response.body);
    final address = decodedResponse['results'][0];
    print(address);
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
