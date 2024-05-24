part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent {}

final class LoadGameReviews extends ReviewEvent {
  final List<Review> reviews;

  LoadGameReviews(this.reviews);
}

final class AddGameReview extends ReviewEvent {
  final Review review;

  AddGameReview(this.review);
}

final class UpdateGameReview extends ReviewEvent {
  final Review review;
  final int reviewId;

  UpdateGameReview(this.review, this.reviewId);
}

final class DeleteGameReview extends ReviewEvent {
  final Review review;

  DeleteGameReview(this.review);
}