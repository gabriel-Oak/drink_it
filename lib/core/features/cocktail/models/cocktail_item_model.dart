class CocktailItem {
  final String id;
  final String name;
  final String thumb;

  CocktailItem({required this.id, required this.name, required this.thumb});

  static CocktailItem fromMap(Map<String, dynamic> map) {
    return CocktailItem(
      id: map['idDrink'],
      name: map['strDrink'],
      thumb: map['strDrinkThumb'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'thumb': thumb,
    };
  }
}
