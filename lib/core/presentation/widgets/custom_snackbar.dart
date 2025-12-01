import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({super.key, required String message, Color? textColor})
    : super(
        content: Text(
          message,
          style: TextStyle(color: textColor ?? Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      );
}
