import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:video_game_catalogue_app/logic/blocs/collection/collection_bloc.dart';
import 'package:video_game_catalogue_app/logic/blocs/games/games_bloc.dart';
import 'package:video_game_catalogue_app/logic/blocs/userSession/user_session_bloc.dart';
import 'package:video_game_catalogue_app/models/user.dart';
import 'package:video_game_catalogue_app/presentation/screens/browse_page.dart';

class MockUserSessionBloc
    extends MockBloc<UserSessionEvent, User> // Correct state type
    implements
        UserSessionBloc {}

class MockGamesBloc extends MockBloc<GamesEvent, GamesState>
    implements GamesBloc {}

class MockCollectionBloc extends MockBloc<CollectionEvent, CollectionState>
    implements CollectionBloc {}

void main() {
  late UserSessionBloc mockUserSessionBloc;
  late GamesBloc mockGamesBloc;
  late CollectionBloc mockCollectionBloc;

  setUp(() {
    mockUserSessionBloc = MockUserSessionBloc();
    mockGamesBloc = MockGamesBloc();
    mockCollectionBloc = MockCollectionBloc();
  });

  Widget createBrowsePage() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserSessionBloc>.value(value: mockUserSessionBloc),
        BlocProvider<GamesBloc>.value(value: mockGamesBloc),
        BlocProvider<CollectionBloc>.value(value: mockCollectionBloc),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: BrowsePage(),
        ),
      ),
    );
  }

  testWidgets('BrowsePage displays circular indicator when games are loading',
      (tester) async {
    when(() => mockUserSessionBloc.state).thenReturn(User(
        id: 1,
        username: 'testuser',
        email: 'test@example.com',
        joinDate: DateTime.now().toString(),
        role: 'user',
        token: 'testtoken'));
    when(() => mockGamesBloc.state).thenReturn(GamesLoading());
    await tester.pumpWidget(createBrowsePage());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
