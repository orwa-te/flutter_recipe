

import 'package:recipe/features/categories/domain/entities/category.dart';
import 'package:recipe/features/categories/domain/repositories/categories_repository.dart';

class GetCategories {
  final CategoriesRepository repository;

  GetCategories(this.repository);

  Future<List<RecipeCategory>> call() async {
    return await repository.getCategories();
  }
}
