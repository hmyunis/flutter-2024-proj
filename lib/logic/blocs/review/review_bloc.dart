import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/reviews_repository.dart';
import '../../../models/review.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewsRepository _reviewsRepository;

  ReviewBloc(this._reviewsRepository) : super(ReviewInitial()) {
    on<LoadGameReviews>(_onLoadGameReviews);
    on<AddGameReview>(_onAddGameReview);
    on<UpdateGameReview>(_onUpdateGameReview);
    on<DeleteGameReview>(_onDeleteGameReview);
  }

  void _onLoadGameReviews(
      LoadGameReviews event, Emitter<ReviewState> emit) async {}

  void _onAddGameReview(AddGameReview event, Emitter<ReviewState> emit) async {}

  void _onUpdateGameReview(
      UpdateGameReview event, Emitter<ReviewState> emit) async {}

  void _onDeleteGameReview(
      DeleteGameReview event, Emitter<ReviewState> emit) async {}
}
