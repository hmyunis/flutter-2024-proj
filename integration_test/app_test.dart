import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart' as app;



void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Signup Page Integration Tests", () {
    testWidgets("Successful Signup", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("signup button")));
      await tester.pumpAndSettle();

      final user_name_field = find.byKey(const Key("username_field"));
      final email_field = find.byKey(const Key("email_field"));
      final password_field = find.byKey(const Key("password_field"));
      final confirm_password_field = find.byKey(const Key("confirm_password_field"));

      await tester.enterText(user_name_field, "testuser");
      await tester.enterText(email_field, 'testuser@example.com');
      await tester.enterText(password_field, 'TestPassword123');
      await tester.enterText(confirm_password_field, 'TestPassword123');
    
      final signup_button = find.byKey(const Key("create_account_field"));

      await tester.tap(signup_button);
      await tester.pumpAndSettle();

      expect(find.text("Browse"), findsOneWidget);
    });

    testWidgets("Invalid Email", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("signup button")));
      await tester.pumpAndSettle();

      final user_name_field = find.byKey(const Key("username_field"));
      final email_field = find.byKey(const Key("email_field"));
      final password_field = find.byKey(const Key("password_field"));
      final confirm_password_field = find.byKey(const Key("confirm_password_field"));

      await tester.enterText(user_name_field, "testuser");
      await tester.enterText(email_field, 'testInvalidEmail');
      await tester.enterText(password_field, 'TestPassword123');
      await tester.enterText(confirm_password_field, 'TestPassword123');
    
      final signup_button = find.byKey(const Key("create_account_field"));

      await tester.tap(signup_button);
      await tester.pumpAndSettle();

      expect(find.text("Email address is not in the correct format."), findsOneWidget);
    });

    testWidgets("Password lessthan 8 characters ", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("signup button")));
      await tester.pumpAndSettle();

      final user_name_field = find.byKey(const Key("username_field"));
      final email_field = find.byKey(const Key("email_field"));
      final password_field = find.byKey(const Key("password_field"));
      final confirm_password_field = find.byKey(const Key("confirm_password_field"));

      await tester.enterText(user_name_field, "testuser");
      await tester.enterText(email_field, 'testuser@gmail.com');
      await tester.enterText(password_field, 'Test');
      await tester.enterText(confirm_password_field, 'TestPassword123');
    
      final signup_button = find.byKey(const Key("create_account_field"));

      await tester.tap(signup_button);
      await tester.pumpAndSettle();

      expect(find.text("Password must be at least 8 characters."), findsOneWidget);
    });


   });
}