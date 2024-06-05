import 'package:drink_it/pages/main/bloc/main_event.dart';
import 'package:drink_it/pages/main/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(pageIndex: 0)) {
    on<ChangeMainPage>(_handleChangePage);
  }

  _handleChangePage(ChangeMainPage event, Emitter<MainState> emit) {
    if (event.newPageIndex != state.pageIndex) {
      emit(state.copyWith(pageIndex: event.newPageIndex));
    }
  }
}
