import 'package:go_router/go_router.dart';

import '../../logic/blocs/collection/collection_bloc.dart';
import '../../logic/blocs/games/games_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';

import '../../logic/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
              backgroundColor: Colors.red.withOpacity(0.3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          );
        } else if (state is AuthSuccess) {
          BlocProvider.of<UserSessionBloc>(context)
              .add(UserSessionLogin(state.user));
          context.read<GamesBloc>().add(GamesLoadEvent(state.user.id));

          context
              .read<CollectionBloc>()
              .add(FetchCollection(state.user.token!));
          context.go('/home');

        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Scaffold(
            backgroundColor: Colors.blueGrey[900],
            body: const Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            ),
          );
        }
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/login-bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.7),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(218, 69, 90, 100),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        key: const Key("login_username"),
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.person),
                          prefixIconColor: Colors.blueGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        key: const Key("login_password"),
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.lock_outline),
                          prefixIconColor: Colors.blueGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        key: const Key("Login_button"),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[500],
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Submit'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          TextButton(
                            key: const Key("signup button"),
                            onPressed: () {
                              context.go('/register');
                            },
                            child: Text(
                              'Create an account',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.blueGrey[200],
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
