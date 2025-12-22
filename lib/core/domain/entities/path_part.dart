import 'package:equatable/equatable.dart';

class PathPart extends Equatable {
  final String? id;
  final String name;

  const PathPart({required this.id, required this.name});

  @override
  String toString() {
    return 'PathPart(id: $id, name: $name)';
  }

  @override
  List<Object?> get props => [id, name];
}
