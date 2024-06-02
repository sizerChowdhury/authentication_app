import 'package:flutter/material.dart';

class Underline extends StatelessWidget {
  final double left;
  final double right;
  final double bottom;
  final double height;

  const Underline({
    super.key,
    this.left = 0,
    required this.right,
    this.bottom = 0,
    this.height = 9,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        height: height,
        color: const Color(0xFF24786D).withOpacity(0.7),
      ),
    );
  }
}
