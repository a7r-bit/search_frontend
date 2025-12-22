part of 'error_bloc.dart';

sealed class ErrorState extends Equatable {
  const ErrorState();

  @override
  List<Object> get props => [];
}

final class ErrorInitial extends ErrorState {}

final class ErrorReported extends ErrorState {
  final Failure failure;

  const ErrorReported({required this.failure});

  @override
  List<Object> get props => [failure];
}
