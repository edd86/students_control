import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/courses/presentation/providers/courses_providers.dart';

class CoursePageHeader extends ConsumerWidget {
  const CoursePageHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedSearchBar(
      label: 'Mis Materias',
      labelAlignment: Alignment.center,
      labelStyle:
          textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ) ??
          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      closeIcon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
      searchIcon: Icon(Icons.search, color: colorScheme.onSurface),
      onChanged: (value) {
        ref.read(courseSearchQueryProvider.notifier).update(value);
      },
      onFieldSubmitted: (value) {
        ref.read(courseSearchQueryProvider.notifier).update(value);
      },
      searchDecoration: InputDecoration(
        labelText: 'Buscar materias',
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
      ),
    );
  }
}
