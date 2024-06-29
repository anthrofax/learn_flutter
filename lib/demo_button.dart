import 'package:flutter/material.dart';

class DemoButton extends StatefulWidget {
  const DemoButton({super.key});

  @override
  State<DemoButton> createState() {
    // TODO: implement createState
    return _DemoButtonState();
  }
}

class _DemoButtonState extends State<DemoButton> {
  var _isUnderstood = false;

  @override
  Widget build(BuildContext context) {
    print('DemoButton BUILD called');

    // TODO: implement build
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = false;
                });
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = true;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        ),
        if (_isUnderstood) const Text('Awesome!'),
      ],
    );
  }
}
