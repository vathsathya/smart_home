import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshhome_app/app/blocs/index.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceState>(
      builder: (context, state) {
        if (state is DeviceLoading) {
          return SliverFillRemaining(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        if (state is DeviceLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Text(state.devices[index].product.id);
            },
            itemCount: state.devices.length,
          );
        }
        return Text('Something went wrong!');
      },
    );
  }
}
