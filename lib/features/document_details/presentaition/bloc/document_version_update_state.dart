part of 'document_version_update_bloc.dart';

sealed class DocumentVersionUpdateState extends Equatable {
  const DocumentVersionUpdateState();

  @override
  List<Object> get props => [];
}

final class DocumentVersionUpdateInitial extends DocumentVersionUpdateState {}

class DocumentVersionUpdating extends DocumentVersionUpdateState {}

class DocumentVersionUpdateSuccess extends DocumentVersionUpdateState {
  final DocumentVersion documentVersion;

  const DocumentVersionUpdateSuccess({required this.documentVersion});

  @override
  List<Object> get props => [documentVersion];
}
