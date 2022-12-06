import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';

abstract class LookupRandom {
  Future<Cocktail> call();
}

class LookupRandomImpl extends LookupRandom {}
