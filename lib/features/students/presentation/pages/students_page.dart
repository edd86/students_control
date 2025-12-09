import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/core/presentation/widgets/rotating_loader.dart';
import 'package:students_control/features/students/domain/entity/student.dart';
import 'package:students_control/features/students/presentation/providers/students_provider.dart';
import 'package:students_control/features/students/presentation/widgets/students_custom_header.dart';

class StudentsPage extends ConsumerStatefulWidget {
  const StudentsPage({super.key});

  @override
  ConsumerState<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends ConsumerState<StudentsPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(studentsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            const StudentsCustomHeader(),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: 'Buscar por nombre o ID',
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
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    ref.read(studentSearchQueryProvider.notifier).state = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),

            // Student List
            Expanded(
              child: studentsAsync.when(
                data: (students) {
                  if (students.isEmpty) {
                    return Center(
                      child: Text(
                        'No hay alumnos registrados',
                        style: TextStyle(color: colorScheme.onSurface),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: students.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return _StudentListTile(student: student);
                    },
                  );
                },
                loading: () => const Center(child: RotatingLoader(size: 30)),
                error: (error, stack) => Center(
                  child: Text(
                    'Error: $error',
                    style: TextStyle(color: colorScheme.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentListTile extends StatelessWidget {
  final Student student;

  const _StudentListTile({required this.student});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Determine subtitle: ID or Notes (Subjects)
    String subtitle = '';
    if (student.identificationNumber != null) {
      subtitle = 'ID: ${student.identificationNumber}';
    } else if (student.notes != null) {
      subtitle = student.notes!;
    }

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: colorScheme.primaryContainer,
          backgroundImage: student.profilePhoto != null
              ? NetworkImage(student.profilePhoto!)
              : null,
          child: student.profilePhoto == null
              ? Text(
                  student.firstName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                )
              : null,
        ),
        title: Text(
          '${student.firstName} ${student.lastName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        onTap: () {
          // Navigate to student details
        },
      ),
    );
  }
}
