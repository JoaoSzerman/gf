import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color c = const Color(0xFFF2994A);
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Align(
        alignment: Alignment.topLeft,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
            ),
            child: Icon(
              Icons.arrow_back,
              size: screenWidth * 0.09,
              color: c,
            ),
          ),
        ),
      ),
    );
  }
}
