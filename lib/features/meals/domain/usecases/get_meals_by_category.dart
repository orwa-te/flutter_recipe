import 'package:recipe/features/meals/domain/entities/meal.dart';
import 'package:recipe/features/meals/domain/repositories/meals_repository.dart';

class GetMealsByCategory {
  final MealsRepository repository;

  GetMealsByCategory(this.repository);

  Future<List<Meal>> call(String categoryName) async {
    return await repository.getMealsByCategory(categoryName);
  }
}
