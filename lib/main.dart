import 'data/data_providers/collections_data_provider.dart';
import 'data/repositories/collections_repository.dart';
import 'logic/blocs/collection/collection_bloc.dart';

import 'data/data_providers/games_data_provider.dart';
import 'data/repositories/games_repository.dart';
import 'logic/blocs/games/games_bloc.dart';

import 'logic/blocs/userSession/user_session_bloc.dart';

import 'data/data_providers/auth_data_provider.dart';
import 'data/repositories/auth_repository.dart';

import 'logic/blocs/auth/auth_bloc.dart';
import 'logic/utils/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/available_games.dart';
import 'presentation/screens/login_page.dart';
import 'presentation/screens/registration_page.dart';
import 'presentation/screens/about_page.dart';
import 'presentation/screens/browse_page.dart';
import 'presentation/screens/favorites_page.dart';
import 'presentation/screens/profile_page.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isNightMode = true;

  void _toggleNightMode() {
    setState(() {
      _isNightMode = !_isNightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(AuthDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => GamesRepository(GamesDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => CollectionsRepository(CollectionsDataProvider()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => UserSessionBloc(),
          ),
          BlocProvider(
            create: (context) => GamesBloc(context.read<GamesRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                CollectionBloc(context.read<CollectionsRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
          ).copyWith(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blueGrey[900]!,
                brightness: _isNightMode ? Brightness.light : Brightness.dark),
          ),
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegistrationPage(),
            '/home': (context) => HomeScreen(_isNightMode, _toggleNightMode),
            '/browse': (context) => const BrowsePage(),
            '/favorites': (context) => const FavoritesPage(),
            '/profile': (context) => const ProfilePage(),
            '/allgames': (context) => const AvailableGames(),
            '/about': (context) => const AboutPage(),
          },
          home: HomeScreen(_isNightMode, _toggleNightMode),
        ),
      ),
    );
  }
}
