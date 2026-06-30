import 'package:recipe/features/meals/domain/entities/meal.dart';
import 'package:recipe/features/favorites/domain/repositories/favorites_repository.dart';

class GetFavorites {
  final FavoritesRepository repository;

  GetFavorites(this.repository);

  Future<List<Meal>> call() async {
    return await repository.getFavorites();
  }
}
