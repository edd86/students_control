import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:students_control/core/presentation/widgets/rotating_loader.dart';
import 'package:students_control/features/enrollments/presentation/providers/enrollments_providers.dart';

class RegisterEnrollmentPage extends ConsumerStatefulWidget {
  final int courseId;

  const RegisterEnrollmentPage({super.key, required this.courseId});

  @override
  ConsumerState<RegisterEnrollmentPage> createState() =>
      _RegisterEnrollmentPageState();
}

class _RegisterEnrollmentPageState
    extends ConsumerState<RegisterEnrollmentPage> {
  final TextEditingController _searchController = TextEditingController();
  final Set<int> _selectedStudentIds = {};
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final availableStudentsAsync = ref.watch(
      availableStudentsProvider(widget.courseId),
    );

    // Listen for enrollment actions
    ref.listen(enrollmentControllerProvider, (previous, next) {
      if (next.isLoading == false && !next.hasError && next.hasValue) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Alumnos matriculados correctamente')),
          );
          context.pop();
        }
      }
      if (next.hasError) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${next.error}'),
              backgroundColor: colorScheme.error,
            ),
          );
        }
      }
    });

    final enrollmentState = ref.watch(enrollmentControllerProvider);
    final isLoadingEnrollment = enrollmentState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Matricular Alumnos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar alumno por nombre o CI',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),

          // Header "ALUMNOS DISPONIBLES"
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ALUMNOS DISPONIBLES',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),

          // List
          Expanded(
            child: availableStudentsAsync.when(
              data: (students) {
                if (students.isEmpty) {
                  return Center(
                    child: Text(
                      'No hay alumnos disponibles',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  );
                }

                final filteredStudents = students.where((student) {
                  final fullName = '${student.firstName} ${student.lastName}'
                      .toLowerCase();
                  final dni = student.identificationNumber?.toLowerCase() ?? '';
                  return fullName.contains(_searchQuery) ||
                      dni.contains(_searchQuery);
                }).toList();

                if (filteredStudents.isEmpty) {
                  return Center(
                    child: Text(
                      'No se encontraron resultados',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredStudents.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final student = filteredStudents[index];
                    final isSelected = _selectedStudentIds.contains(student.id);

                    return Card(
                      elevation: 0,
                      color: Colors.transparent, // Or surface
                      margin: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedStudentIds.remove(student.id);
                            } else {
                              _selectedStudentIds.add(student.id!);
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: student.profilePhoto != null
                                    ? NetworkImage(student.profilePhoto!)
                                    : null,
                                child: student.profilePhoto == null
                                    ? Text(
                                        student.firstName[0].toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.primary,
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${student.firstName} ${student.lastName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (student.identificationNumber != null)
                                      Text(
                                        student.identificationNumber!,
                                        style: TextStyle(
                                          color: colorScheme.onSurfaceVariant,
                                          fontSize: 14,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Checkbox(
                                value: isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      _selectedStudentIds.add(student.id!);
                                    } else {
                                      _selectedStudentIds.remove(student.id);
                                    }
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: RotatingLoader(size: 40)),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed:
                        _selectedStudentIds.isEmpty || isLoadingEnrollment
                        ? null
                        : () {
                            ref
                                .read(enrollmentControllerProvider.notifier)
                                .enrollStudents(
                                  widget.courseId,
                                  _selectedStudentIds.toList(),
                                );
                          },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoadingEnrollment
                        ? const RotatingLoader(size: 20, color: Colors.white)
                        : Text(
                            'Matricular Seleccionados (${_selectedStudentIds.length})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: () => context.pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: colorScheme.primary.withValues(
                        alpha: 0.1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
