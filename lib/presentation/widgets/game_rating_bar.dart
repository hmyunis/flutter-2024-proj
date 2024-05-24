import 'package:flutter/material.dart';

import '../../models/game.dart';

class GameRatingBar extends StatefulWidget {
  const GameRatingBar({required this.game, super.key});
  final Game game;

  @override
  State<GameRatingBar> createState() => _GameRatingBarState();
}

class _GameRatingBarState extends State<GameRatingBar> {
  int _selectedRating = 0;

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "4.0",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
            ),
            Row(
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = index + 1;
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
