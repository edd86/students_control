import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/core/constants/course_colors.dart';
import 'package:students_control/core/constants/course_icons.dart';
import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/courses/data/repo/course_repository_impl.dart';
import 'package:students_control/features/courses/domain/entities/course.dart';
import 'package:students_control/features/courses/domain/entities/schedule.dart';

final courseRepositoryProvider = Provider((ref) => CourseRepositoryImpl());

final courseSearchQueryProvider =
    NotifierProvider<CourseSearchQueryNotifier, String>(
      CourseSearchQueryNotifier.new,
    );

class CourseSearchQueryNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void update(String query) {
    state = query;
  }
}

final coursesProvider = FutureProvider.autoDispose<List<Course>>((ref) async {
  final repository = ref.watch(courseRepositoryProvider);
  final query = ref.watch(courseSearchQueryProvider);

  final DataResponse<List<Course>> response;

  if (query.isEmpty) {
    response = await repository.getAllCourses();
  } else {
    response = await repository.getCoursesByName(query);
  }

  if (response.data == null) {
    throw Exception(response.message);
  }

  return response.data!;
});

final courseSchedulesProvider = FutureProvider.family
    .autoDispose<List<Schedule>, int>((ref, courseId) async {
      final repository = ref.watch(courseRepositoryProvider);
      final response = await repository.getSchedulesByCourseId(courseId);

      if (response.data == null) {
        throw Exception(response.message);
      }

      return response.data!;
    });

final courseAverageProvider = FutureProvider.family.autoDispose<double, int>((
  ref,
  courseId,
) async {
  final repository = ref.watch(courseRepositoryProvider);
  final response = await repository.getCourseAverage(courseId);

  if (response.data == null) {
    throw Exception(response.message);
  }

  return response.data!;
});

final courseDailyAttendanceProvider = FutureProvider.family
    .autoDispose<double, int>((ref, courseId) async {
      final repository = ref.watch(courseRepositoryProvider);
      final response = await repository.getDailyAttendancePercentage(
        courseId,
        DateTime.now(),
      );

      if (response.data == null) {
        throw Exception(response.message);
      }

      return response.data!;
    });

final courseControllerProvider = Provider((ref) => CourseController(ref));

class CourseController {
  final Ref ref;
  CourseController(this.ref);

  Future<DataResponse<Course>> addCourse(
    DataResponse<Course> course,
    List<Schedule> schedules,
  ) async {
    final repository = ref.read(courseRepositoryProvider);
    final result = await repository.addCourse(course.data!, schedules);
    if (result.data != null) {
      ref.invalidate(coursesProvider);
    }
    return result;
  }
}

class ScheduleItemState {
  final String id;
  final List<String> selectedDays;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const ScheduleItemState({
    required this.id,
    this.selectedDays = const [],
    this.startTime = const TimeOfDay(hour: 8, minute: 0),
    this.endTime = const TimeOfDay(hour: 9, minute: 30),
  });

  ScheduleItemState copyWith({
    List<String>? selectedDays,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return ScheduleItemState(
      id: id,
      selectedDays: selectedDays ?? this.selectedDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

class CourseRegisterState {
  final CourseColors selectedColor;
  final CourseIcons selectedIcon;
  final List<ScheduleItemState> schedules;

  const CourseRegisterState({
    this.selectedColor = CourseColors.red,
    this.selectedIcon = CourseIcons.atom,
    this.schedules = const [],
  });

  CourseRegisterState copyWith({
    CourseColors? selectedColor,
    CourseIcons? selectedIcon,
    List<ScheduleItemState>? schedules,
  }) {
    return CourseRegisterState(
      selectedColor: selectedColor ?? this.selectedColor,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      schedules: schedules ?? this.schedules,
    );
  }
}

class CourseRegisterNotifier extends Notifier<CourseRegisterState> {
  @override
  CourseRegisterState build() {
    return CourseRegisterState(
      schedules: [
        ScheduleItemState(id: DateTime.now().millisecondsSinceEpoch.toString()),
      ],
    );
  }

  void setColor(CourseColors color) {
    state = state.copyWith(selectedColor: color);
  }

  void setIcon(CourseIcons icon) {
    state = state.copyWith(selectedIcon: icon);
  }

  void addSchedule() {
    final newSchedule = ScheduleItemState(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    state = state.copyWith(schedules: [...state.schedules, newSchedule]);
  }

  void removeSchedule(String id) {
    if (state.schedules.length <= 1) return; // Keep at least one
    state = state.copyWith(
      schedules: state.schedules.where((s) => s.id != id).toList(),
    );
  }

  void toggleDay(String scheduleId, String day) {
    state = state.copyWith(
      schedules: state.schedules.map((schedule) {
        if (schedule.id == scheduleId) {
          final currentDays = List<String>.from(schedule.selectedDays);
          if (currentDays.contains(day)) {
            currentDays.remove(day);
          } else {
            currentDays.add(day);
          }
          return schedule.copyWith(selectedDays: currentDays);
        }
        return schedule;
      }).toList(),
    );
  }

  void setStartTime(String scheduleId, TimeOfDay time) {
    state = state.copyWith(
      schedules: state.schedules.map((schedule) {
        if (schedule.id == scheduleId) {
          return schedule.copyWith(startTime: time);
        }
        return schedule;
      }).toList(),
    );
  }

  void setEndTime(String scheduleId, TimeOfDay time) {
    state = state.copyWith(
      schedules: state.schedules.map((schedule) {
        if (schedule.id == scheduleId) {
          return schedule.copyWith(endTime: time);
        }
        return schedule;
      }).toList(),
    );
  }
}

final courseRegisterProvider =
    NotifierProvider<CourseRegisterNotifier, CourseRegisterState>(
      CourseRegisterNotifier.new,
    );
