import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';

part 'error_event.dart';
part 'error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(ErrorInitial()) {
    on<ErrorReport>((event, emit) async {
      emit(ErrorReported(failure: event.failure));
      await Future.delayed(Duration(seconds: 2));
      emit(ErrorInitial());
    });
  }
}
