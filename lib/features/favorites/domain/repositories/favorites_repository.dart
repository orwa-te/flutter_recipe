import 'package:recipe/features/meals/domain/entities/meal.dart';

abstract class FavoritesRepository {
  Future<List<Meal>> getFavorites();
  Future<void> toggleFavorite(Meal meal);
  Future<bool> isFavorite(String mealId);
}
