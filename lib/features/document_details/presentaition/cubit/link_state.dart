part of 'link_cubit.dart';

sealed class LinkState extends Equatable {
  const LinkState();

  @override
  List<Object> get props => [];
}

final class LinkInitial extends LinkState {}

final class LinkLoading extends LinkState {}

final class LinkSuccess extends LinkState {}

final class LinkFailure extends LinkState {
  final String message;

  const LinkFailure({required this.message});

  @override
  List<Object> get props => [message];
}
