import 'package:get_it/get_it.dart';
import 'package:recipe/core/network/dio_client.dart';
import 'package:recipe/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:recipe/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:recipe/features/categories/domain/repositories/categories_repository.dart';
import 'package:recipe/features/categories/domain/usecases/get_categories.dart';
import 'package:recipe/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:recipe/features/meals/data/datasources/meals_remote_data_source.dart';
import 'package:recipe/features/meals/data/repositories/meals_repository_impl.dart';
import 'package:recipe/features/meals/domain/repositories/meals_repository.dart';
import 'package:recipe/features/meals/domain/usecases/get_meals_by_category.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:recipe/features/meal_detail/data/datasources/meal_detail_remote_data_source.dart';
import 'package:recipe/features/meal_detail/data/repositories/meal_detail_repository_impl.dart';
import 'package:recipe/features/meal_detail/domain/repositories/meal_detail_repository.dart';
import 'package:recipe/features/meal_detail/domain/usecases/get_meal_detail.dart';
import 'package:recipe/features/meal_detail/presentation/bloc/meal_detail_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Features - Categories
  // Bloc
  sl.registerFactory(() => CategoriesBloc(getCategories: sl()));

  // Use cases
  sl.registerLazySingleton<GetCategories>(() => GetCategories(sl()));

  // Repository
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  // Features - Meals
  // Bloc
  sl.registerFactory(() => MealsBloc(getMealsByCategory: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetMealsByCategory(sl()));

  // Repository
  sl.registerLazySingleton<MealsRepository>(
    () => MealsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MealsRemoteDataSource>(
    () => MealsRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  // Features - Meal Detail
  // Bloc
  sl.registerFactory(() => MealDetailBloc(getMealDetail: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetMealDetail(sl()));

  // Repository
  sl.registerLazySingleton<MealDetailRepository>(
    () => MealDetailRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MealDetailRemoteDataSource>(
    () => MealDetailRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  // Core
  sl.registerLazySingleton(() => DioClient());
}
