import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/games/games_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';
import '../widgets/comment_box.dart';
import '../widgets/edit_delete.dart';
import '../../models/game.dart';
import '../widgets/comment_section.dart';
import '../widgets/game_rating_bar.dart';

// ignore: must_be_immutable
class GameDetailPage extends StatefulWidget {
  GameDetailPage({super.key, required this.game});
  Game game;

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GamesBloc, GamesState>(
      listener: (context, state) {
        if (state is GameUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.edit_document,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      '${state.game.title} updated successfully.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  )
                ],
              ),
              backgroundColor: Colors.blueGrey.withOpacity(0.8),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          );
        }
        if (state is GameDeleteSuccess) {
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
                      '${state.game.title} deleted successfully.',
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
        if (state is GameUpdateSuccess) {
          widget.game = state.game;
        }
        return Scaffold(
            backgroundColor: Colors.blueGrey[700],
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[900],
              title: Text(widget.game.title),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      widget.game.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 450,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              widget.game.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    widget.game.title.length > 20 ? 24 : 32,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Genre: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.game.genre,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Platform: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              widget.game.platform,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Publisher: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              widget.game.publisher,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Release Date: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.game.releaseDate,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description: ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                widget.game.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  (context.read<UserSessionBloc>().state.role == "owner" ||
                          context.read<UserSessionBloc>().state.role == "admin")
                      ? EditDelete(game: widget.game)
                      : const SizedBox(
                          height: 30,
                        ),
                  // Review bloc consumer here
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GameRatingBar(game: widget.game),
                      const SizedBox(
                        height: 30,
                      ),
                      CommentBox(game: widget.game),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CommentSection(game: widget.game),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
