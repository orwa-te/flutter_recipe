import 'package:equatable/equatable.dart';
import 'package:recipe/features/meals/domain/entities/meal.dart';

abstract class MealsState extends Equatable {
  const MealsState();

  @override
  List<Object> get props => [];
}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsLoaded extends MealsState {
  final List<Meal> meals;

  const MealsLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

class MealsError extends MealsState {
  final String message;

  const MealsError(this.message);

  @override
  List<Object> get props => [message];
}
