import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/model/randon_recipe.dart';

class TextFavCard extends StatefulWidget {
  final dynamic savedRecipes;
  const TextFavCard({Key? key, required this.savedRecipes}) : super(key: key);

  @override
  State<TextFavCard> createState() => _TextFavCardState();
}

class _TextFavCardState extends State<TextFavCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth * 0.50,
      height: screenHeight * 0.06,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.savedRecipes["type"].isNotEmpty
              ? Padding(
                  padding: EdgeInsets.fromLTRB(0, screenWidth * 0.00, 0, 0),
                  child: Text(
                    widget.savedRecipes["type"]
                        .split(",")[0]
                        .replaceAll(RegExp(r"\p{P}", unicode: true), " "),
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.0175,
                    ),
                  ),
                )
              : const SizedBox(),
          SizedBox(
            width: screenWidth * 0.7,
            height: screenHeight * 0.026,
            child: Center(
              child: Text(
                widget.savedRecipes["name"],
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
