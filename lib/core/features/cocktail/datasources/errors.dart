import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';

class DatasourceError extends FailureGetCocktails {
  final String? metadata;
  DatasourceError({
    this.metadata,
    super.message =
        'Sorry, something wen wrong searching for your cocktails, stay sober :(',
  });
}

class CocktailInvalidSearchError extends DatasourceError {
  CocktailInvalidSearchError({super.metadata})
      : super(message: 'Oops, you need to specify a filter!');
}

class CocktailConnectionError extends DatasourceError {
  CocktailConnectionError({super.metadata})
      : super(message: 'Oh my, we have an error contacting our service :/');
}
