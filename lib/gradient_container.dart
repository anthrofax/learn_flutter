import 'package:flutter/material.dart';
import 'package:learn_flutter/styled_text.dart';

// Alignment? startAlignment;
Alignment startAlignment = Alignment.topLeft;
Alignment endAlignment = Alignment.bottomRight;

// Solution 1 (Challenge of making reusable widget)
class GradientContainer extends StatelessWidget {
  // const GradientContainer({key}) : super(key: key);

  const GradientContainer({super.key, required this.colors});

  final List<Color> colors;

  @override
  Widget build(context) {
    // startAlignment = Alignment.topLeft;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors, begin: startAlignment, end: endAlignment),
      ),
      child: const Center(
        child: StyledText('Hello world!'),
      ),
    );
  }
}

// Solution 2 (Challenge of making reusable widget)
// class GradientContainer extends StatelessWidget {
//   // const GradientContainer({key}) : super(key: key);
//   const GradientContainer(this.firstColor, this.secondColor, {super.key});

//   final Color firstColor;
//   final Color secondColor;

//   @override
//   Widget build(context) {
//     // startAlignment = Alignment.topLeft;
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             colors: [firstColor, secondColor],
//             begin: startAlignment,
//             end: endAlignment),
//       ),
//       child: const Center(
//         child: StyledText('Hello world!'),
//       ),
//     );
//   }
// }