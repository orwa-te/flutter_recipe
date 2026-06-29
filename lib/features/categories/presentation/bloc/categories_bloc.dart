import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/categories/domain/usecases/get_categories.dart';
import 'package:recipe/features/categories/presentation/bloc/categories_event.dart';
import 'package:recipe/features/categories/presentation/bloc/categories_state.dart';



class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;

  CategoriesBloc({required this.getCategories}) : super(CategoriesInitial()) {

    on<LoadCategories>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final categories = await getCategories();
        emit(CategoriesLoaded(categories));
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });
  }
}
