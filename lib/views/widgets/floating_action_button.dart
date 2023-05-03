import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key, required this.onPressed,required this.color});
  final Function() onPressed;
  final Color color ;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: color,
      child: const Icon(FontAwesomeIcons.plus, size: 20,),
    );
  }
}
