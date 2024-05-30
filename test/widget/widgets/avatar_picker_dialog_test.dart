import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/presentation/widgets/avatar_picker_dialog.dart'; 
void main() {
  group('AvatarPickerDialog', () {
    testWidgets('displays a dialog with a grid of avatars',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AvatarPickerDialog(),
          ),
        ),
      );

      // Verify the dialog title
      expect(find.text('Select an Avatar'), findsOneWidget);

      // Verify the grid view is present
      expect(find.byType(GridView), findsOneWidget);

      // Verify the cancel button is present
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('selects an avatar and closes the dialog',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AvatarPickerDialog(),
          ),
        ),
      );

      // Tap on the first avatar in the grid
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle(); // Wait for the dialog to close

      // Verify that the dialog is closed
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('closes the dialog when cancel button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AvatarPickerDialog(),
          ),
        ),
      );

      // Tap on the cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Verify that the dialog is closed
      expect(find.byType(AlertDialog), findsNothing);
    });
    
  });
}