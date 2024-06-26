import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/review/review_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';
import '../../models/game.dart';
import '../screens/game_detail_page.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    required this.game,
    required this.tileColor,
    required this.isNotPinned,
  });
  final Game game;
  final dynamic tileColor;
  final bool isNotPinned;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        game.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      tileColor: tileColor,
      subtitle: Text(
        game.description,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.blueGrey[300],
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      trailing: isNotPinned
          ? const Icon(
              Icons.push_pin,
              color: Colors.grey,
            )
          : null,
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.asset(game.imageUrl)),
      onTap: () {
        context.read<ReviewBloc>().add(LoadGameReviews(
              game,
              context.read<UserSessionBloc>().state.id!,
            ));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailPage(game: game),
          ),
        );
      },
    );
  }
}
