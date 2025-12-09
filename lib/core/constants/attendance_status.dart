import 'package:flutter/material.dart';

enum AttendanceStatus {
  presente('Presente', Color(0xFF4CAF50)),
  ausente('Ausente', Color(0xFFF44336)),
  tardanza('Tardanza', Color(0xFFFFC107)),
  licencia('Licencia', Color(0xFF2196F3));

  final String label;
  final Color color;

  const AttendanceStatus(this.label, this.color);
}
