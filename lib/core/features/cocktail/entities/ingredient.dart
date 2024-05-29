import 'package:drink_it/core/utils/json_codable.dart';

class Ingredient implements JsonCodable {
  final String id;
  final String name;

  Ingredient({required this.id, required this.name});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Ingredient fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
    );
  }
}
