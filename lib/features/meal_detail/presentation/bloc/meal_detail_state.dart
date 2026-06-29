import 'package:equatable/equatable.dart';
import 'package:recipe/features/meal_detail/domain/entities/meal_detail.dart';

abstract class MealDetailState extends Equatable {
  const MealDetailState();

  @override
  List<Object> get props => [];
}

class MealDetailInitial extends MealDetailState {}

class MealDetailLoading extends MealDetailState {}

class MealDetailLoaded extends MealDetailState {
  final MealDetail meal;

  const MealDetailLoaded(this.meal);

  @override
  List<Object> get props => [meal];
}

class MealDetailError extends MealDetailState {
  final String message;

  const MealDetailError(this.message);

  @override
  List<Object> get props => [message];
}
