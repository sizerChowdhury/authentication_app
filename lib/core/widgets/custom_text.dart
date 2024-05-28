import 'package:flutter/material.dart';
import 'package:authentication_app/core/gen/fonts.gen.dart';

class CustomText extends StatelessWidget {
  final String text;

  const CustomText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: FontFamily.circular,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF24786D),
      ),
    );
  }
}
