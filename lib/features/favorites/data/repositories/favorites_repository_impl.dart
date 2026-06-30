import 'package:recipe/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:recipe/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:recipe/features/meals/data/models/meal_model.dart';
import 'package:recipe/features/meals/domain/entities/meal.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Meal>> getFavorites() async {
    return await localDataSource.getFavorites();
  }

  @override
  Future<void> toggleFavorite(Meal meal) async {
    final mealModel = MealModel(
      id: meal.id,
      name: meal.name,
      thumbnail: meal.thumbnail,
    );
    await localDataSource.toggleFavorite(mealModel);
  }

  @override
  Future<bool> isFavorite(String mealId) async {
    return await localDataSource.isFavorite(mealId);
  }
}
