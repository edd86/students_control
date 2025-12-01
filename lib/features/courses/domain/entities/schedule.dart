import 'package:flutter/material.dart';

class Schedule {
  final int? id;
  final int? courseId;
  final int dayOfWeek; // 1 = Monday, 7 = Sunday
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? classroom;

  const Schedule({
    this.id,
    this.courseId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.classroom,
  });
}
