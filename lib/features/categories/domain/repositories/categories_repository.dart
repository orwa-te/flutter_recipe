
import 'package:recipe/features/categories/domain/entities/category.dart';

abstract class CategoriesRepository {
  Future<List<RecipeCategory>> getCategories();
}
