import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:students_control/features/dashboard/domain/models/dashboard_models.dart';
import 'package:students_control/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:students_control/features/dashboard/presentation/widgets/action_card.dart';

class ActionSection extends ConsumerWidget {
  const ActionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data
    const items = [
      ActionItem(title: 'Mis Materias', subtitle: 'Ver y gestionar tus cursos'),
      ActionItem(
        title: 'Registrar Alumnos',
        subtitle: 'Añadir nuevos estudiantes',
      ),
    ];

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            child: ActionCard(
              item: items[0],
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              textColor: Theme.of(context).colorScheme.onTertiary,
              // Placeholder for image/icon
              child: SvgPicture.asset(
                'assets/images/svg/courses.svg',
                height: 150,
              ),
            ),
            onTap: () => ref.read(dashboardIndexProvider.notifier).state = 1,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            child: ActionCard(
              item: items[1],
              backgroundColor: Theme.of(context).colorScheme.surface,
              textColor: Theme.of(context).colorScheme.onSurface,
              // Placeholder for image/icon
              child: SvgPicture.asset(
                'assets/images/svg/students.svg',
                height: 100,
              ),
            ),
            onTap: () => ref.read(dashboardIndexProvider.notifier).state = 2,
          ),
        ),
      ],
    );
  }
}
