import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_event.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_state.dart';
import 'package:recipe/features/meal_detail/presentation/pages/meal_detail_page.dart';

class MealSearchDelegate extends SearchDelegate {
  final MealsBloc mealsBloc;

  MealSearchDelegate(this.mealsBloc);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    mealsBloc.add(SearchMealsEvent(query));

    return BlocBuilder<MealsBloc, MealsState>(
      bloc: mealsBloc,
      builder: (context, state) {
        if (state is MealsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MealsLoaded) {
          if (state.meals.isEmpty) {
            return const Center(child: Text('No meals found.'));
          }
          return ListView.builder(
            itemCount: state.meals.length,
            itemBuilder: (context, index) {
              final meal = state.meals[index];
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
                  );
                },
              );
            },
          );
        } else if (state is MealsError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Search for your favorite meal!'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Search for your favorite meal!'));
  }
}
