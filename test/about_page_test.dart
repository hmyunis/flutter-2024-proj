import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/presentation/screens/about_page.dart';

void main() {
  testWidgets('AboutPage should have an AppBar and a Container', (WidgetTester tester) async {
    // Build the AboutPage widget
    await tester.pumpWidget(MaterialApp(home: const AboutPage()));

    // Verify the AppBar
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('About'), findsOneWidget);

    // Verify the Container
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}