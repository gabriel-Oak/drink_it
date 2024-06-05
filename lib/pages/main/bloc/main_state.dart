import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int pageIndex;

  MainState({required this.pageIndex});

  MainState copyWith({int? pageIndex}) =>
      MainState(pageIndex: pageIndex ?? this.pageIndex);

  @override
  // TODO: implement props
  List<Object?> get props => [pageIndex];
}
