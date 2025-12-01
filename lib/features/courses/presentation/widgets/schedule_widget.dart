import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:students_control/features/courses/presentation/providers/courses_providers.dart';

class ScheduleWidget extends ConsumerWidget {
  final String scheduleId;
  final ScheduleItemState scheduleState;
  final VoidCallback onRemove;

  const ScheduleWidget({
    super.key,
    required this.scheduleId,
    required this.scheduleState,
    required this.onRemove,
  });

  void _toggleDay(WidgetRef ref, String day) {
    ref.read(courseRegisterProvider.notifier).toggleDay(scheduleId, day);
  }

  Future<void> _selectTime(
    BuildContext context,
    WidgetRef ref,
    bool isStartTime,
  ) async {
    final initialTime = isStartTime
        ? scheduleState.startTime
        : scheduleState.endTime;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      if (isStartTime) {
        ref
            .read(courseRegisterProvider.notifier)
            .setStartTime(scheduleId, picked);
      } else {
        ref
            .read(courseRegisterProvider.notifier)
            .setEndTime(scheduleId, picked);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekDays = ['L', 'M', 'X', 'J', 'V', 'S'];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Días', style: TextStyle(fontWeight: FontWeight.w600)),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                tooltip: 'Eliminar horario',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays
                .map(
                  (day) =>
                      _buildDayToggle(ref, day, scheduleState.selectedDays),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Desde',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    _buildTimePicker(
                      context,
                      ref,
                      true,
                      scheduleState.startTime,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hasta',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    _buildTimePicker(
                      context,
                      ref,
                      false,
                      scheduleState.endTime,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayToggle(WidgetRef ref, String day, List<String> selectedDays) {
    final isSelected = selectedDays.contains(day);
    return GestureDetector(
      onTap: () => _toggleDay(ref, day),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
          ),
        ),
        child: Text(
          day,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.blue : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker(
    BuildContext context,
    WidgetRef ref,
    bool isStartTime,
    TimeOfDay time,
  ) {
    return InkWell(
      onTap: () => _selectTime(context, ref, isStartTime),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(time.format(context), style: const TextStyle(fontSize: 16)),
            const Icon(Icons.access_time, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
