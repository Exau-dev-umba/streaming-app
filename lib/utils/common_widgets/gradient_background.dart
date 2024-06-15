import 'package:flutter/material.dart';

import '../../values/app_colors.dart';
import '../extensions.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    required this.children,
    this.colors = AppColors.transparentGradient,
    super.key,
  });

  final List<Color> colors;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/gaz/image_8336_Gaz-Mawete-1080x811.jpg",
        ),
        DecoratedBox(
          decoration: BoxDecoration(gradient: LinearGradient(colors: colors)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height:  125// context.heightFraction(sizeFraction: 0.1),
                ),
                ...children,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
