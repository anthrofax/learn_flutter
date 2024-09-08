import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
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
            child: Text(
              "Lokasi tempat belum ditentukan",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            )),
        Row(
          children: [
            TextButton.icon(
              onPressed: () {},
              label: const Text("Gunakan lokasi saat ini"),
              icon: const Icon(Icons.location_pin),
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text(
                "Tentukan lokasi melalui Map",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              icon: const Icon(Icons.map),
            )
          ],
        )
      ],
    );
  }
}
