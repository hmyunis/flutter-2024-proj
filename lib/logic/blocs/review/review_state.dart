part of 'review_bloc.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class ReviewLoading extends ReviewState {}

final class ReviewsLoaded extends ReviewState {
  final List<Review> reviews;
  final Map<int, String> userIdToUsernameMap;
  final int userLastRating;
  final double averageRating;
  final int numComments;

  ReviewsLoaded(
      {required this.reviews,
      required this.userIdToUsernameMap,
      required this.userLastRating,
      required this.averageRating,
      required this.numComments});
}

final class ReviewRatingAddSuccess extends ReviewState {
  final Review review;

  ReviewRatingAddSuccess(this.review);
}

final class ReviewRatingUpdateSuccess extends ReviewState {
  final String message;

  ReviewRatingUpdateSuccess(this.message);
}

final class ReviewCommentAddSuccess extends ReviewState {
  final String message;

  ReviewCommentAddSuccess(this.message);
}

final class ReviewCommentUpdateSuccess extends ReviewState {
  final String message;

  ReviewCommentUpdateSuccess(this.message);
}

final class ReviewCommentDeleteSuccess extends ReviewState {
  final String message;

  ReviewCommentDeleteSuccess(this.message);
}

final class ReviewEmpty extends ReviewState {
  final Game game;

  ReviewEmpty(this.game);
}

final class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);
}
