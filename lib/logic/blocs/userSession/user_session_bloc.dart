import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user.dart';

part 'user_session_event.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, User> {
  UserSessionBloc()
      : super(User(username: "", email: "", joinDate: "", role: "")) {
    on<UserSessionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
