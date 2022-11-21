class Cocktail {
  final String id;
  final String name;
  final String thumb;

  Cocktail({
    required this.id,
    required this.name,
    required this.thumb,
  });

  static Cocktail fromMap(Map<String, dynamic> map) {
    return Cocktail(
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
