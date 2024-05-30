
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
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

      await tester.enterText(user_name_field, "ptaiqaalaaa3");
      await tester.enterText(email_field, 'testuser@pargiqlil.com');
      await tester.enterText(password_field, 'TestPassword123');
      await tester.enterText(confirm_password_field, 'TestPassword123');
    
      final signup_button = find.byKey(const Key("create_account_field"));

      await tester.tap(signup_button);
      await tester.pumpAndSettle();

      expect(find.text("Browse"), findsOneWidget);

      final log_out_button = find.byKey(const Key("logout"));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(log_out_button);
      await tester.pumpAndSettle();

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

      await tester.enterText(user_name_field, "testuear");
      await tester.enterText(email_field, 'testInvalidEmail');
      await tester.enterText(password_field, 'TestPassword123');
      await tester.enterText(confirm_password_field, 'TestPassword123');
    
      final signup_button = find.byKey(const Key("create_account_field"));

      await tester.tap(signup_button);
      await tester.pumpAndSettle();

      expect(find.text("Email address is not in the correct format."), findsOneWidget);

      final login_button = find.byKey(const Key("login_field"));

      await tester.pumpAndSettle();
      await tester.tap(login_button);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));

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

      await tester.enterText(user_name_field, "testuear");
      await tester.enterText(email_field, 'testemail@gmail.com');
      await tester.enterText(password_field, 'short');
      await tester.enterText(confirm_password_field, 'short');
    
      final signup_button = find.byKey(const Key("create_account_field"));

      await tester.tap(signup_button);
      await tester.pumpAndSettle();

      expect(find.text("Password must be at least 8 characters."), findsOneWidget);

      final login_button = find.byKey(const Key("login_field"));

      await tester.pumpAndSettle();
      await tester.tap(login_button);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));
    });


   });

   group("Login page Integration Tests", () { 
      testWidgets("Successful Login", (tester) async {
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        await tester.enterText(user_name_field, "username");
        await tester.enterText(password_field, "password");

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        expect(find.text("Browse"), findsOneWidget);

        final log_out_button = find.byKey(const Key("logout"));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(log_out_button);
      await tester.pumpAndSettle();
      });
      testWidgets("Invalid Login credentials", (tester) async {
        app.main();

        await tester.pumpAndSettle();

        final user_name_field = find.byKey(const Key("login_username"));
        final password_field = find.byKey(const Key("login_password"));

        await tester.enterText(user_name_field, "username");
        await tester.enterText(password_field, "password123");

        final Login_button = find.byKey(const Key("Login_button"));

        await tester.tap(Login_button);
        await tester.pumpAndSettle();

        expect(find.text("Exception: Invalid credentials: Login failed"), findsOneWidget);

        final log_out_button = find.byKey(const Key("logout"));
      await tester.pumpAndSettle();
      });
   });
}