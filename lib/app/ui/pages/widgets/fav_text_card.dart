import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/model/randon_recipe.dart';
import '../../../data/model/recipe.dart';

class FavTextCard extends StatefulWidget {
  final GetRecipeById recipe;
  const FavTextCard({Key? key, required this.recipe}) : super(key: key);

  @override
  State<FavTextCard> createState() => _FavTextCardState();
}

class _FavTextCardState extends State<FavTextCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth * 0.9,
      height: screenHeight * 0.08,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.recipe.dishTypes.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.fromLTRB(0, screenHeight * 0.004, 0, 0),
                  child: Text(
                    widget.recipe.dishTypes[0],
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.0175,
                    ),
                  ),
                )
              : const SizedBox(),
          SizedBox(
            width: screenWidth * 0.7,
            height: screenHeight * 0.026,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                widget.recipe.title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      'Prep time: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.0175,
                      ),
                    ),
                    // Text(
                    //   "${widget.recipe.readyInMinutes.toString()} min",
                    //   style: GoogleFonts.inter(
                    //     fontSize: screenHeight * 0.0175,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      'Serves: ',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.0175,
                      ),
                    ),
                    if (widget.recipe.servings == 1) ...{
                      Text(
                        "${widget.recipe.servings} person",
                        style: GoogleFonts.inter(
                          fontSize: screenHeight * 0.0175,
                        ),
                      ),
                    } else
                      Text(
                        "${widget.recipe.servings} people",
                        style: GoogleFonts.inter(
                          fontSize: screenHeight * 0.0175,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
