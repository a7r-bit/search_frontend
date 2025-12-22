part of 'dialog_bloc.dart';

sealed class DialogState extends Equatable {
  const DialogState();

  @override
  List<Object> get props => [];
}

final class DialogInitial extends DialogState {}

final class DialogLoading extends DialogState {}

final class DialogLoaded extends DialogState {
  final FileNode fileNode;

  const DialogLoaded({required this.fileNode});

  @override
  List<Object> get props => [fileNode];
}

class DialogDirectoryRenamed extends DialogState {
  final FileNode fileNode;
  const DialogDirectoryRenamed({required this.fileNode});
  @override
  List<Object> get props => [fileNode];
}

class DialogDocumentRenamed extends DialogState {
  final FileNode fileNode;
  const DialogDocumentRenamed({required this.fileNode});
  @override
  List<Object> get props => [fileNode];
}

final class DialogError extends DialogState {
  final Failure failure;

  const DialogError({required this.failure});

  @override
  List<Object> get props => [failure];
}
