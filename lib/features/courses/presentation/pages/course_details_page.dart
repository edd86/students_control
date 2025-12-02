import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:students_control/features/courses/presentation/providers/courses_providers.dart';
import 'package:students_control/features/courses/presentation/widgets/attendance_summary_card.dart';
import 'package:students_control/features/courses/presentation/widgets/course_stats_card.dart';
import 'package:students_control/features/courses/presentation/widgets/student_list_item.dart';
import 'package:students_control/features/students/domain/entity/student.dart';

class CourseDetailsPage extends ConsumerStatefulWidget {
  final String courseId;

  const CourseDetailsPage({super.key, required this.courseId});

  @override
  ConsumerState<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends ConsumerState<CourseDetailsPage> {
  final TextEditingController _searchController = TextEditingController();

  // Mock data for students
  final List<Student> _allStudents = [
    Student(
      id: 1,
      firstName: 'Alejandra',
      lastName: 'Vargas',
      profilePhoto: 'https://i.pravatar.cc/150?u=1',
    ),
    Student(
      id: 2,
      firstName: 'Benjamín',
      lastName: 'Ríos',
      profilePhoto: 'https://i.pravatar.cc/150?u=2',
    ),
    Student(
      id: 3,
      firstName: 'Carla',
      lastName: 'Mendoza',
      profilePhoto: 'https://i.pravatar.cc/150?u=3',
    ),
    Student(
      id: 4,
      firstName: 'Daniel',
      lastName: 'Soto',
      profilePhoto: 'https://i.pravatar.cc/150?u=4',
    ),
    Student(
      id: 5,
      firstName: 'Elena',
      lastName: 'Flores',
      profilePhoto: 'https://i.pravatar.cc/150?u=5',
    ),
  ];

  // Mock status for students
  final Map<int, StudentStatus> _studentStatuses = {
    1: StudentStatus.presente,
    2: StudentStatus.ausente,
    3: StudentStatus.presente,
    4: StudentStatus.tardanza,
    5: StudentStatus.licencia,
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: coursesAsync.when(
          data: (courses) {
            final course = courses.firstWhere(
              (c) => c.id.toString() == widget.courseId,
              orElse: () => courses.first, // Fallback for safety
            );
            return Text(
              course.name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          },
          loading: () => const Text(''),
          error: (_, __) => const Text('Error'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
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
                  child: CourseStatsCard(
                    title: 'Total Alumnos',
                    value: _allStudents.length.toString(),
                    valueColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CourseStatsCard(
                    title: 'Promedio General',
                    value: '8.5',
                    valueColor: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Attendance Card
            const AttendanceSummaryCard(percentage: 92),
            const SizedBox(height: 24),

            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar alumno...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 16),

            // Student List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _allStudents.length,
              itemBuilder: (context, index) {
                final student = _allStudents[index];
                final status =
                    _studentStatuses[student.id] ?? StudentStatus.presente;
                return StudentListItem(
                  student: student,
                  status: status,
                  onTap: () {
                    // Navigate to student details
                  },
                );
              },
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
