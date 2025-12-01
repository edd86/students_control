import 'package:flutter/material.dart';
import 'package:students_control/features/dashboard/domain/models/dashboard_models.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.item,
    required this.backgroundColor,
    required this.textColor,
    required this.child,
  });
  final ActionItem item;
  final Color backgroundColor;
  final Color textColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: child), // Content area (image/icon)
          Text(
            item.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.subtitle,
            style: TextStyle(
              fontSize: 12,
              color: textColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
