import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/app/injection_container.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_event.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_state.dart';
import 'package:recipe/features/meal_detail/presentation/pages/meal_detail_page.dart';

class MealsPage extends StatelessWidget {
  final String categoryName;

  const MealsPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MealsBloc>()..add(LoadMealsByCategory(categoryName)),
      child: Scaffold(
        appBar: AppBar(title: Text('$categoryName Meals')),
        body: BlocBuilder<MealsBloc, MealsState>(
          builder: (context, state) {
            if (state is MealsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MealsLoaded) {
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
            return const Center(child: Text('No meals found.'));
          },
        ),
      ),
    );
  }
}
