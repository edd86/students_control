import 'package:flutter/material.dart';

enum CourseOption { registerStudent, registerHomework, delete }

class CourseOptionsMenu extends StatelessWidget {
  final VoidCallback onRegisterStudent;
  final VoidCallback onRegisterHomework;
  final VoidCallback onDelete;

  const CourseOptionsMenu({
    super.key,
    required this.onRegisterStudent,
    required this.onRegisterHomework,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<CourseOption>(
      icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (CourseOption result) {
        switch (result) {
          case CourseOption.registerStudent:
            onRegisterStudent();
            break;
          case CourseOption.registerHomework:
            onRegisterHomework();
            break;
          case CourseOption.delete:
            onDelete();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<CourseOption>>[
        PopupMenuItem<CourseOption>(
          value: CourseOption.registerStudent,
          child: Row(
            children: [
              Icon(Icons.person_add_outlined, color: colorScheme.onSurface),
              const SizedBox(width: 12),
              Text(
                'Matricular estudiante',
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
        PopupMenuItem<CourseOption>(
          value: CourseOption.registerHomework,
          child: Row(
            children: [
              Icon(Icons.assignment_add, color: colorScheme.onSurface),
              const SizedBox(width: 12),
              Text(
                'Registrar actividad',
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<CourseOption>(
          value: CourseOption.delete,
          child: Row(
            children: [
              Icon(Icons.delete_outline, color: colorScheme.error),
              const SizedBox(width: 12),
              Text('Eliminar', style: TextStyle(color: colorScheme.error)),
            ],
          ),
        ),
      ],
    );
  }
}
