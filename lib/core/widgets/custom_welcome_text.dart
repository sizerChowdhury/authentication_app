import 'package:flutter/material.dart';
import 'package:authentication_app/core/gen/fonts.gen.dart';

class CustomWelcomeText extends StatelessWidget {
  final String text;

  const CustomWelcomeText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: FontFamily.circular,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Color(0xFF797C7B),
      ),
    );
  }
}
