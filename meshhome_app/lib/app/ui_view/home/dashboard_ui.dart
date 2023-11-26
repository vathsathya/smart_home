import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:meshhome_app/app/blocs/index.dart';

import 'package:meshhome_app/app/ui_view/home/widgets/index.dart';

class DashboardUI extends StatefulWidget {
  @override
  _DashboardUIState createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int countDevices = 0;
  int countOffline = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Cana Computer',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              AntDesign.pluscircle,
              semanticLabel: 'Add device',
            ),
            color: Colors.white,
            iconSize: 35.0,
            onPressed: () {},
          ),
        ],
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      drawerDragStartBehavior: DragStartBehavior.start,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        semanticsLabel: 'Refresh data',
        onRefresh: () async {
          BlocProvider.of<DeviceBloc>(context)..add(DeviceRefresh());
        },
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            HeaderScreen(),
            ShowDeviceList(),
          ],
        ),
      ),
    );
  }
}
