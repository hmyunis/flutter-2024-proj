import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/logic/blocs/auth/auth_bloc.dart'; // Replace with your actual import path
import 'package:video_game_catalogue_app/presentation/screens/login_page.dart'; // Replace with your actual import path

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  late AuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthInitial()); // Set initial state
  });

  group('LoginPage Widget Tests', () {
    testWidgets('renders LoginPage with initial state', (WidgetTester tester) async {
      });
      

  });
  
}