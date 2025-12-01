import 'package:flutter/material.dart';
import 'package:students_control/features/dashboard/domain/models/dashboard_models.dart';
import 'package:students_control/features/dashboard/presentation/widgets/class_card.dart';

class UpcomingClassesSection extends StatelessWidget {
  const UpcomingClassesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    const classes = [
      ClassItem(title: 'Cálculo I', time: '10:00 AM', location: 'Salón 302'),
      ClassItem(
        title: 'Física II',
        time: '12:00 PM',
        location: 'Laboratorio B',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Próximas Clases',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 16),
        ClassCard(
          icon: Icons.calculate_outlined,
          iconColor: Theme.of(context).colorScheme.primaryContainer,
          iconTintColor: Theme.of(context).colorScheme.onPrimaryContainer,
          item: classes[0],
        ),
        const SizedBox(height: 12),
        ClassCard(
          icon: Icons.science_outlined,
          iconColor: Theme.of(context).colorScheme.primaryContainer,
          iconTintColor: Theme.of(context).colorScheme.onPrimaryContainer,
          item: classes[1],
        ),
      ],
    );
  }
}
