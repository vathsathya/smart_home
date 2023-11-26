import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottomnavigationbar_event.dart';
part 'bottomnavigationbar_state.dart';

class BottomnavigationbarBloc
    extends Bloc<BottomnavigationbarEvent, BottomnavigationbarState> {
  int currentIndex = 0;

  BottomnavigationbarBloc() : super(HomeScreenState());

  BottomnavigationbarBloc get initialState => BottomnavigationbarBloc();

  @override
  Stream<BottomnavigationbarState> mapEventToState(
    BottomnavigationbarEvent event,
  ) async* {
    if ((event is LoadHomeScreen)) {
      yield HomeScreenState();
    }
    if (event is LoadSceneScreen) {
      yield SceneScreenState();
    }
    if (event is LoadAutomationScreen) {
      yield AutomationScreenState();
    }
    if (event is LoadAccountScreen) {
      yield AccountScreenState();
    }
  }
}
