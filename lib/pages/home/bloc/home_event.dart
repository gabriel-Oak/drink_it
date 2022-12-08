abstract class HomeEvent {}

class SearchByIngredientEvent extends HomeEvent {
  final String ingredient;

  SearchByIngredientEvent(this.ingredient);
}

class SearchByCategoryEvent extends HomeEvent {
  final String category;

  SearchByCategoryEvent(this.category);
}

class SearchByAlcoholicEvent extends HomeEvent {
  final String alcoholic;

  SearchByAlcoholicEvent(this.alcoholic);
}
