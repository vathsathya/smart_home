import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:meshhome_app/app/blocs/index.dart';
import 'package:meshhome_app/app/ui_view/home/dashboard_ui.dart';

import 'ui_view/index.dart';
import 'widgets/bottom_app_bar.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final screens = <Widget>[
    DashboardUI(),
    Center(
        child: Text("ក្លូ",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 48,
            ))),
    Center(child: Text("Automation")),
    AccountScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProxyAnimation transitionAnimation =
      ProxyAnimation(kAlwaysDismissedAnimation);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomnavigationbarBloc, BottomnavigationbarState>(
      builder: (context, state) {
        if (state is HomeScreenState) {
          return _buildHomepage(currentIndex: state.index);
        }
        if (state is SceneScreenState) {
          return _buildHomepage(currentIndex: state.index);
        }
        if (state is AutomationScreenState) {
          return _buildHomepage(currentIndex: state.index);
        }
        if (state is AccountScreenState) {
          return _buildHomepage(currentIndex: state.index);
        }
        return Container();
      },
    );
  }

  Scaffold _buildHomepage({int currentIndex}) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue,
      body: Stack(
        children: <Widget>[
          PageStorage(
            bucket: bucket,
            child: screens[currentIndex],
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   isExtended: false,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   clipBehavior: Clip.antiAlias,
      //   child: Icon(
      //     AntDesign.plus,
      //     color: Theme.of(context).iconTheme.color,
      //     size: 30.0,
      //   ),
      //   elevation: 0.0,
      //   tooltip: 'Add device',
      //   disabledElevation: 0.0,
      //   highlightElevation: 0.0,
      //   splashColor: Theme.of(context).primaryColor,
      //   onPressed: () {
      //     print("Add object");
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        notchMargin: 6.0,
        clipBehavior: Clip.hardEdge,
        elevation: 2.0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        height: 75.0,
        color: Colors.blueGrey,
        iconSize: 30.0,
        notchedShape: Theme.of(context).bottomAppBarTheme.shape,
        selectedColor: Theme.of(context).indicatorColor,
        onTabSelected: (index) {
          if (index == 0) {
            return BlocProvider.of<BottomnavigationbarBloc>(context)
              ..add(LoadHomeScreen());
          }
          if (index == 1) {
            return BlocProvider.of<BottomnavigationbarBloc>(context)
              ..add(LoadSceneScreen());
          }
          if (index == 2) {
            return BlocProvider.of<BottomnavigationbarBloc>(context)
              ..add(LoadAutomationScreen());
          }
          if (index == 3) {
            return BlocProvider.of<BottomnavigationbarBloc>(context)
              ..add(LoadAccountScreen());
          }
          return BlocProvider.of<BottomnavigationbarBloc>(context)
            ..add(LoadHomeScreen());
        },
        items: [
          FABBottomAppBarItem(
            iconData: AntDesign.home,
            text: 'Home',
          ),
          FABBottomAppBarItem(
            iconData: AntDesign.bars,
            text: 'Scene',
          ),
          FABBottomAppBarItem(
            iconData: AntDesign.message1,
            text: 'News',
          ),
          FABBottomAppBarItem(
            iconData: AntDesign.user,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
