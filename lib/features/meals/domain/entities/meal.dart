import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String id;
  final String name;
  final String thumbnail;

  const Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [id, name, thumbnail];
}
