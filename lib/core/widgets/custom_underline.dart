import 'package:flutter/material.dart';

class Underline extends StatelessWidget {
  final double left;
  final double right;
  final double bottom;
  final double height;

  const Underline({
    Key? key,
    this.left = 0,
    required this.right, // Allow passing the right value
    this.bottom = 0,
    this.height = 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        height: height,
        color: Color(0xFF24786D).withOpacity(0.7),
      ),
    );
  }
}
