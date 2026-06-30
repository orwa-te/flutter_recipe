import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/app/injection_container.dart';
import 'package:recipe/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:recipe/features/categories/presentation/bloc/categories_event.dart';
import 'package:recipe/features/categories/presentation/bloc/categories_state.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:recipe/features/meals/presentation/pages/meals_page.dart';
import 'package:recipe/features/meals/presentation/widgets/meal_search_delegate.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:recipe/features/favorites/presentation/pages/favorites_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<CategoriesBloc>()..add(LoadCategories()),
        ),
        BlocProvider(
          create: (_) => sl<MealsBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<FavoritesBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recipe Categories'),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    final favoritesBloc = context.read<FavoritesBloc>();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: favoritesBloc..add(LoadFavorites()),
                          child: const FavoritesPage(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MealSearchDelegate(context.read<MealsBloc>()),
                  );
                },
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoriesLoaded) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MealsPage(categoryName: category.name),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                category.thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is CategoriesError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('Start exploring!'));
            },
          ),
        ),
      ),
    );
  }
}
