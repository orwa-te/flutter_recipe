import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/meals/domain/usecases/get_meals_by_category.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_event.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final GetMealsByCategory getMealsByCategory;

  MealsBloc({required this.getMealsByCategory}) : super(MealsInitial()) {
    on<LoadMealsByCategory>((event, emit) async {
      emit(MealsLoading());
      try {
        final meals = await getMealsByCategory(event.categoryName);
        emit(MealsLoaded(meals));
      } catch (e) {
        emit(MealsError(e.toString()));
      }
    });
  }
}
