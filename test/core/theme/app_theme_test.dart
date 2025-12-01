import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:students_control/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('lightTheme should have correct properties', () {
      final theme = AppTheme.lightTheme;

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, Colors.blue);
      expect(theme.colorScheme.secondary, Colors.blueAccent);
      expect(theme.colorScheme.surface, Colors.white);
      expect(theme.scaffoldBackgroundColor, Colors.white);

      // AppBar Theme
      expect(theme.appBarTheme.backgroundColor, Colors.blue);
      expect(theme.appBarTheme.iconTheme?.color, Colors.white);
      expect(theme.appBarTheme.titleTextStyle?.color, Colors.white);
      expect(theme.appBarTheme.titleTextStyle?.fontSize, 20);
      expect(theme.appBarTheme.titleTextStyle?.fontWeight, FontWeight.bold);

      // Text Theme
      expect(theme.textTheme.bodyLarge?.color, Colors.black);
      expect(theme.textTheme.bodyMedium?.color, Colors.black);
    });

    test('darkTheme should have correct properties', () {
      final theme = AppTheme.darkTheme;

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.primary, Colors.blueGrey);
      expect(theme.colorScheme.secondary, Colors.black);
      expect(theme.colorScheme.surface, const Color(0xFF121212));
      expect(theme.scaffoldBackgroundColor, const Color(0xFF121212));

      // AppBar Theme
      expect(theme.appBarTheme.backgroundColor, Colors.blueGrey);
      expect(theme.appBarTheme.iconTheme?.color, Colors.white);
      expect(theme.appBarTheme.titleTextStyle?.color, Colors.white);
      expect(theme.appBarTheme.titleTextStyle?.fontSize, 20);
      expect(theme.appBarTheme.titleTextStyle?.fontWeight, FontWeight.bold);

      // Text Theme
      expect(theme.textTheme.bodyLarge?.color, Colors.white);
      expect(theme.textTheme.bodyMedium?.color, Colors.white);
    });
  });
}
