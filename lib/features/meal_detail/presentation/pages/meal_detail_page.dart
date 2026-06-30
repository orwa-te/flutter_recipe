import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/app/injection_container.dart';
import 'package:recipe/features/meals/domain/entities/meal.dart';
import 'package:recipe/features/meal_detail/presentation/bloc/meal_detail_bloc.dart';
import 'package:recipe/features/meal_detail/presentation/bloc/meal_detail_event.dart';
import 'package:recipe/features/meal_detail/presentation/bloc/meal_detail_state.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_state.dart';

class MealDetailPage extends StatelessWidget {
  final String mealId;
  final String mealName;

  const MealDetailPage({
    super.key,
    required this.mealId,
    required this.mealName,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<MealDetailBloc>()..add(LoadMealDetail(mealId)),
        ),
        BlocProvider(
          create: (_) => sl<FavoritesBloc>()..add(CheckFavoriteStatus(mealId)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(mealName),
          actions: [
            BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                bool isFavorite = false;
                if (state is FavoriteStatus) {
                  isFavorite = state.isFavorite;
                }
                
                return BlocBuilder<MealDetailBloc, MealDetailState>(
                  builder: (context, detailState) {
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: detailState is MealDetailLoaded
                          ? () {
                              final meal = Meal(
                                id: detailState.meal.id,
                                name: detailState.meal.name,
                                thumbnail: detailState.meal.thumbnail,
                              );
                              context
                                  .read<FavoritesBloc>()
                                  .add(ToggleFavoriteEvent(meal));
                            }
                          : null,
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<MealDetailBloc, MealDetailState>(
          builder: (context, state) {
            if (state is MealDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MealDetailLoaded) {
              final meal = state.meal;
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        meal.thumbnail,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        meal.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${meal.category} | ${meal.area}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: meal.ingredients.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              '• ${meal.ingredients[index]}: ${meal.measures[index]}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        meal.instructions,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is MealDetailError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
