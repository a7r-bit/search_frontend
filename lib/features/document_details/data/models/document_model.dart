import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
part 'document_model.g.dart';

@JsonSerializable()
class DocumentModel {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  DocumentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);

  Document toDOmain() => Document(
    id: id,
    title: title,
    description: description,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
