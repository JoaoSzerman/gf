import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavTitle extends StatelessWidget {
  const FavTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.fromLTRB(0, screenHeight * 0.03, 0, screenHeight * 0.03),
      child: SizedBox(
        width: screenWidth * 0.55,
        height: screenHeight * 0.04,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            'Saved Recipe',
            style: GoogleFonts.inter(),
          ),
        ),
      ),
    );
  }
}
