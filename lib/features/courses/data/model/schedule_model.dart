import 'package:flutter/material.dart';

class ScheduleModel {
  final int? id;
  final int? courseId;
  final int dayOfWeek;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? classroom;

  ScheduleModel({
    this.id,
    this.courseId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.classroom,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      id: map['id'],
      courseId: map['course_id'],
      dayOfWeek: map['day_of_week'],
      startTime: _parseTime(map['start_time']),
      endTime: _parseTime(map['end_time']),
      classroom: map['classroom'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course_id': courseId,
      'day_of_week': dayOfWeek,
      'start_time': _formatTime(startTime),
      'end_time': _formatTime(endTime),
      'classroom': classroom,
    };
  }

  static TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
