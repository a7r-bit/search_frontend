part of 'document_version_delete_bloc.dart';

sealed class DocumentVersionDeleteState extends Equatable {
  const DocumentVersionDeleteState();

  @override
  List<Object> get props => [];
}

final class DocumentVersionDeleteInitial extends DocumentVersionDeleteState {}

final class DocumentVersionDeleteLoading extends DocumentVersionDeleteState {}

final class DocumentVersionDeleteSuccess extends DocumentVersionDeleteState {
  final DocumentVersion documentVersion;

  const DocumentVersionDeleteSuccess({required this.documentVersion});

  @override
  List<Object> get props => [documentVersion];
}
