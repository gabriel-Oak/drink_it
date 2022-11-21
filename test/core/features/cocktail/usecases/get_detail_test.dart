import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final usecase = GetDetailImpl();

  test('Should get a cocktail details', () async {
    final result = await usecase('73478');
    expect(result.fold(id, id), isA<Cocktail>());
  });
}
