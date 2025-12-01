import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:students_control/core/presentation/widgets/rotating_loader.dart';
import 'package:students_control/features/courses/presentation/providers/courses_providers.dart';
import 'package:students_control/features/courses/presentation/widgets/course_card.dart';
import 'package:students_control/features/courses/presentation/widgets/course_page_header.dart';

class CoursesPage extends ConsumerWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsyncValue = ref.watch(coursesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Light grey background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Column(
            children: [
              const CoursePageHeader(),
              const Divider(color: Colors.grey, thickness: 1),
              Expanded(
                child: coursesAsyncValue.when(
                  skipLoadingOnRefresh: false,
                  data: (courses) {
                    if (courses.isEmpty) {
                      return const Center(
                        child: Text('No hay cursos disponibles'),
                      );
                    }
                    return ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return CourseCard(
                          title: course.name,
                          subtitle:
                              '${course.academicTerm} - ${course.code ?? "Sin código"}',
                          icon: Icons.book_outlined,
                          iconColor: const Color(0xFF2563EB),
                          iconBackgroundColor: const Color(0xFFDBEAFE),
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: RotatingLoader(
                      icon: Icons.school_outlined, // Or any other icon
                      size: 40,
                    ),
                  ),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/register_course'),
        backgroundColor: const Color(0xFF2563EB), // Blue color
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
