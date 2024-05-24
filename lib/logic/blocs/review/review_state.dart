part of 'review_bloc.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class ReviewLoading extends ReviewState {}

final class ReviewsLoaded extends ReviewState {
  final List<Review> reviews;

  ReviewsLoaded(this.reviews);
}

final class ReviewAddSuccess extends ReviewState {}

final class ReviewUpdateSuccess extends ReviewState {}

final class ReviewDeleteSuccess extends ReviewState {}

final class ReviewEmpty extends ReviewState {}

final class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);
}

