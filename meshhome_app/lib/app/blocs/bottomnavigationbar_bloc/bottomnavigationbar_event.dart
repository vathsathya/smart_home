part of 'bottomnavigationbar_bloc.dart';

abstract class BottomnavigationbarEvent extends Equatable {
  const BottomnavigationbarEvent();
}

class LoadHomeScreen extends BottomnavigationbarEvent {
  @override
  List<Object> get props => [];
}

class LoadSceneScreen extends BottomnavigationbarEvent {
  @override
  List<Object> get props => [];
}

class LoadAutomationScreen extends BottomnavigationbarEvent {
  @override
  List<Object> get props => [];
}

class LoadAccountScreen extends BottomnavigationbarEvent {
  @override
  List<Object> get props => [];
}
