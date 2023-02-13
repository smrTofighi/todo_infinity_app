import 'package:flutter/material.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({Key? key, required this.color, required this.onTap})
      : super(key: key);
  final Color color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: 23,
        height: 23,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
      ),
    );
  }
}
