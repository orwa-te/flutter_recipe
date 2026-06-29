import 'package:recipe/features/meal_detail/data/datasources/meal_detail_remote_data_source.dart';
import 'package:recipe/features/meal_detail/domain/entities/meal_detail.dart';
import 'package:recipe/features/meal_detail/domain/repositories/meal_detail_repository.dart';

class MealDetailRepositoryImpl implements MealDetailRepository {
  final MealDetailRemoteDataSource remoteDataSource;

  MealDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MealDetail> getMealDetail(String mealId) async {
    return await remoteDataSource.getMealDetail(mealId);
  }
}
