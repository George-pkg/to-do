import 'package:flutter/material.dart';

Widget buttonWidget({
  String text = '',
  required void Function()? onPressed,
}) {
  return TextButton(
      style: const ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(150, 50)),
          backgroundColor: MaterialStatePropertyAll(Colors.white70)),
      onPressed: onPressed,
      child: Text(text));
}
