import 'dart:async';
import 'package:device_repository/device_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Loading

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository deviceRepository;
  final String filter;

  DeviceBloc({@required this.deviceRepository, this.filter})
      : super(DeviceLoading());

  @override
  Stream<DeviceState> mapEventToState(DeviceEvent event) async* {
    if (event is DeviceFetch) {
      List<Device> data = await _getDeviceData();
      yield DeviceLoaded(devices: data);
    }
    if (event is DeviceRefresh) {
      List<Device> data = await _refreshDeviceData();
      yield DeviceLoaded(devices: data);
    }
    if (event is DeviceFilter) {
      List<Device> data = await _filterDeviceData(this.filter);
      yield DeviceLoaded(devices: data);
    }
  }

  Future<List<Device>> _getDeviceData() async {
    List<Device> data = this.deviceRepository.data;
    if (data == null) {
      await this.deviceRepository.fetchData();
      data = this.deviceRepository.data;
    }
    return data;
  }

  Future<List<Device>> _refreshDeviceData() async {
    List<Device> data = [];
    await this.deviceRepository.fetchData();
    data = this.deviceRepository.data;
    return data;
  }

  Future<List<Device>> _filterDeviceData(String str) async {
    List<Device> data = [];
    await this.deviceRepository.fetchData();
    data = this.deviceRepository.data;
    return data;
  }
}
