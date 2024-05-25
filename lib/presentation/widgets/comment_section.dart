import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/review/review_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';
import '../../models/review.dart';

class CommentSection extends StatefulWidget {
  const CommentSection(
      {super.key, required this.reviews, required this.numReviews});
  final List<Review> reviews;
  final int numReviews;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    if (context.read<UserSessionBloc>().state.id ==
                        widget.reviews[index].userId) {
                      context
                          .read<ReviewBloc>()
                          .add(DeleteGameCommentReview(Review(
                            userId: widget.reviews[index].userId,
                            gameId: widget.reviews[index].gameId,
                            comment: widget.reviews[index].comment,
                            rating: 0,
                          )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.disabled_by_default_rounded,
                                color: Colors.red[300],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Flexible(
                                child: Text(
                                  "You can only delete your own comment.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              )
                            ],
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
                    Navigator.pop(context);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 10),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  child: ListTile(
                    tileColor: (context.read<UserSessionBloc>().state.id ==
                            widget.reviews[index].userId)
                        ? Colors.grey[100]
                        : Colors.blueGrey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side:
                          const BorderSide(color: Colors.blueGrey, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    leading: Icon(
                      Icons.account_circle,
                      size: 40,
                      color: (context.read<UserSessionBloc>().state.id ==
                              widget.reviews[index].userId)
                          ? Colors.cyan[700]
                          : Colors.blueGrey,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "user id: ${widget.reviews[index].userId}",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 2.0,
                            color: (context.read<UserSessionBloc>().state.id ==
                                    widget.reviews[index].userId)
                                ? Colors.cyan[800]
                                : Colors.blueGrey,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.reviews[index].createdAt
                                  .toString()
                                  .substring(
                                      0,
                                      widget.reviews[index].createdAt
                                          .toString()
                                          .indexOf(",")),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              " |${widget.reviews[index].createdAt.toString().substring(
                                    widget.reviews[index].createdAt
                                            .toString()
                                            .indexOf(",") +
                                        1,
                                  )}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Text(widget.reviews[index].comment!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey[900],
                        )),
                  ),
                );
              },
              itemCount: widget.numReviews,
            ),
          ),
        ],
      ),
    );
  }
}
