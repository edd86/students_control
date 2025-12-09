import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:students_control/features/dashboard/presentation/providers/dashboard_providers.dart';

class StudentsCustomHeader extends ConsumerWidget {
  const StudentsCustomHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: colorScheme.onSurface,
            ),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                ref.read(dashboardIndexProvider.notifier).state = 0;
              }
            },
          ),
          Text(
            'Listado de Alumnos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: colorScheme.primary, size: 28),
            onPressed: () {
              context.push('/register_student');
            },
          ),
        ],
      ),
    );
  }
}
