import 'package:flutter/material.dart';
import 'package:first_app/core/gen/fonts.gen.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  //final bool obscureText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    //this.obscureText = false,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      //obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: FontFamily.circular,
          color: Color(0xFFC1CAD0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFC1CAD0),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF24786D),
          ),
        ),
      ),
    );
  }
}
