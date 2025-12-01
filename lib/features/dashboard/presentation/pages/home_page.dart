import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/dashboard/presentation/widgets/action_section.dart';
import 'package:students_control/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:students_control/features/dashboard/presentation/widgets/report_section.dart';
import 'package:students_control/features/dashboard/presentation/widgets/sumary_section.dart';
import 'package:students_control/features/dashboard/presentation/widgets/upcoming_classes_section.dart';
import 'package:students_control/features/login/presentation/providers/login_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacher = ref.watch(currentUserProvider);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(teacher: teacher!),
            const SizedBox(height: 24),
            const SumarySection(),
            const SizedBox(height: 24),
            const ActionSection(),
            const SizedBox(height: 24),
            const ReportSection(),
            const SizedBox(height: 24),
            const UpcomingClassesSection(),
          ],
        ),
      ),
    );
  }
}
