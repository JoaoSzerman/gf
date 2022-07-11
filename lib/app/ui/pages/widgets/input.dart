import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.hintText,
    // required
    this.controller,
    required this.constraints,
    required this.hintStyle,
    this.validator,
    this.labelText,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    required InputDecoration decoration,
  }) : super(key: key);

  final String hintText;
  final TextEditingController? controller;
  final BoxConstraints constraints;
  final TextStyle hintStyle;
  final String? Function(String?)? validator;
  final String? labelText;
  final Icon? icon;
  final IconButton? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        constraints: constraints,
        hintStyle: hintStyle,
        labelText: labelText,
        icon: icon,
        suffixIcon: suffixIcon,
      ),
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
