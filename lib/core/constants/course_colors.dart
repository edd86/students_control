import 'package:flutter/material.dart';

enum CourseColors {
  red('Red', Color(0xFFFF5252)),
  orange('Orange', Color(0xFFFF9800)),
  yellow('Yellow', Color(0xFFFFEB3B)),
  green('Green', Color(0xFF4CAF50)),
  teal('Teal', Color(0xFF009688)),
  blue('Blue', Color(0xFF2196F3)),
  purple('Purple', Color(0xFF9C27B0)),
  grey('Grey', Color(0xFF9E9E9E));

  final String name;
  final Color color;

  const CourseColors(this.name, this.color);

  static Color getColor(String name) {
    return CourseColors.values
        .firstWhere(
          (element) => element.name.toLowerCase() == name.toLowerCase(),
          orElse: () => CourseColors.grey,
        )
        .color;
  }

  static String getName(Color color) {
    return CourseColors.values
        .firstWhere(
          (element) => element.color == color,
          orElse: () => CourseColors.grey,
        )
        .name;
  }
}
