import 'package:flutter/material.dart';
import 'package:students_control/features/courses/domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({
    super.id,
    super.courseId,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    super.classroom,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      id: map['id'] as int?,
      courseId: map['course_id'] as int?,
      dayOfWeek: map['day_of_week'] as int,
      startTime: _parseTime(map['start_time'] as String),
      endTime: _parseTime(map['end_time'] as String),
      classroom: map['classroom'] as String?,
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
