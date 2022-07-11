import 'package:flutter/material.dart';

class CheckboxState {
  final String title;
  bool value;

  CheckboxState({
    required this.title,
    this.value = false,
  });
}
