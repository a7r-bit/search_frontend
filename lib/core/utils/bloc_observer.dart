import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/core/utils/bloc/error_bloc.dart';
import 'package:search_frontend/core/utils/injection.dart';

class MyBlocObserver extends BlocObserver {
  final ErrorBloc errorBloc = getIt<ErrorBloc>();
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // TODO: implement onEvent
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (error is Failure) {
      errorBloc.add(ErrorReport(failure: error));
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // TODO: implement onChange
  }
}
