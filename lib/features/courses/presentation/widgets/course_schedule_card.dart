import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/core/utils/dates_functions.dart';
import 'package:students_control/features/courses/presentation/providers/courses_providers.dart';

class CourseScheduleCard extends ConsumerWidget {
  final int courseId;

  const CourseScheduleCard({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(courseSchedulesProvider(courseId));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horario',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          schedulesAsync.when(
            data: (schedules) {
              if (schedules.isEmpty) {
                return Text(
                  'No hay horarios asignados',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                );
              }
              return Column(
                children: schedules.map((schedule) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.access_time,
                                size: 16,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              DateFunctions.literalWeekDay(schedule.dayOfWeek),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${schedule.startTime.format(context)} - ${schedule.endTime.format(context)}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (error, stack) => const Text(
              'Error al cargar horarios',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
