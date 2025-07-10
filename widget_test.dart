// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:registro/main.dart';

void main() {
  testWidgets('Registro app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RegistroApp());

    // Verify that the app title is displayed
    expect(find.text('SISTEMA DE REGISTRO'), findsOneWidget);
    
    // Verify that the company name is displayed
    expect(find.text('CONSTRUCCIONES INDUSTRIALES'), findsOneWidget);
    
    // Verify that the system description is displayed
    expect(find.text('Sistema de Control de Personal'), findsOneWidget);
    
    // Verify that all user buttons are present
    expect(find.text('DIONI'), findsOneWidget);
    expect(find.text('GERMAN'), findsOneWidget);
    expect(find.text('LUTE'), findsOneWidget);
    expect(find.text('VICTOR'), findsOneWidget);
    expect(find.text('ADMIN'), findsOneWidget);
    
    // Verify that role descriptions are displayed
    expect(find.text('Supervisor de Obra'), findsOneWidget);
    expect(find.text('Jefe de Equipo'), findsOneWidget);
    expect(find.text('Técnico Especialista'), findsOneWidget);
    expect(find.text('Operador de Maquinaria'), findsOneWidget);
    expect(find.text('Administrador del Sistema'), findsOneWidget);
  });

  testWidgets('User button tap test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RegistroApp());

    // Find and tap on the DIONI button
    final dioniButton = find.ancestor(
      of: find.text('DIONI'),
      matching: find.byType(ElevatedButton),
    );
    
    expect(dioniButton, findsOneWidget);
    await tester.ensureVisible(dioniButton);
    await tester.tap(dioniButton);
    await tester.pump();

    // Wait for the snackbar to appear
    await tester.pump(const Duration(milliseconds: 100));
    
    // Verify that the snackbar appears with the correct message
    expect(find.text('Acceso autorizado: DIONI'), findsOneWidget);
    // Esperar a que desaparezca el SnackBar
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });

  testWidgets('Admin button tap test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RegistroApp());

    // Find and tap on the ADMIN button
    final adminButton = find.ancestor(
      of: find.text('ADMIN'),
      matching: find.byType(ElevatedButton),
    );
    
    expect(adminButton, findsOneWidget);
    await tester.ensureVisible(adminButton);
    await tester.tap(adminButton);
    await tester.pump();

    // Wait for the snackbar to appear
    await tester.pump(const Duration(milliseconds: 100));
    
    // Verify that the snackbar appears with the correct message
    expect(find.text('Acceso autorizado: ADMIN'), findsOneWidget);
    // Esperar a que desaparezca el SnackBar
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });

  testWidgets('All buttons are tappable', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RegistroApp());

    // Test all user buttons
    final users = ['DIONI', 'GERMAN', 'LUTE', 'VICTOR', 'ADMIN'];
    
    for (final user in users) {
      final button = find.ancestor(
        of: find.text(user),
        matching: find.byType(ElevatedButton),
      );
      
      expect(button, findsOneWidget, reason: 'Button for $user not found');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      
      expect(find.text('Acceso autorizado: $user'), findsOneWidget);
      // Esperar a que desaparezca el SnackBar antes de continuar
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }
  });
}
