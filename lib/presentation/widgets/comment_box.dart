import 'package:flutter/material.dart';

import '../../models/game.dart';

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
        color: Colors.blueGrey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: double.maxFinite,
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Icon(
              Icons.account_circle,
              size: 40,
              color: Colors.blueGrey,
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
                  color: Colors.grey,
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
                if (_commentController.text.isNotEmpty) {
                  // send comment to server
                  _commentController.clear();
                  // refresh comment section to show new comments
                } else {
                  // show error message
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
