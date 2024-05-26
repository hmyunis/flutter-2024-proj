import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/review/review_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';
import '../../models/game.dart';
import '../../models/review.dart';

class GameRatingBar extends StatefulWidget {
  const GameRatingBar({
    required this.game,
    required this.userLastRating,
    required this.averageRating,
    super.key,
  });
  final Game game;
  final int userLastRating;
  final double averageRating;

  @override
  State<GameRatingBar> createState() => _GameRatingBarState();
}

class _GameRatingBarState extends State<GameRatingBar> {
  int _selectedRating = 0;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.userLastRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.maxFinite,
          child: Text(
            "Ratings and reviews",
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.averageRating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 52,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedRating == 0) {
                        context
                            .read<ReviewBloc>()
                            .add(AddGameRatingReview(Review(
                              gameId: widget.game.id!,
                              rating: index + 1,
                              userId: context.read<UserSessionBloc>().state.id!,
                            )));
                        return;
                      }
                      _selectedRating = index + 1;
                      context.read<ReviewBloc>().add(UpdateGameRating(Review(
                            gameId: widget.game.id!,
                            rating: _selectedRating,
                            userId: context.read<UserSessionBloc>().state.id!,
                            comment: "",
                          )));
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      index < _selectedRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
