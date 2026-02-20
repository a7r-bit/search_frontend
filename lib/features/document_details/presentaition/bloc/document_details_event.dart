part of 'document_details_bloc.dart';

sealed class DocumentDetailsEvent extends Equatable {
  const DocumentDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadDocumentDetails extends DocumentDetailsEvent {
  final String nodeId;
  final String? fileName;
  final ConversionStatus? conversionStatus;
  final String? sortParam;
  final String? sortOrder;

  const LoadDocumentDetails({
    this.fileName,
    this.conversionStatus,
    this.sortParam,
    this.sortOrder,
    required this.nodeId,
  });

  @override
  List<Object> get props => [nodeId];
}

class ReloadDocumentDetails extends DocumentDetailsEvent {}
