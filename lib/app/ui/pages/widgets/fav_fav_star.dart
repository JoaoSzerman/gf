import 'package:flutter/material.dart';
import '../../../data/model/randon_recipe.dart';
import '../../../data/model/recipe.dart';

class FavFavStar extends StatefulWidget {
  const FavFavStar({
    Key? key,
    required this.recipe,
    required this.isActive,
  }) : super(key: key);
  final GetRecipeById recipe;
  final bool isActive;

  @override
  State<FavFavStar> createState() => _FavFavStarState();
}

class _FavFavStarState extends State<FavFavStar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Color c = const Color(0xFFF2994A);

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Align(
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: ShapeDecoration(
              color: c,
              shape: const CircleBorder(),
            ),
            child: Icon(
              widget.isActive ? Icons.star_rounded : Icons.star_border_rounded,
              size: screenWidth * 0.09,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
