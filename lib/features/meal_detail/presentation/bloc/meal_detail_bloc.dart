import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/meal_detail/domain/usecases/get_meal_detail.dart';
import 'package:recipe/features/meal_detail/presentation/bloc/meal_detail_event.dart';
import 'package:recipe/features/meal_detail/presentation/bloc/meal_detail_state.dart';

class MealDetailBloc extends Bloc<MealDetailEvent, MealDetailState> {
  final GetMealDetail getMealDetail;

  MealDetailBloc({required this.getMealDetail}) : super(MealDetailInitial()) {
    on<LoadMealDetail>((event, emit) async {
      emit(MealDetailLoading());
      try {
        final meal = await getMealDetail(event.mealId);
        emit(MealDetailLoaded(meal));
      } catch (e) {
        emit(MealDetailError(e.toString()));
      }
    });
  }
}
