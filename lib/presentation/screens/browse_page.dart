import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';
import '../../logic/blocs/games/games_bloc.dart';
import '../widgets/games_list.dart';
import '../widgets/new_game_modal.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.fromLTRB(18.0, 16.0, 16.0, 0.0),
                  child: const Text(
                    'Browse',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                (context.read<UserSessionBloc>().state.role == 'admin' ||
                        context.read<UserSessionBloc>().state.role == 'owner')
                    ? Positioned(
                        top: 5,
                        right: 20.0,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              constraints: const BoxConstraints(maxHeight: 600),
                              backgroundColor: Colors.blueGrey[800],
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                              ),
                              builder: (context) => const NewGameModal(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            shape: const StadiumBorder(),
                            elevation: 0,
                          ),
                          icon: const Icon(
                            Icons.add,
                          ),
                          label: const Text(
                            'New Game',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            Expanded(
              child: BlocConsumer<GamesBloc, GamesState>(
                listener: (context, state) {
                  if (state is GameLoadError) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red.withOpacity(0.3),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    );
                  }
                  if (state is GamesLoaded) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Database sync successful!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        backgroundColor: Colors.green.withOpacity(0.5),
                        behavior: SnackBarBehavior.floating,
                        showCloseIcon: true,
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is GamesLoading) {
                    return Scaffold(
                      backgroundColor: Colors.blueGrey[700],
                      body: Stack(
                        children: [
                          const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueGrey,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 12.0,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<GamesBloc>().add(GamesLoadEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent[900],
                                shape: const CircleBorder(),
                                elevation: 0,
                                padding: const EdgeInsets.all(16.0),
                              ),
                              child: const Icon(
                                Icons.refresh,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is GameProcessingSuccess) {
                    context.read<GamesBloc>().add(GamesLoadEvent());
                  }
                  if (state is GamesLoaded) {
                    return Stack(
                      children: [
                        state.games.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.description_outlined,
                                      size: 100,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("No Games"),
                                  ],
                                ),
                              )
                            : GamesList(state.games),
                        Positioned(
                          bottom: 5,
                          right: 12.0,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<GamesBloc>().add(GamesLoadEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent[900],
                              shape: const CircleBorder(),
                              elevation: 0,
                              padding: const EdgeInsets.all(16.0),
                            ),
                            child: const Icon(
                              Icons.refresh,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is GameLoadError) {
                    return Scaffold(
                      backgroundColor: Colors.blueGrey[700],
                      body: Stack(
                        children: [
                          Center(
                            child: Text(
                              'Error: ${state.error}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 12.0,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<GamesBloc>().add(GamesLoadEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent[900],
                                shape: const CircleBorder(),
                                elevation: 0,
                                padding: const EdgeInsets.all(16.0),
                              ),
                              child: const Icon(
                                Icons.refresh,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        Container(),
                        Positioned(
                          bottom: 5,
                          right: 12.0,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<GamesBloc>().add(GamesLoadEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent[900],
                              shape: const CircleBorder(),
                              elevation: 0,
                              padding: const EdgeInsets.all(16.0),
                            ),
                            child: const Icon(
                              Icons.refresh,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
