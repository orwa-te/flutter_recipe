import 'package:get_it/get_it.dart';
import '../core/network/dio_client.dart';
import '../features/categories/data/datasources/categories_remote_data_source.dart';
import '../features/categories/data/repositories/categories_repository_impl.dart';
import '../features/categories/domain/repositories/categories_repository.dart';
import '../features/categories/domain/usecases/get_categories.dart';
import '../features/categories/presentation/bloc/categories_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Categories
  // Bloc
  sl.registerFactory(() => CategoriesBloc(getCategories: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCategories(sl()));

  // Repository
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(dio: sl<DioClient>().dio),
  );

  // Core
  sl.registerLazySingleton(() => DioClient());
}
