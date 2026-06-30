import 'package:recipe/features/meals/data/datasources/meals_remote_data_source.dart';
import 'package:recipe/features/meals/domain/entities/meal.dart';
import 'package:recipe/features/meals/domain/repositories/meals_repository.dart';

class MealsRepositoryImpl implements MealsRepository {
  final MealsRemoteDataSource remoteDataSource;

  MealsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Meal>> getMealsByCategory(String categoryName) async {
    try {
      return await remoteDataSource.getMealsByCategory(categoryName);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Meal>> searchMeals(String query) async {
    try {
      return await remoteDataSource.searchMeals(query);
    } catch (e) {
      rethrow;
    }
  }
}
