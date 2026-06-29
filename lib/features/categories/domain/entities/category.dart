import 'package:equatable/equatable.dart';

class RecipeCategory extends Equatable {
  final String id;
  final String name;
  final String thumbnail;
  final String description;

  const RecipeCategory({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, thumbnail, description];
}
