import 'dart:convert';

import '../data_providers/reviews_data_provider.dart';

import '../../models/review.dart';

class ReviewsRepository {
  final ReviewsDataProvider _reviewsDataProvider;
  ReviewsRepository(this._reviewsDataProvider);

  Future<List<Review>> getReviewsByGameId(int gameId) async {
    final response =
        await _reviewsDataProvider.getReviewsByGameId(gameId.toString());
    final reviews = jsonDecode(response);
    final allGameReviews = <Review>[];
    for (final review in reviews) {
      allGameReviews.add(Review.fromJson(review));
    }
    return allGameReviews;
  }

  Future<Review> getReviewById(int reviewId) async {
    final response = await _reviewsDataProvider.getReview(reviewId.toString());
    final review = jsonDecode(response);
    return Review.fromJson(review);
  }

  Future<List<Review>> getReviews() async {
    final response = await _reviewsDataProvider.getReviews();
    final reviews = jsonDecode(response);
    final allReviews = <Review>[];
    for (final review in reviews) {
      allReviews.add(Review.fromJson(review));
    }
    return allReviews;
  }

  Future<Review> addReview(Review review) async {
    final response = await _reviewsDataProvider.addReview({
      'userId': review.userId,
      'gameId': review.gameId,
      'comment': review.comment,
      'rating': review.rating,
    });
    final newReview = jsonDecode(response);
    return Review.fromJson(newReview);
  }

  Future<void> deleteReview(int reviewId) async {
    await _reviewsDataProvider.deleteReview(reviewId.toString());
  }

  Future<Review> updateReview(int reviewId, Review review) async {
    final response =
        await _reviewsDataProvider.updateReview(reviewId.toString(), {
      'userId': review.userId,
      'gameId': review.gameId,
      'comment': review.comment,
      'rating': review.rating,
    });
    final updatedReview = jsonDecode(response);
    return Review.fromJson(updatedReview);
  }
}
