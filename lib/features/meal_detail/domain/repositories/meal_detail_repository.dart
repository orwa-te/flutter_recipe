import 'package:recipe/features/meal_detail/domain/entities/meal_detail.dart';

abstract class MealDetailRepository {
  Future<MealDetail> getMealDetail(String mealId);
}
