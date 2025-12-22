part of 'document_details_bloc.dart';

sealed class DocumentDetailsState extends Equatable {
  const DocumentDetailsState();

  @override
  List<Object> get props => [];
}

final class DocumentDetailsInitial extends DocumentDetailsState {}

final class DocumentDetailsLoading extends DocumentDetailsState {}

final class DocumentDetailsLoaded extends DocumentDetailsState {
  final Document document;
  final List<DocumentVersion> documentVersions;
  final String? fileName;
  final ConversionStatus? conversionStatus;
  final String? sortParam;
  final String? sortOrder;

  const DocumentDetailsLoaded({
    this.fileName,
    this.conversionStatus,
    this.sortParam,
    this.sortOrder,
    required this.document,
    required this.documentVersions,
  });

  @override
  List<Object> get props => [document, documentVersions];
}

final class DocumentDetailsError extends DocumentDetailsState {
  final Failure failure;

  const DocumentDetailsError({required this.failure});

  @override
  List<Object> get props => [failure];
}
