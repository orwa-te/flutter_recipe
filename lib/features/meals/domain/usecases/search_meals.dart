import 'package:recipe/features/meals/domain/entities/meal.dart';
import 'package:recipe/features/meals/domain/repositories/meals_repository.dart';

class SearchMeals {
  final MealsRepository repository;

  SearchMeals(this.repository);

  Future<List<Meal>> call(String query) async {
    return await repository.searchMeals(query);
  }
}
