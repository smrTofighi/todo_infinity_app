import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton(
      {super.key, required this.onPressed, required this.color, required this.icon});
  final Function() onPressed;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: color,
      child: Icon(
        icon,
        size: 20,
      ),
    );
  }
}
