//import 'package:first_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/core/gen/fonts.gen.dart';

class AppbarTittle extends StatelessWidget {
  final String text;

  const AppbarTittle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: FontFamily.caros,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Color(0xFF000E08),
      ),
    );
  }
}
