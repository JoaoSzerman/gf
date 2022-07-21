import 'package:flutter/material.dart';
import '../../../data/model/recipe.dart';

class FavIMGCard extends StatefulWidget {
  final GetRecipeById recipe;

  const FavIMGCard({Key? key, required this.recipe}) : super(key: key);

  @override
  State<FavIMGCard> createState() => _FavIMGCardState();
}

class _FavIMGCardState extends State<FavIMGCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return widget.recipe.image == "null" ||
            widget.recipe.image == null ||
            widget.recipe.image.toString() == null ||
            widget.recipe.image.toString() == "null"
        ? SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.28,
            child: const Center(
              child: Text("NO IMAGE"),
            ),
          )
        : SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.28,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.recipe.image.toString(),
              ),
            ),
          );
  }
}
