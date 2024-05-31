import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/logic/blocs/auth/auth_bloc.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  late AuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthInitial());
  });

  group('LoginPage Widget Tests', () {
    testWidgets(
        'renders LoginPage with initial state', (WidgetTester tester) async {});
  });
}
