import 'package:drink_it/pages/detail/bloc/detail_event.dart';
import 'package:drink_it/pages/detail/bloc/detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailState()) {
    on<DetailStarted>((event, emit) {
      emit(DetailLoaded(cocktail: event.cocktail));
    });
  }
}
