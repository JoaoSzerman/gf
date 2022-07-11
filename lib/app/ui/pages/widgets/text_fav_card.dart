// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../data/model/recipe.dart';

// class TextFavCard extends StatefulWidget {
//   final Recipe recipe;
//   const TextFavCard({Key? key, required this.recipe}) : super(key: key);

//   @override
//   State<TextFavCard> createState() => _TextFavCardState();
// }

// class _TextFavCardState extends State<TextFavCard> {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return SizedBox(
//       width: screenWidth * 0.35,
//       height: screenHeight * 0.04,
//       child: SizedBox(
//         width: screenWidth * 0.35,
//         height: screenHeight * 0.026,
//         child: FittedBox(
//           fit: BoxFit.contain,
//           child: Text(
//             widget.recipe.title!,
//             style: GoogleFonts.inter(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
