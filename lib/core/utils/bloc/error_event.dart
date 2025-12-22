part of 'error_bloc.dart';

sealed class ErrorEvent extends Equatable {
  const ErrorEvent();

  @override
  List<Object> get props => [];
}

class ErrorReport extends ErrorEvent {
  final Failure failure;

  const ErrorReport({required this.failure});
  @override
  List<Object> get props => [failure];
}
