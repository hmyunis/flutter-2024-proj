import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/review/review_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';
import '../../models/game.dart';
import '../../models/review.dart';

class CommentBox extends StatefulWidget {
  const CommentBox({required this.game, super.key});
  final Game game;

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              Icons.account_circle,
              size: 40,
              color: Colors.cyan[700],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Write a comment...',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                if (_commentController.text.trim().isNotEmpty) {
                  context.read<ReviewBloc>().add(AddGameCommentReview(Review(
                        userId: context.read<UserSessionBloc>().state.id!,
                        gameId: widget.game.id!,
                        comment: _commentController.text,
                        rating: 0,
                      )));
                  _commentController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Please enter a comment first",
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
              },
              icon: const Icon(
                Icons.send,
                size: 30,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
