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

final courseControllerProvider = Provider((ref) => CourseController(ref));

class CourseController {
  final Ref ref;
  CourseController(this.ref);

  Future<DataResponse<int>> addCourse(
    Course course,
    List<Schedule> schedules,
  ) async {
    final repository = ref.read(courseRepositoryProvider);
    final result = await repository.addCourse(course, schedules);
    if (result.data != null) {
      ref.invalidate(coursesProvider);
    }
    return result;
  }
}

class CourseRegisterState {
  final CourseColors selectedColor;
  final CourseIcons selectedIcon;
  final List<String> selectedDays;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const CourseRegisterState({
    this.selectedColor = CourseColors.red,
    this.selectedIcon = CourseIcons.atom,
    this.selectedDays = const [],
    this.startTime = const TimeOfDay(hour: 8, minute: 0),
    this.endTime = const TimeOfDay(hour: 9, minute: 30),
  });

  CourseRegisterState copyWith({
    CourseColors? selectedColor,
    CourseIcons? selectedIcon,
    List<String>? selectedDays,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return CourseRegisterState(
      selectedColor: selectedColor ?? this.selectedColor,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      selectedDays: selectedDays ?? this.selectedDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

class CourseRegisterNotifier extends Notifier<CourseRegisterState> {
  @override
  CourseRegisterState build() {
    return const CourseRegisterState();
  }

  void setColor(CourseColors color) {
    state = state.copyWith(selectedColor: color);
  }

  void setIcon(CourseIcons icon) {
    state = state.copyWith(selectedIcon: icon);
  }

  void toggleDay(String day) {
    final currentDays = List<String>.from(state.selectedDays);
    if (currentDays.contains(day)) {
      currentDays.remove(day);
    } else {
      currentDays.add(day);
    }
    state = state.copyWith(selectedDays: currentDays);
  }

  void setStartTime(TimeOfDay time) {
    state = state.copyWith(startTime: time);
  }

  void setEndTime(TimeOfDay time) {
    state = state.copyWith(endTime: time);
  }
}

final courseRegisterProvider =
    NotifierProvider<CourseRegisterNotifier, CourseRegisterState>(
      CourseRegisterNotifier.new,
    );
