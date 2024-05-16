import 'package:flutter/material.dart';
import '../data/games.dart';
import '../widgets/games_list.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.fromLTRB(18.0, 16.0, 16.0, 0.0),
          child: const Text('Browse',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.5,
              )),
        ),
        Expanded(
          child: GamesList(games),
        ),
      ],
    );
  }
}
