import 'package:recipe/features/meal_detail/domain/entities/meal_detail.dart';
import 'package:recipe/features/meal_detail/domain/repositories/meal_detail_repository.dart';

class GetMealDetail {
  final MealDetailRepository repository;

  GetMealDetail(this.repository);

  Future<MealDetail> call(String mealId) async {
    return await repository.getMealDetail(mealId);
  }
}
