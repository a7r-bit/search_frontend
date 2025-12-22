import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
part 'toggle_liked_directory_model.g.dart';

@JsonSerializable()
class ToggleLikedDirectoryModel {
  final String status;
  final String directoryId;

  ToggleLikedDirectoryModel({required this.status, required this.directoryId});

  factory ToggleLikedDirectoryModel.fromJson(Map<String, dynamic> json) =>
      _$ToggleLikedDirectoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleLikedDirectoryModelToJson(this);

  @override
  String toString() =>
      'ToggleLikedDirectoryModel(status: $status, directoryId: $directoryId)';

  ToggleLikedDirectory toDomain() =>
      ToggleLikedDirectory(status: status, directoryId: directoryId);
}
