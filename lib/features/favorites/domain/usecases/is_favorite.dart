import 'package:recipe/features/favorites/domain/repositories/favorites_repository.dart';

class IsFavorite {
  final FavoritesRepository repository;

  IsFavorite(this.repository);

  Future<bool> call(String mealId) async {
    return await repository.isFavorite(mealId);
  }
}
