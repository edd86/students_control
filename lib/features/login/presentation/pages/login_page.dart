import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:students_control/core/presentation/widgets/custom_snackbar.dart';
import 'package:students_control/core/presentation/widgets/custom_text_field.dart';
import 'package:students_control/core/theme/theme_provider.dart';

import 'package:students_control/features/login/domain/services/validate_textfield.dart';
import 'package:students_control/features/login/presentation/providers/login_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    final isPasswordVisible = ref.watch(loginPasswordVisibilityProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              ref
                  .read(themeProvider.notifier)
                  .setTheme(isDarkMode ? ThemeMode.light : ThemeMode.dark);
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                'Bienvenido de nuevo',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              // Email Input
              Text(
                'Correo o Usuario',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              CustomTextField(
                controller: emailController,
                hintText: 'Ingresa tu correo o id',
              ),
              const SizedBox(height: 24),

              // Password Input
              Text(
                'Contraseña',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              CustomTextField(
                controller: passwordController,
                hintText: 'Ingresa tu contraseña',
                obscureText: !isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    ref.read(loginPasswordVisibilityProvider.notifier).toggle();
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Login Button
              Consumer(
                builder: (context, ref, child) {
                  final loginState = ref.watch(loginControllerProvider);
                  final isLoading = loginState.isLoading;

                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (ValidateTextfield(
                                  content: emailController.text,
                                ).validate() &&
                                ValidateTextfield(
                                  content: passwordController.text,
                                ).validate()) {
                              final success = await ref
                                  .read(loginControllerProvider.notifier)
                                  .login(
                                    emailController.text,
                                    passwordController.text,
                                    emailController.text,
                                  );

                              if (context.mounted) {
                                if (success) {
                                  _showMessage(context, 'Login exitoso');
                                  context.go('/dashboard');
                                } else {
                                  final error = ref.read(
                                    loginControllerProvider,
                                  );
                                  _showMessage(context, error.error.toString());
                                }
                              }
                            } else {
                              _showMessage(
                                context,
                                'Por favor ingrese credenciales válidas',
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Forgot Password
              TextButton(
                onPressed: () {},
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes cuenta? ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push('/register');
                    },
                    child: Text(
                      'Regístrate',
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
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(CustomSnackbar(message: message));
  }
}
