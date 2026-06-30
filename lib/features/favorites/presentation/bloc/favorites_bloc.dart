import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/favorites/domain/usecases/get_favorites.dart';
import 'package:recipe/features/favorites/domain/usecases/is_favorite.dart';
import 'package:recipe/features/favorites/domain/usecases/toggle_favorite.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavorites getFavorites;
  final ToggleFavorite toggleFavorite;
  final IsFavorite isFavorite;

  FavoritesBloc({
    required this.getFavorites,
    required this.toggleFavorite,
    required this.isFavorite,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final favorites = await getFavorites();
        emit(FavoritesLoaded(favorites));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      try {
        await toggleFavorite(event.meal);
        final status = await isFavorite(event.meal.id);
        emit(FavoriteStatus(status));
        // After toggling, we might want to refresh the list if we are on the favorites page
        add(LoadFavorites());
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });

    on<CheckFavoriteStatus>((event, emit) async {
      try {
        final status = await isFavorite(event.mealId);
        emit(FavoriteStatus(status));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });
  }
}
