class Ingredient {
  final String? id;
  final String name;

  Ingredient({required this.name, this.id});

  Map<String, String?> toMap() => {"id": id, "name": name};
}
