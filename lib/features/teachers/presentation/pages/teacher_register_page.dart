import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:students_control/core/presentation/widgets/custom_snackbar.dart';
import 'package:students_control/core/presentation/widgets/custom_text_field.dart';
import 'package:students_control/core/presentation/widgets/form_label.dart';
import 'package:students_control/features/teachers/domain/entities/teacher.dart';
import 'package:students_control/features/teachers/presentation/providers/teacher_providers.dart';

class TeacherRegisterPage extends ConsumerStatefulWidget {
  const TeacherRegisterPage({super.key});

  @override
  ConsumerState<TeacherRegisterPage> createState() =>
      _TeacherRegisterPageState();
}

class _TeacherRegisterPageState extends ConsumerState<TeacherRegisterPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _teacherIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _teacherIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon
                Center(
                  child: Icon(
                    Icons.school_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Registro Docente',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'Crea tu cuenta para empezar a gestionar tus clases.',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 32),

                // Name Input
                const FormLabel(label: 'Nombre completo'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Nombre y Apellido',
                  validator: (value) {
                    if (value!.isEmpty || value == '') {
                      return 'El nombre es requerido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email Input
                const FormLabel(label: 'Correo electrónico'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'ejemplo@institucion.edu',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || value == '') {
                      return 'El correo es requerido.';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'El correo es invalido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Teacher ID Input
                const FormLabel(label: 'Identificador de Docente (Opcional)'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _teacherIdController,
                  hintText: 'ID de Docente',
                ),
                const SizedBox(height: 16),

                // Password Input
                const FormLabel(label: 'Contraseña'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Mínimo 8 caracteres',
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == '') {
                      return 'La contraseña es requerida.';
                    }
                    if (value.length < 8) {
                      return 'La contraseña debe tener al menos 8 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password Input
                const FormLabel(label: 'Confirmar contraseña'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirma tu contraseña',
                  obscureText: !_isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == '') {
                      return 'La confirmación de la contraseña es requerida.';
                    }
                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Register Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final passwordHasher = ref.read(passwordHasherProvider);
                      final teacherRepository = ref.read(
                        teacherRepositoryProvider,
                      );

                      final hashedPassword = passwordHasher.hashPassword(
                        _passwordController.text,
                      );

                      final teacherData = Teacher(
                        fullName: _nameController.text,
                        email: _emailController.text,
                        passwordHash: hashedPassword,
                        teacherIdentifier: _teacherIdController.text != ''
                            ? _teacherIdController.text
                            : null,
                      );

                      final result = await teacherRepository.registerTeacher(
                        teacherData,
                      );

                      if (context.mounted) {
                        if (result.isSuccess) {
                          _showMessage(result.message ?? 'Error desconocido');
                          context.go('/');
                        } else {
                          _showMessage(result.message ?? 'Error desconocido');
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes una cuenta? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to login
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      child: Text(
                        'Inicia Sesión',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
