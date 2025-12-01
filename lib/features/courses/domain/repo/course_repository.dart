import 'package:students_control/core/utils/data_response.dart';
import 'package:students_control/features/courses/domain/entities/course.dart';
import 'package:students_control/features/courses/domain/entities/schedule.dart';

abstract class CourseRepository {
  Future<DataResponse<List<Course>>> getAllCourses();
  Future<DataResponse<List<Course>>> getCoursesByName(String name);
  Future<DataResponse<Course>> addCourse(
    Course course,
    List<Schedule> schedules,
  );
}
