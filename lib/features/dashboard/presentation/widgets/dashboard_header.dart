import 'package:flutter/material.dart';
import 'package:students_control/core/utils/dates_functions.dart';
import 'package:students_control/features/teachers/domain/entities/teacher.dart';

class DashboardHeader extends StatelessWidget {
  final Teacher teacher;
  const DashboardHeader({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.onTertiary,
            size: 30,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${DateFunctions.periodOfDay(now)}, ${teacher.fullName.split(' ')[0]}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFunctions.literalDate(now),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }
}
