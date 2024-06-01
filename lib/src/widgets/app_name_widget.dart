import 'package:flutter/material.dart';
import 'package:green_grocer/src/config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  final Color? greenTitleColor;
  final double fontSize;
  const AppNameWidget({
    super.key,
    this.greenTitleColor,
    this.fontSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            style: TextStyle(fontSize: fontSize),
            children: [
              TextSpan(
                text: 'Green',
                style: TextStyle(color: greenTitleColor ?? CustomColors.customSwatchColor),
              ),
              TextSpan(
                text: 'grocer',
                style: TextStyle(color: CustomColors.customContrastColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
