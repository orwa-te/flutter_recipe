

import 'package:recipe/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:recipe/features/categories/domain/entities/category.dart';
import 'package:recipe/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<RecipeCategory>> getCategories() async {
    try {
      return await remoteDataSource.getCategories();
    } catch (e) {
      // In a real app, you'd map the exception to a Failure
      // In a real app, you'd map the exception to a Failure
      rethrow;
    }
  }
}
