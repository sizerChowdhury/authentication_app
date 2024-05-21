import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:first_app/core/gen/fonts.gen.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final String url;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 35, right: 35),
      child: ElevatedButton(
        onPressed: () {
          context.go(url);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontFamily: FontFamily.circular,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF797C7B),
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xFFF3F6F6),
          ),
        ),
      ),
    );
  }
}
