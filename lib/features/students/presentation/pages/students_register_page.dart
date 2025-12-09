import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:students_control/core/presentation/widgets/custom_snackbar.dart';
import 'package:students_control/core/presentation/widgets/rotating_loader.dart';
import 'package:students_control/features/students/domain/entity/student.dart';
import 'package:students_control/features/students/presentation/providers/students_provider.dart';
import 'package:students_control/core/presentation/widgets/custom_text_field.dart';
import 'package:students_control/core/presentation/widgets/form_label.dart';
import 'package:students_control/core/presentation/widgets/section_title.dart';

class StudentsRegisterPage extends ConsumerStatefulWidget {
  const StudentsRegisterPage({super.key});

  @override
  ConsumerState<StudentsRegisterPage> createState() =>
      _StudentsRegisterPageState();
}

class _StudentsRegisterPageState extends ConsumerState<StudentsRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _gradeController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _idNumberController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _gradeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Registrar Alumno',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Photo Section
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(
                            0xFFD98860,
                          ), // Example color from image
                          child: Icon(
                            Icons.image, // Placeholder for the art in image
                            size: 40,
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: colorScheme.primary, // Blue color
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Añadir foto',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Personal Information
              SectionTitle(title: 'Información Personal'),
              const SizedBox(height: 16),
              FormLabel(label: 'Nombre(s)'),
              CustomTextField(
                controller: _firstNameController,
                hintText: 'Ingrese el nombre del alumno',
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FormLabel(label: 'Apellidos'),
              CustomTextField(
                controller: _lastNameController,
                hintText: 'Ingrese los apellidos del alumno',
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los apellidos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FormLabel(label: 'Número de Identificación (DNI/Cédula)'),
              CustomTextField(
                controller: _idNumberController,
                hintText: 'Ej. 12345678',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),

              // Contact Information
              SectionTitle(title: 'Información de Contacto'),
              const SizedBox(height: 16),
              FormLabel(label: 'Correo Electrónico'),
              CustomTextField(
                controller: _emailController,
                hintText: 'ejemplo@correo.com',
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el correo';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Por favor ingrese un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FormLabel(label: 'Número de Teléfono'),
              CustomTextField(
                controller: _phoneController,
                hintText: '77777777',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de teléfono';
                  }
                  if (value.length != 8) {
                    return 'Por favor ingrese un número de teléfono válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Academic Information
              SectionTitle(title: 'Información Académica'),
              const SizedBox(height: 16),
              FormLabel(label: 'Curso o Grado'),
              CustomTextField(
                controller: _gradeController,
                textCapitalization: TextCapitalization.words,
                hintText: 'Ej. 5to Grado',
              ),
              const SizedBox(height: 16),
              FormLabel(label: 'Observaciones Adicionales'),
              CustomTextField(
                controller: _notesController,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                hintText: 'Añadir notas importantes sobre el alumno...',
                maxLines: 4,
              ),
              const SizedBox(height: 32),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final student = Student(
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),
                        identificationNumber: _idNumberController.text.trim(),
                        email: _emailController.text.trim(),
                        phone: _phoneController.text.trim(),
                        gradeLevel: _gradeController.text.trim(),
                        notes: _notesController.text.trim(),
                        // profilePhoto: TODO: Handle photo upload
                      );

                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: RotatingLoader()),
                      );

                      ref
                          .read(studentsControllerProvider)
                          .createStudent(
                            student: student,
                            onSuccess: () {
                              // Pop loading dialog
                              Navigator.of(context).pop();
                              _showMessage('Estudiante creado correctamente');
                              // Pop page
                              context.pop();
                            },
                            onError: (message) {
                              // Pop loading dialog
                              Navigator.of(context).pop();
                              // Show error message
                              _showMessage(message);
                            },
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Guardar Alumno',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () => context.pop(),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(CustomSnackbar(message: message));
  }
}
