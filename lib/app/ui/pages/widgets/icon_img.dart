import 'package:flutter/material.dart';
import '../../../data/model/recipe.dart';

class IconIMG extends StatefulWidget {
  final Recipe recipe;

  const IconIMG({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<IconIMG> createState() => _IconIMGState();
}

class _IconIMGState extends State<IconIMG> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return widget.recipe.image != null
        ? Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    widget.recipe.image.toString(),
                  ),
                  fit: BoxFit.cover),
              shape: BoxShape.circle,
            ),
            height: screenWidth * 0.16,
            width: screenWidth * 0.16,
          )
        : Container(
            child: const Center(
              child: Text("NO IMAGE"),
            ),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            height: screenWidth * 0.16,
            width: screenWidth * 0.16,
          );
  }
}
