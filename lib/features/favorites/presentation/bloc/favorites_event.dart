import 'package:equatable/equatable.dart';
import 'package:recipe/features/meals/domain/entities/meal.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavoriteEvent extends FavoritesEvent {
  final Meal meal;

  const ToggleFavoriteEvent(this.meal);

  @override
  List<Object> get props => [meal];
}

class CheckFavoriteStatus extends FavoritesEvent {
  final String mealId;

  const CheckFavoriteStatus(this.mealId);

  @override
  List<Object> get props => [mealId];
}
