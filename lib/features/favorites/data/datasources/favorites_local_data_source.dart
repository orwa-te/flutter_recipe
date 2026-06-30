import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe/features/meals/data/models/meal_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<MealModel>> getFavorites();
  Future<void> toggleFavorite(MealModel meal);
  Future<bool> isFavorite(String mealId);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String favoritesKey = 'FAVORITE_MEALS';

  FavoritesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<MealModel>> getFavorites() async {
    final jsonList = sharedPreferences.getStringList(favoritesKey);
    if (jsonList == null) return [];
    
    return jsonList
        .map((item) => MealModel.fromJson(json.decode(item)))
        .toList();
  }

  @override
  Future<void> toggleFavorite(MealModel meal) async {
    final favorites = await getFavorites();
    final index = favorites.indexWhere((m) => m.id == meal.id);
    
    if (index >= 0) {
      favorites.removeAt(index);
    } else {
      favorites.add(meal);
    }
    
    final jsonList = favorites
        .map((meal) => json.encode(meal.toJson()))
        .toList();
    
    await sharedPreferences.setStringList(favoritesKey, jsonList);
  }

  @override
  Future<bool> isFavorite(String mealId) async {
    final favorites = await getFavorites();
    return favorites.any((m) => m.id == mealId);
  }
}
