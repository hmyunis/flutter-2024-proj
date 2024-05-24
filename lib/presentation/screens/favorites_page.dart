import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/collection/collection_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';
import '../widgets/favorite_item.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16.0),
          child: const Text('Favorites',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.5,
              )),
        ),
        Expanded(
          child: BlocConsumer<CollectionBloc, CollectionState>(
            listener: (context, state) {
              if (state is CollectionError) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red.withOpacity(0.3),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                );
              }
              if (state is GamePinnedSuccess) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.push_pin,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            'You pinned ${state.title}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    backgroundColor: Colors.blueGrey.withOpacity(0.7),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              }
              if (state is GameRemovedSuccess) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.delete_rounded,
                          size: 32.0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            'You removed ${state.title} from favorites.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    backgroundColor: Colors.red[300]?.withOpacity(0.5),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is CollectionLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueGrey,
                  ),
                );
              }
              if (state is CollectionEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.collections_bookmark_outlined,
                        color: Colors.grey.withOpacity(0.5),
                        size: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "You have no favorites...",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is CollectionLoaded) {
                final allGames = [...state.pinnedGames, ...state.unPinnedGames];
                return ListView.separated(
                    itemBuilder: ((context, index) => Dismissible(
                          key: Key(allGames[index].title),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              context.read<CollectionBloc>().add(
                                  RemoveGameFromCollection(
                                      allGames[index],
                                      context
                                          .read<UserSessionBloc>()
                                          .state
                                          .id!));
                              allGames.remove(allGames[index]);
                              context.read<CollectionBloc>().add(
                                  FetchCollection(context
                                      .read<UserSessionBloc>()
                                      .state
                                      .token!));
                            } else if (direction ==
                                DismissDirection.startToEnd) {
                              final userId =
                                  context.read<UserSessionBloc>().state.id;
                              final token =
                                  context.read<UserSessionBloc>().state.token;
                              if (index >= state.pinnedGames.length) {
                                context.read<CollectionBloc>().add(
                                    UnpinGameInCollection(
                                        allGames[index], userId!));
                              } else {
                                context.read<CollectionBloc>().add(
                                    PinGameInCollection(
                                        allGames[index], userId!));
                              }
                              context
                                  .read<CollectionBloc>()
                                  .add(FetchCollection(token!));
                            }
                          },
                          background: Container(
                            color: Colors.blue,
                            padding: const EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Icon(
                                (index >= state.pinnedGames.length)
                                    ? Icons.push_pin_rounded
                                    : Icons.push_pin_outlined,
                                color: Colors.white,
                                size: 30),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.only(right: 20),
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.delete,
                                color: Colors.white, size: 30),
                          ),
                          child: FavoriteItem(
                            game: allGames[index],
                            tileColor: ((index < state.pinnedGames.length)
                                ? Colors.blueGrey[800]?.withOpacity(0.4)
                                : Colors.blueGrey),
                            isNotPinned: (index < state.pinnedGames.length),
                          ),
                        )),
                    separatorBuilder: ((context, index) =>
                        const SizedBox(height: 5)),
                    itemCount: allGames.length);
              }
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: Colors.grey.withOpacity(0.5),
                      size: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Please wait...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
