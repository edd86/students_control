import 'package:flutter/material.dart';

class CourseStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const CourseStatsCard({
    super.key,
    required this.title,
    required this.value,
    this.valueColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
