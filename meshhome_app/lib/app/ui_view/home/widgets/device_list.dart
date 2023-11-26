import 'package:device_repository/device_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:meshhome_app/app/blocs/index.dart';

class ShowDeviceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      // decoration: BoxDecoration(
      //   color: Colors.grey[50],
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(30),
      //     topRight: Radius.circular(30),
      //   ),
      // ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'My Devices ',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(AntDesign.reload1),
                  color: Colors.blueGrey,
                  onPressed: () {
                    BlocProvider.of<DeviceBloc>(context).add(DeviceRefresh());
                  },
                ),
                IconButton(
                  icon: Icon(AntDesign.ellipsis1),
                  color: Colors.blueGrey,
                  onPressed: () {},
                )
              ],
            ),
          ),
          BlocBuilder<DeviceBloc, DeviceState>(
            builder: (context, state) {
              if (state is DeviceLoading) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ],
                );
              }
              if (state is DeviceLoaded) {
                List<Device> devices = state?.devices;
                if (devices == null || devices.length == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Image.asset("assets/images/empty_data.png"),
                      ),
                    ],
                  );
                }
                return GridView.builder(
                  scrollDirection: Axis.vertical,
                  // controller: _controller,
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 2
                        : 4,
                  ),
                  itemCount: devices.length,
                  itemBuilder: (_, index) => _buildDevice(devices[index]),
                );
              }
              return Text('Something went wrong!');
            },
          )
        ],
      ),
    );
  }

  Widget _buildDevice(Device device) {
    return GestureDetector(
      onTap: () async {
        print('test');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 3.0,
          vertical: 3.0,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(27),
              ),
              border: Border.all(
                color: Colors.blueGrey[50],
                width: 1,
              )

              // boxShadow: [
              //   BoxShadow(
              //     offset: Offset(0, 5),
              //     color: Colors.grey[100],
              //     spreadRadius: 1.0,
              //     blurRadius: 5,
              //   ),
              // ],
              ),
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Ionicons.ios_switch,
                      size: 45,
                      semanticLabel: "Text",
                      color: Colors.blue,
                    ),
                    Icon(
                      AntDesign.cloudo,
                      color: device.product.status == 'online'
                          ? Colors.blue
                          : Colors.grey[300],
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
                        device.product.info.type,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
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
                        device.product.info.name == null
                            ? device.product.serialNumber
                            : device.product.info.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black45,
                          fontWeight: FontWeight.w300,
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
                      height: 30,
                      child: ListView.separated(
                        separatorBuilder: (_, __) => SizedBox(width: 5),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: device.product.channels.length,
                        itemBuilder: (_, index) => SizedBox(
                          width: 30,
                          child: InkWell(
                            splashColor: Colors.green,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: device.product.channels[index].value ==
                                          'off'
                                      ? Colors.grey[100]
                                      : Colors.blue[400],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.power_settings_new,
                                  color: device.product.channels[index].value ==
                                          'off'
                                      ? Colors.grey[100]
                                      : Colors.blue[400],
                                ),
                              ),
                            ),
                            onTap: () async {
                              print('you tab the power button');
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
