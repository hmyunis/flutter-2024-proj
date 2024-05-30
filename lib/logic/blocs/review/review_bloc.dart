import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/data_providers/users_data_provider.dart';
import '../../../data/repositories/reviews_repository.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../models/game.dart';
import '../../../models/review.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewsRepository _reviewsRepository;

  ReviewBloc(this._reviewsRepository) : super(ReviewInitial()) {
    on<LoadGameReviews>(_onLoadGameReviews);
    on<AddGameRatingReview>(_onAddGameRatingReview);
    on<UpdateGameRating>(_onUpdateGameRating);
    on<AddGameCommentReview>(_onAddGameCommentReview);
    on<UpdateGameCommentReview>(_onUpdateGameCommentReview);
    on<DeleteGameCommentReview>(_onDeleteGameCommentReview);
  }

  void _onLoadGameReviews(
      LoadGameReviews event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final reviews =
          await _reviewsRepository.getReviewsByGameId(event.game.id!);
      if (reviews.isEmpty) {
        emit(ReviewEmpty(event.game));
        return;
      }

      final returnedValues = []; // userLastRating, averageRating, numReviews

      final sortedReviews = reviews.reversed.toList();
      for (var review in sortedReviews) {
        if (review.userId == event.userId && review.rating != 0) {
          final userLastRating = review.rating;
          returnedValues.add(userLastRating);
          break;
        }
      }
      if (returnedValues.isEmpty) {
        const userLastRating = 0;
        returnedValues.add(userLastRating);
      }
      num sum = 0;
      for (var review in sortedReviews) {
        sum += review.rating;
      }
      final int ratedGameReviews =
          reviews.where((review) => review.rating != 0).length;
      final averageRating =
          sum / (ratedGameReviews == 0 ? 1 : ratedGameReviews);

      final commentContainingReviews =
          reviews.where((review) => review.comment != "").toList();
      final int numComments = commentContainingReviews.length;

      returnedValues.add(averageRating);
      returnedValues.add(numComments);

      if (returnedValues.length != 3) {
        throw Exception();
      }

      final userIdToUsernameMap = <int, String>{};
      final UsersDataProvider usersDataProvider = UsersDataProvider();
      final UsersRepository usersRepository =
          UsersRepository(usersDataProvider);
      final users = await usersRepository.getUsers();
      for (var user in users) {
        userIdToUsernameMap[user.id!] = user.username;
      }

      emit(ReviewsLoaded(
        reviews: sortedReviews.where((review) => review.comment != "").toList(),
        userIdToUsernameMap: userIdToUsernameMap,
        userLastRating: returnedValues[0],
        averageRating: returnedValues[1],
        numComments: returnedValues[2],
      ));
    } catch (e) {
      emit(ReviewError("Failed to load reviews"));
    }
  }

  void _onAddGameRatingReview(
      AddGameRatingReview event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final addedReview = await _reviewsRepository.addReview(Review(
        userId: event.review.userId,
        gameId: event.review.gameId,
        rating: event.review.rating,
        comment: "",
      ));
      emit(ReviewRatingAddSuccess(addedReview));
    } catch (e) {
      emit(ReviewError("Failed to add rating"));
    }
  }

  void _onUpdateGameRating(
      UpdateGameRating event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final allReviews =
          await _reviewsRepository.getReviewsByGameId(event.review.gameId);
      final Review reviewToBeUpdated = allReviews.firstWhere((review) =>
          review.userId == event.review.userId && review.comment == "");
      await _reviewsRepository.updateReview(
          reviewToBeUpdated.id!,
          Review(
            userId: event.review.userId,
            gameId: event.review.gameId,
            rating: event.review.rating,
            comment: reviewToBeUpdated.comment,
          ));
      emit(ReviewRatingUpdateSuccess("${event.review.rating}"));
    } catch (e) {
      emit(ReviewError("Failed to update rating"));
    }
  }

  void _onAddGameCommentReview(
      AddGameCommentReview event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      await _reviewsRepository.addReview(Review(
        userId: event.review.userId,
        gameId: event.review.gameId,
        rating: event.review.rating,
        comment: event.review.comment,
      ));
      emit(ReviewCommentAddSuccess("Comment added successfully."));
    } catch (e) {
      emit(ReviewError("Failed to add comment"));
    }
  }

  void _onUpdateGameCommentReview(
      UpdateGameCommentReview event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final allReviews =
          await _reviewsRepository.getReviewsByGameId(event.review.gameId);
      final Review reviewToBeUpdated = allReviews.firstWhere((review) =>
          review.userId == event.review.userId &&
          review.comment == event.review.comment);
      await _reviewsRepository.updateReview(
          reviewToBeUpdated.id!,
          Review(
            userId: event.review.userId,
            gameId: event.review.gameId,
            rating: event.review.rating,
            comment: event.newComment,
          ));
      emit(ReviewCommentUpdateSuccess("Comment updated successfully."));
    } catch (e) {
      emit(ReviewError("Failed to update comment"));
    }
  }

  void _onDeleteGameCommentReview(
      DeleteGameCommentReview event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final allReviews =
          await _reviewsRepository.getReviewsByGameId(event.review.gameId);
      final Review reviewToBeDeleted = allReviews.firstWhere(
        (review) =>
            review.userId == event.review.userId &&
            review.comment == event.review.comment,
      );
      await _reviewsRepository.deleteReview(reviewToBeDeleted.id!);
      emit(ReviewCommentDeleteSuccess("Comment deleted successfully."));
    } catch (e) {
      emit(ReviewError("Failed to delete comment"));
    }
  }
}
