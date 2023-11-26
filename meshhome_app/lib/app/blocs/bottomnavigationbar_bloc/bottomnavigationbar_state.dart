part of 'bottomnavigationbar_bloc.dart';

abstract class BottomnavigationbarState extends Equatable {
  BottomnavigationbarState();
}

class HomeScreenState extends BottomnavigationbarState {
  final int index = 0;
  final String title = 'Home';

  @override
  List<Object> get props => [index, title];
}

class SceneScreenState extends BottomnavigationbarState {
  final int index = 1;
  final String title = 'Scene';

  @override
  List<Object> get props => [index, title];
}

class AutomationScreenState extends BottomnavigationbarState {
  final int index = 2;
  final String title = 'Automation';

  @override
  List<Object> get props => [index, title];
}

class AccountScreenState extends BottomnavigationbarState {
  final int index = 3;
  final String title = 'Account';

  @override
  List<Object> get props => [index, title];
}
