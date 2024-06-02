import 'package:flutter/material.dart';

class LoginPageLogo extends StatelessWidget {
  final Widget logo;

  const LoginPageLogo({super.key, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: logo,
    );
  }
}
