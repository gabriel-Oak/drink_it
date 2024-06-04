import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/pages/detail/bloc/detail_event.dart';
import 'package:drink_it/pages/detail/bloc/detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetails getDetails;

  DetailBloc({required this.getDetails}) : super(DetailInitialState()) {
    on<DetailStarted>(_handleDetailStarted);
  }

  _handleDetailStarted(DetailStarted event, Emitter<DetailState> emit) async {
    emit(DetailLoading(cocktail: event.cocktail));
    final response = (await getDetails(event.cocktail.id)).fold(id, id);
    if (response is CocktailV2) return emit(DetailLoaded(cocktail: response));
    return emit(DetailLoadingFailed(
      cocktail: event.cocktail,
      message: (response as FailureGetCocktails).message!,
    ));
  }
}
