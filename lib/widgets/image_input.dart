import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: TextButton.icon(
        onPressed: () {},
        label: const Text("Add Image"),
        icon: const Icon(Icons.camera),
      ),
    ));
  }
}
