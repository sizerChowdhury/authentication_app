import 'package:flutter/material.dart';

class CircularTile extends StatelessWidget {
  final String imagePath;
  const CircularTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Image.asset(
        imagePath,
        height: 25,
      ),
    );
  }
}
