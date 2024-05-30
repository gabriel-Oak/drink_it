abstract class FailureGetCocktails implements Exception {
  final String? message;

  FailureGetCocktails({this.message});

  @override
  String toString() {
    return message ?? super.toString();
  }
}

class InvalidSearchError extends FailureGetCocktails {
  InvalidSearchError() : super();
}
