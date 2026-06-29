import 'package:recipe/features/meals/domain/entities/meal.dart';

abstract class MealsRepository {
  Future<List<Meal>> getMealsByCategory(String categoryName);
}
