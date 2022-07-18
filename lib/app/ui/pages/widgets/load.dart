import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/randon_recipe.dart';

class Back extends StatelessWidget {
  const Back({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color c = const Color(0xFFF2994A);

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * 0.03),
      child: Container(
        height: screenWidth * 0.1,
        width: screenWidth * 0.35,
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Back',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
