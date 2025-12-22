import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';

part 'saved_directory_model.g.dart';

@JsonSerializable()
class SavedDirectoryModel {
  final String id;
  final String name;
  final int childrenCount;
  final int documentCount;

  SavedDirectoryModel({
    required this.id,
    required this.name,
    required this.childrenCount,
    required this.documentCount,
  });

  factory SavedDirectoryModel.fromJson(Map<String, dynamic> json) =>
      _$SavedDirectoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavedDirectoryModelToJson(this);

  SavedDirectory toDomain() => SavedDirectory(
    id: id,
    name: name,
    childrenCount: childrenCount,
    documentCount: documentCount,
  );
}
