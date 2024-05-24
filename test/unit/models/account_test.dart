import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_catalogue_app/models/account.dart';

void main() {
  group('Account', () {
    test('Account is created with correct userName and userType', () {
      const userName = 'testUser';
      const userType = 'admin';

      const account = Account(userName: userName, userType: userType);

      expect(account.userName, equals(userName));
      expect(account.userType, equals(userType));
    });

  });
}
