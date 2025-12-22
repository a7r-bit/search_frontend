part of 'directory_bloc.dart';

sealed class DirectoryEvent extends Equatable {
  const DirectoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadChildren extends DirectoryEvent {
  final String? parentId;

  const LoadChildren({required this.parentId});

  @override
  List<Object?> get props => [parentId];
}

class LoadPath extends DirectoryEvent {
  final String? directoryId;

  const LoadPath({required this.directoryId});

  @override
  List<Object?> get props => [directoryId];
}

class DeleteDirectory extends DirectoryEvent {
  final String directoryId;
  final String? parentId;
  const DeleteDirectory({required this.directoryId, required this.parentId});

  @override
  List<Object?> get props => [directoryId, parentId];
}

class DeleteDocument extends DirectoryEvent {
  final String documentId;
  final String? parentId;
  const DeleteDocument({required this.documentId, required this.parentId});

  @override
  List<Object?> get props => [documentId, parentId];
}
