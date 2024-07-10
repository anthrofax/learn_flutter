import 'package:flutter/material.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddImageState();
  }
}

class AddImageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: TextButton.icon(
        onPressed: () {},
        label: const Text("Take Picture"),
        icon: const Icon(Icons.camera),
      ),
    );
  }
}
