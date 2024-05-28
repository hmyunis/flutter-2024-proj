import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/models/collection.dart';

Matcher equalsCollection(Collection expected) => _CollectionMatcher(expected);

class _CollectionMatcher extends Matcher {
  final Collection _expected;

  _CollectionMatcher(this._expected);

  @override
  Description describe(Description description) =>
      description.add('equals collection with properties ${_expected.toJson()}');

  @override
  bool matches(item, Map matchState) {
    if (item is! Collection) return false;
    return item.id == _expected.id &&
           item.status == _expected.status &&
           item.gameId == _expected.gameId &&
           item.userId == _expected.userId;
  }

  @override
  Description describeMismatch(item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! Collection) {
      return mismatchDescription.add('is not a Collection');
    }
    return mismatchDescription.add('is a Collection with properties ${item.toJson()}');
  }
}
