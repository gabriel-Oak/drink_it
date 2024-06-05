abstract class MainEvent {}

class ChangeMainPage extends MainEvent {
  final int newPageIndex;

  ChangeMainPage({required this.newPageIndex});
}
