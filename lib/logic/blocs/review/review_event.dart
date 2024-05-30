part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}


final class LoadGameReviews extends ReviewEvent {
  final Game game;
  final int userId;

  LoadGameReviews(this.game, this.userId);
}

final class AddGameRatingReview extends ReviewEvent {
  final Review review;

  AddGameRatingReview(this.review);
}

final class UpdateGameRating extends ReviewEvent {
  final Review review;

  UpdateGameRating(this.review);
}

final class AddGameCommentReview extends ReviewEvent {
  final Review review;

  AddGameCommentReview(this.review);
}

final class UpdateGameCommentReview extends ReviewEvent {
  final Review review;
  final String newComment;

  UpdateGameCommentReview(this.review, this.newComment);
}

final class DeleteGameCommentReview extends ReviewEvent {
  final Review review;

  DeleteGameCommentReview(this.review);
}