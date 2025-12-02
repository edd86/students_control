import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/courses/presentation/pages/courses_page.dart';
import 'package:students_control/features/dashboard/presentation/pages/home_page.dart';
import 'package:students_control/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:students_control/features/students/presentation/pages/students_page.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(dashboardIndexProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(
        index: selectedIndex,
        children: [
          HomePage(),
          CoursesPage(),
          StudentsPage(),
          Center(child: Text('Perfil')), // Placeholder
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(dashboardIndexProvider.notifier).state = index;
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Materias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Alumnos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
