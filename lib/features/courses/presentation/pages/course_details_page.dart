import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:students_control/core/constants/attendance_status.dart';
import 'package:students_control/core/presentation/widgets/rotating_loader.dart';
import 'package:students_control/features/courses/presentation/providers/courses_providers.dart';
import 'package:students_control/features/courses/presentation/widgets/attendance_summary_card.dart';
import 'package:students_control/features/enrollments/presentation/providers/enrollments_providers.dart';
import 'package:students_control/features/courses/presentation/widgets/course_schedule_card.dart';
import 'package:students_control/features/courses/presentation/widgets/course_stats_card.dart';
import 'package:students_control/features/courses/presentation/widgets/student_list_item.dart';
import 'package:students_control/features/courses/presentation/widgets/course_options_menu.dart';

class CourseDetailsPage extends ConsumerStatefulWidget {
  final int courseId;

  const CourseDetailsPage({super.key, required this.courseId});

  @override
  ConsumerState<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends ConsumerState<CourseDetailsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);
    final studentCountAsync = ref.watch(studentCountProvider(widget.courseId));
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
        title: coursesAsync.when(
          data: (courses) {
            final course = courses.firstWhere(
              (c) => c.id == widget.courseId,
              orElse: () => courses.first,
            );
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  course.name,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  course.group ?? '',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                  ),
                ),
              ],
            );
          },
          loading: () => const RotatingLoader(size: 15),
          error: (_, __) => const Text('Error'),
        ),
        centerTitle: true,
        actions: [
          CourseOptionsMenu(
            onRegisterStudent: () {
              context.push('/register_enrollment/${widget.courseId}');
            },
            onRegisterHomework: () {},
            onDelete: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: studentCountAsync.when(
                    data: (count) => CourseStatsCard(
                      title: 'Total Alumnos',
                      value: count.toString(),
                      valueColor: colorScheme.primary,
                    ),
                    loading: () => const RotatingLoader(size: 15),
                    error: (_, __) => CourseStatsCard(
                      title: 'Total Alumnos',
                      value: '-',
                      valueColor: colorScheme.error,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ref
                      .watch(courseAverageProvider(widget.courseId))
                      .when(
                        data: (average) => CourseStatsCard(
                          title: 'Promedio General',
                          value: average.toStringAsFixed(1),
                          valueColor: colorScheme.primary,
                        ),
                        loading: () => const RotatingLoader(size: 15),
                        error: (_, __) => CourseStatsCard(
                          title: 'Promedio General',
                          value: '-',
                          valueColor: colorScheme.error,
                        ),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Schedule Card
            CourseScheduleCard(courseId: widget.courseId),
            const SizedBox(height: 16),

            // Attendance Card
            ref
                .watch(courseDailyAttendanceProvider(widget.courseId))
                .when(
                  data: (percentage) =>
                      AttendanceSummaryCard(percentage: percentage),
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: RotatingLoader(size: 20),
                  ),
                  error: (_, __) => const AttendanceSummaryCard(percentage: 0),
                ),
            const SizedBox(height: 24),

            // Search Bar
            TextField(
              controller: _searchController,
              style: TextStyle(color: colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: 'Buscar alumno...',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 16),

            // Student List
            ref
                .watch(enrolledStudentsProvider(widget.courseId))
                .when(
                  data: (enrolledStudents) {
                    if (enrolledStudents.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            'No hay alumnos inscritos',
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: enrolledStudents.length,
                      itemBuilder: (context, index) {
                        final enrolled = enrolledStudents[index];
                        // Default to 'presente' if null, or maybe 'presente' is just a visual default
                        // Per user current logic: status ?? AttendanceStatus.presente
                        final status =
                            enrolled.status ?? AttendanceStatus.presente;

                        return StudentListItem(
                          student: enrolled.student,
                          status: status,
                          onTap: () {
                            // Navigate to student details
                          },
                        );
                      },
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: RotatingLoader(size: 30)),
                  ),
                  error: (error, _) => Center(
                    child: Text(
                      'Error: $error',
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ),
                ),
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 160,
        child: FloatingActionButton.extended(
          onPressed: () {
            // Navigate to attendance taking
          },
          icon: const Icon(Icons.checklist),
          label: const Text(
            'Pasar Lista',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
