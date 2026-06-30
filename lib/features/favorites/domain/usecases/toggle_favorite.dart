import 'package:recipe/features/meals/domain/entities/meal.dart';
import 'package:recipe/features/favorites/domain/repositories/favorites_repository.dart';

class ToggleFavorite {
  final FavoritesRepository repository;

  ToggleFavorite(this.repository);

  Future<void> call(Meal meal) async {
    await repository.toggleFavorite(meal);
  }
}
