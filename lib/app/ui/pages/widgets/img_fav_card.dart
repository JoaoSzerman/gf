// import 'package:flutter/material.dart';
// import 'package:projetinho/app/ui/pages/widgets/card2.dart';
// import 'package:sqflite/sqflite.dart';
// import '../../../data/model/recipe.dart';

// class IMGFavCard extends StatefulWidget {
//   final Recipe recipe;

//   const IMGFavCard({Key? key, required this.recipe}) : super(key: key);

//   @override
//   State<IMGFavCard> createState() => _IMGFavCardState();
// }

// var list = db.query('receitas', columns: ["image"]);

// bool firstClick = false;
// var db;
// loadBank() async {
//   db = await openDatabase('db.db', version: 1);
// }

// class _IMGFavCardState extends State<IMGFavCard> {
//   @override
//   void initState() {
//     super.initState();
//     loadBank();
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//     await db.close();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     return SizedBox(
//       width: screenWidth * 0.45,
//       height: screenHeight * 0.2,
//       child: Image(
//         fit: BoxFit.cover,
//         image: NetworkImage(
//           widget.recipe.image.toString(),
//         ),
//       ),
//     );
//   }
// }
