import 'package:flutter/material.dart';
import '../../../data/model/recipe.dart';

class IMGCard extends StatefulWidget {
  final Recipe recipe;

  const IMGCard({Key? key, required this.recipe}) : super(key: key);

  @override
  State<IMGCard> createState() => _IMGCardState();
}

class _IMGCardState extends State<IMGCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return widget.recipe.image != null
        ? SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.28,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.recipe.image.toString(),
              ),
            ),
          )
        : SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.28,
            child: const Center(
              child: Text("NO IMAGE"),
            ),
          );
  }
}
