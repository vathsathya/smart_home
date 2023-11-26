import 'package:device_repository/device_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:meshhome_app/app/blocs/index.dart';

class FavoriteDevice extends StatefulWidget {
  @override
  _FavoriteDeviceState createState() => _FavoriteDeviceState();
}

class _FavoriteDeviceState extends State<FavoriteDevice> {
  DeviceBloc _deviceBloc;
  List<Device> devices = [];
  @override
  void initState() {
    super.initState();
    _deviceBloc = BlocProvider.of<DeviceBloc>(context);
    _getFavorite();
  }

  @override
  void dispose() {
    _deviceBloc.close();
    super.dispose();
  }

  _getFavorite() async {
    List<Device> _devices = [];
    List<Device> _data = _deviceBloc.deviceRepository.data;

    print(_data);
    if (_data != null) {
      if (_data.length > 0) {
        for (var d in _data) {
          if (d.isFavorite) {
            _devices.add(d);
          }
        }
        setState(() {
          devices = _devices;
        });
        print(_devices);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Favorite',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    devices.length > 0
                        ? IconButton(
                            icon: Icon(AntDesign.reload1),
                            color: Colors.blueGrey,
                            onPressed: () {
                              _deviceBloc.add(DeviceRefresh());
                            },
                          )
                        : IconButton(
                            icon: Icon(AntDesign.ellipsis1),
                            color: Colors.blueGrey,
                            onPressed: () {
                              print('some options');
                            },
                          ),
                  ],
                ),
              ),
            ),
            devices.length > 0
                ? Container(
                    height: 136.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(
                                color: Colors.blueGrey[50],
                                width: 1,
                              ),
                            ),
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(Ionicons.ios_switch,
                                          size: 35,
                                          semanticLabel: "Text",
                                          color: Colors.blue),
                                      Text(
                                        'ON',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          devices[index].product.info.type,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          devices[index].product.info.name ==
                                                  null
                                              ? devices[index]
                                                  .product
                                                  .serialNumber
                                              : devices[index]
                                                  .product
                                                  .info
                                                  .name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'No favorite devices',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
