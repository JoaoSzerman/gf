import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetinho/app/ui/pages/widgets/search_screen.dart';
import 'package:projetinho/services/remote_services.dart';
import '../../../data/model/search.dart';

class SearchInput extends StatefulWidget {
  final VoidCallback function;

  final List<SearchRecipe> searchRecipies;

  const SearchInput({
    Key? key,
    required this.function,
    required this.searchRecipies,
  }) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    Color c = const Color(0xFFD6A255);
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: screenWidth * 0.1,
        width: screenWidth,
        child: TextField(
          onChanged: (value) async {
            widget.searchRecipies.clear();
            if (value.length > 2) {
              var list = await RemoteService().getRecipe(value);
              widget.searchRecipies.addAll(list);
            }
            widget.function();
          },
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: c,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            hintText: 'Find a recipe',
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
