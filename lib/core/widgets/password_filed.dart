import 'package:flutter/material.dart';
import 'package:authentication_app/core/gen/fonts.gen.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isSecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _isSecurePassword,
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
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isSecurePassword = !_isSecurePassword;
            });
          },
          icon: _isSecurePassword
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}
