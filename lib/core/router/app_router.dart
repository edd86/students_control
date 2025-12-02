import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:students_control/features/courses/presentation/pages/course_details_page.dart';
import 'package:students_control/features/courses/presentation/pages/course_register_page.dart';
import 'package:students_control/features/login/presentation/pages/login_page.dart';
import 'package:students_control/features/teachers/presentation/pages/teacher_register_page.dart';
import 'package:students_control/features/students/presentation/pages/students_register_page.dart';
import 'package:students_control/features/dashboard/presentation/pages/dashboard_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const TeacherRegisterPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/register_course',
        builder: (context, state) => const CourseRegisterPage(),
      ),
      GoRoute(
        path: '/course_details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CourseDetailsPage(courseId: id);
        },
      ),
      GoRoute(
        path: '/register_student',
        builder: (context, state) => const StudentsRegisterPage(),
      ),
    ],
  );
});
