import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:students_control/features/courses/domain/entities/course.dart';
import 'package:students_control/features/courses/domain/entities/schedule.dart';
import 'package:students_control/features/courses/presentation/providers/courses_providers.dart';
import 'package:students_control/features/courses/presentation/widgets/schedule_widget.dart';
import 'package:students_control/features/courses/presentation/widgets/section_title.dart';
import 'package:students_control/features/login/presentation/providers/login_providers.dart';
import '../../../../core/constants/course_colors.dart';
import '../../../../core/constants/course_icons.dart';

class CourseRegisterPage extends ConsumerStatefulWidget {
  const CourseRegisterPage({super.key});

  @override
  ConsumerState<CourseRegisterPage> createState() => _CourseRegisterPageState();
}

class _CourseRegisterPageState extends ConsumerState<CourseRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(courseRegisterProvider);
    final teacher = ref.watch(currentUserProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nueva Materia',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar', style: TextStyle(fontSize: 12.5)),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: 'Nombre de la materia'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Cálculo I',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SectionTitle(title: 'Código (opcional)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  hintText: 'MAT-101',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SectionTitle(title: 'Horario'),
              const SizedBox(height: 8),
              ...state.schedules.map(
                (schedule) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ScheduleWidget(
                    scheduleId: schedule.id,
                    scheduleState: schedule,
                    onRemove: () => ref
                        .read(courseRegisterProvider.notifier)
                        .removeSchedule(schedule.id),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ref.read(courseRegisterProvider.notifier).addSchedule();
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Añadir otro horario'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.grey.shade50,
                    side: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              SectionTitle(title: 'Color'),
              const SizedBox(height: 12),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: CourseColors.values.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final colorEnum = CourseColors.values[index];
                    final isSelected = state.selectedColor == colorEnum;
                    return GestureDetector(
                      onTap: () => ref
                          .read(courseRegisterProvider.notifier)
                          .setColor(colorEnum),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: colorEnum.color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ) // Blue ring for selection
                              : null,
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: Colors.blue.withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                          ],
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              SectionTitle(title: 'Ícono'),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: CourseIcons.values.length,
                itemBuilder: (context, index) {
                  final iconEnum = CourseIcons.values[index];
                  final isSelected = state.selectedIcon == iconEnum;
                  return GestureDetector(
                    onTap: () => ref
                        .read(courseRegisterProvider.notifier)
                        .setIcon(iconEnum),
                    child: Container(
                      height: 25,
                      width: 25,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? state.selectedColor.color.withValues(alpha: 0.25)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(
                                color: state.selectedColor.color,
                                width: 2,
                              )
                            : Border.all(
                                color: Colors.grey.withValues(alpha: 0.2),
                              ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            iconEnum.path,
                            height: 45,
                            colorFilter: isSelected
                                ? ColorFilter.mode(
                                    state.selectedColor.color,
                                    BlendMode.srcIn,
                                  )
                                : null,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            iconEnum.label,
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              SectionTitle(title: 'Notas (opcional)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Detalles del temario, libro de texto...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final state = ref.read(courseRegisterProvider);
                      final int teacherId = teacher.id!;

                      final course = Course(
                        teacherId: teacherId,
                        name: _nameController.text,
                        code: _codeController.text.isNotEmpty
                            ? _codeController.text
                            : null,
                        icon: state.selectedIcon.name,
                        colorHex: state.selectedColor.name,
                        description: _notesController.text.isNotEmpty
                            ? _notesController.text
                            : null,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );

                      // 2. Create Schedule objects
                      final weekDays = ['L', 'M', 'X', 'J', 'V', 'S'];
                      final List<Schedule> schedules = [];

                      for (final scheduleState in state.schedules) {
                        for (final day in scheduleState.selectedDays) {
                          int dayOfWeek = weekDays.indexOf(day) + 1;
                          schedules.add(
                            Schedule(
                              dayOfWeek: dayOfWeek,
                              startTime: scheduleState.startTime,
                              endTime: scheduleState.endTime,
                            ),
                          );
                        }
                      }

                      // 3. Call provider
                      final result = await ref
                          .read(courseControllerProvider)
                          .addCourse(course, schedules);

                      if (!context.mounted) return;

                      if (result.data != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Materia guardada exitosamente'),
                          ),
                        );
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${result.message}')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Guardar Materia'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
