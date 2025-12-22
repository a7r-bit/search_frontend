part of 'dialog_bloc.dart';

sealed class DialogEvent extends Equatable {
  const DialogEvent();

  @override
  List<Object?> get props => [];
}

class CreateNode extends DialogEvent {
  final NodeType type;
  final String name;
  final String? parentId;

  const CreateNode({
    required this.type,
    required this.name,
    required this.parentId,
  });
  @override
  List<Object?> get props => [parentId, name, type];
}

class CreateDocument extends DialogEvent {
  final String name;
  final String? description;
  final String directoryId;

  const CreateDocument({
    required this.name,
    required this.description,
    required this.directoryId,
  });
  @override
  List<Object?> get props => [name, description, directoryId];
}

class RenameDirectory extends DialogEvent {
  final String directoryId;
  final String? name;
  final String? parentId;

  const RenameDirectory({
    required this.parentId,
    required this.directoryId,
    required this.name,
  });

  @override
  List<Object?> get props => [directoryId, name];
}

class RenameDocument extends DialogEvent {
  final String documentId;
  final String? title;
  final String? description;
  final String? directoryId;

  const RenameDocument({
    required this.directoryId,
    required this.description,
    required this.documentId,
    required this.title,
  });

  @override
  List<Object?> get props => [documentId, title];
}
