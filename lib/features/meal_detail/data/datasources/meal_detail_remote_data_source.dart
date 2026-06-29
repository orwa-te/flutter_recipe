import 'package:dio/dio.dart';
import 'package:recipe/core/network/api_constants.dart';
import 'package:recipe/features/meal_detail/data/models/meal_detail_model.dart';

abstract class MealDetailRemoteDataSource {
  Future<MealDetailModel> getMealDetail(String mealId);
}

class MealDetailRemoteDataSourceImpl implements MealDetailRemoteDataSource {
  final Dio dio;

  MealDetailRemoteDataSourceImpl({required this.dio});

  @override
  Future<MealDetailModel> getMealDetail(String mealId) async {
    try {
      final response = await dio.get('${ApiConstants.lookupRecipe}$mealId');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['meals'];
        if (data.isNotEmpty) {
          return MealDetailModel.fromJson(data[0]);
        } else {
          throw Exception('Meal not found');
        }
      } else {
        throw Exception('Failed to load meal details');
      }
    } catch (e) {
      throw Exception('Error fetching meal details: $e');
    }
  }
}
