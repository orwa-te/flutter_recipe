import 'package:equatable/equatable.dart';

abstract class MealsEvent extends Equatable {
  const MealsEvent();

  @override
  List<Object> get props => [];
}

class LoadMealsByCategory extends MealsEvent {
  final String categoryName;

  const LoadMealsByCategory(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}

class SearchMealsEvent extends MealsEvent {
  final String query;

  const SearchMealsEvent(this.query);

  @override
  List<Object> get props => [query];
}
