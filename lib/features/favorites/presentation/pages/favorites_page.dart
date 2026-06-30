import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:recipe/features/meal_detail/presentation/pages/meal_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Meals')),
      body: SafeArea(
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return const Center(child: Text('No favorites yet.'));
              }
              return ListView.builder(
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final meal = state.favorites[index];
                  return ListTile(
                    leading: Image.network(
                      meal.thumbnail,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(meal.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealDetailPage(
                            mealId: meal.id,
                            mealName: meal.name,
                          ),
                        ),
                      ).then((_) {
                        // Refresh when coming back
                        context.read<FavoritesBloc>().add(LoadFavorites());
                      });
                    },
                  );
                },
              );
            } else if (state is FavoritesError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
