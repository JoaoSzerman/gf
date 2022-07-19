import 'package:flutter/material.dart';
import '../../../data/model/randon_recipe.dart';

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
  List a = [
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
    "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/08/09/21/54/yellowstone-national-park-1581879_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
    "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
  ];
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
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            height: screenWidth * 0.16,
            width: screenWidth * 0.16,
            child: const Center(
              child: Text("NO IMAGE"),
            ),
          );
  }
}
