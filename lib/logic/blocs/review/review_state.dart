part of 'review_bloc.dart';

@immutable
sealed class ReviewState implements Equatable {
  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {
  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReviewInitial;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class ReviewLoading extends ReviewState {
  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReviewLoading;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

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

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

final class ReviewRatingAddSuccess extends ReviewState {
  final Review review;

  ReviewRatingAddSuccess(this.review);

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

final class ReviewRatingUpdateSuccess extends ReviewState {
  final String message;

  ReviewRatingUpdateSuccess(this.message);

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

final class ReviewCommentAddSuccess extends ReviewState {
  final String message;

  ReviewCommentAddSuccess(this.message);

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

final class ReviewCommentUpdateSuccess extends ReviewState {
  final String message;

  ReviewCommentUpdateSuccess(this.message);

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

final class ReviewCommentDeleteSuccess extends ReviewState {
  final String message;

  ReviewCommentDeleteSuccess(this.message);

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

final class ReviewEmpty extends ReviewState {
  final Game game;

  ReviewEmpty(this.game);

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReviewEmpty;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
