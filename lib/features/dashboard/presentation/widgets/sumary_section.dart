import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/dashboard/domain/models/dashboard_models.dart';
import 'package:students_control/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:students_control/features/dashboard/presentation/widgets/sumary_card.dart';

class SumarySection extends ConsumerWidget {
  const SumarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalStudents = ref.watch(totalStudentsProvider);
    final totalCourses = ref.watch(totalCoursesProvider);
    // Mock data using models
    final items = [
      SummaryItem(title: 'Alumnos Totales', value: '${totalStudents.value}'),
      SummaryItem(title: 'Materias Activas', value: '${totalCourses.value}'),
    ];

    return Row(
      children: [
        Expanded(
          child: SumaryCard(
            item: items[0],
            valueColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SumaryCard(
            item: items[1],
            valueColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
