import 'package:dio/dio.dart';
import 'package:recipe/core/network/api_constants.dart';
import 'package:recipe/features/meals/data/models/meal_model.dart';

abstract class MealsRemoteDataSource {
  Future<List<MealModel>> getMealsByCategory(String categoryName);
  Future<List<MealModel>> searchMeals(String query);
}

class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final Dio dio;

  MealsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MealModel>> getMealsByCategory(String categoryName) async {
    try {
      final response = await dio.get('${ApiConstants.filterByCategory}$categoryName');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['meals'] ?? [];
        return data.map((json) => MealModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Error fetching meals: $e');
    }
  }

  @override
  Future<List<MealModel>> searchMeals(String query) async {
    try {
      final response = await dio.get('${ApiConstants.searchByName}$query');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['meals'] ?? [];
        return data.map((json) => MealModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search meals');
      }
    } catch (e) {
      throw Exception('Error searching meals: $e');
    }
  }
}
