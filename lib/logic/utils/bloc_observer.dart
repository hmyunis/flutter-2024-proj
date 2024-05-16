import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('${bloc.runtimeType} Created!');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('$bloc Changed - $change');
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('$bloc transitioning to - $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$bloc caused the error - $error');
    super.onError(bloc, error, stackTrace);
  }
}
