import 'package:equatable/equatable.dart';
import 'package:recipe/features/meals/domain/entities/meal.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Meal> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

class FavoriteStatus extends FavoritesState {
  final bool isFavorite;

  const FavoriteStatus(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}
