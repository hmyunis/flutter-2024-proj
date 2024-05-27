import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/games/games_bloc.dart';
import '../../logic/blocs/review/review_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';
import '../../models/game.dart';
import '../widgets/comment_box.dart';
import '../widgets/comment_section.dart';
import '../widgets/edit_delete.dart';
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
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        widget.game.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 450,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
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
                  ),
                  (context.read<UserSessionBloc>().state.role == "owner" ||
                          context.read<UserSessionBloc>().state.role == "admin")
                      ? EditDelete(game: widget.game)
                      : const SizedBox(
                          height: 30,
                        ),
                  BlocConsumer<ReviewBloc, ReviewState>(
                    listener: (context, state) {
                      if (state is ReviewError) {
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
                      if (state is ReviewsLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.keyboard_double_arrow_down_rounded,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Review available.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                )
                              ],
                            ),
                            duration: const Duration(
                              seconds: 1,
                            ),
                            backgroundColor: Colors.blueGrey.withOpacity(0.5),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        );
                      }
                      if (state is ReviewRatingUpdateSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    "You have rated this game ${state.message} stars.",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            duration: const Duration(
                              seconds: 1,
                            ),
                            backgroundColor: Colors.blueGrey.withOpacity(0.5),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        );
                      }
                      if (state is ReviewRatingAddSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "You rated this game ${state.review.rating}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                )
                              ],
                            ),
                            duration: const Duration(
                              seconds: 1,
                            ),
                            backgroundColor: Colors.blueGrey.withOpacity(0.5),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        );
                      }
                      if (state is ReviewCommentDeleteSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  state.message,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                )
                              ],
                            ),
                            duration: const Duration(
                              seconds: 1,
                            ),
                            backgroundColor: Colors.blueGrey.withOpacity(0.5),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ReviewLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueGrey,
                          ),
                        );
                      }
                      if (state is ReviewRatingAddSuccess ||
                          state is ReviewRatingUpdateSuccess ||
                          state is ReviewCommentAddSuccess ||
                          state is ReviewCommentUpdateSuccess ||
                          state is ReviewCommentDeleteSuccess) {
                        context.read<ReviewBloc>().add(LoadGameReviews(
                            widget.game,
                            context.read<UserSessionBloc>().state.id!));
                      }
                      if (state is ReviewsLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GameRatingBar(
                                game: widget.game,
                                userLastRating: state.userLastRating,
                                averageRating: state.averageRating,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CommentBox(game: widget.game),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Comments',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent.withOpacity(0.5),
                                      border: Border.all(
                                        color: Colors.blue.withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  padding:
                                      const EdgeInsets.fromLTRB(18, 2, 18, 2),
                                  child: Text(
                                    state.numComments.toString(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CommentSection(
                              reviews: state.reviews,
                              userIdToUsernameMap: state.userIdToUsernameMap,
                              numReviews: state.numComments,
                            ),
                          ],
                        );
                      }
                      if (state is ReviewEmpty) {
                        return Column(
                          children: [
                            GameRatingBar(
                              game: state.game,
                              userLastRating: 0,
                              averageRating: 0.0,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CommentBox(game: state.game),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      color: Colors.grey.withOpacity(0.5),
                                      size: 100,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "No review found",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox(
                        height: 30,
                      );
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }
}
