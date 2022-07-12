import 'package:flutter/material.dart';
import '../../../data/model/randon_recipe.dart';

class FavStar extends StatefulWidget {
  const FavStar({
    Key? key,
    required this.recipe,
    required this.isActive,
  }) : super(key: key);
  final Recipe recipe;
  final bool isActive;

  @override
  State<FavStar> createState() => _FavStarState();
}

class _FavStarState extends State<FavStar> {
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
