import 'package:dio/dio.dart';
import 'package:recipe/core/network/api_constants.dart';
import 'package:recipe/features/meals/data/models/meal_model.dart';

abstract class MealsRemoteDataSource {
  Future<List<MealModel>> getMealsByCategory(String categoryName);
}

class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final Dio dio;

  MealsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MealModel>> getMealsByCategory(String categoryName) async {
    try {
      final response = await dio.get('${ApiConstants.filterByCategory}$categoryName');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['meals'];
        return data.map((json) => MealModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Error fetching meals: $e');
    }
  }
}
