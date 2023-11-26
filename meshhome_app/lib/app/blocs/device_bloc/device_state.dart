part of 'device_bloc.dart';

@immutable
abstract class DeviceState extends Equatable {
  DeviceState([List props = const []]);
}

class DeviceLoading extends DeviceState {
  @override
  List<Object> get props => [];
}

class DeviceLoaded extends DeviceState {
  final List<Device> devices;

  DeviceLoaded({@required this.devices}) : super([devices]);

  @override
  List<Object> get props => [devices];
}

class DeviceError extends DeviceState {
  @override
  List<Object> get props => [];
}
