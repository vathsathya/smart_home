part of 'device_bloc.dart';

abstract class DeviceEvent extends Equatable {
  DeviceEvent([List props = const []]);

  @override
  List<Object> get props => [props];

  @override
  bool get stringify => false;
}

class DeviceFetch extends DeviceEvent {
  @override
  String toString() => 'DeviceFetch Event';
}

class DeviceRefresh extends DeviceEvent {
  @override
  String toString() => 'DeviceRefresh Event';
}

class DeviceFilter extends DeviceEvent {
  @override
  String toString() => 'DeviceRefresh Event';
}
