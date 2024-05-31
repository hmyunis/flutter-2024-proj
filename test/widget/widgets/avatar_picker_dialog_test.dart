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

      expect(find.text('Select an Avatar'), findsOneWidget);

      expect(find.byType(GridView), findsOneWidget);

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

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });

  });
}
