import 'package:device_repository/device_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshhome_app/app/blocs/index.dart';
import 'package:meshhome_app/simple_bloc_observer.dart';
// import 'package:flutter/services.dart';

import 'app/app.dart';

// Login
import 'app/ui_view/auth/login_ui.dart';
import 'app/ui_view/auth/signup_ui.dart';
import 'app/ui_view/intro/intro.dart';
import 'app/ui_view/auth/splash.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([]);

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.blue,
  //   statusBarColor: Colors.blue,
  // ));

  runApp(MeshHomeApp());
}

class MeshHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeviceBloc>(
          lazy: true,
          create: (_) => DeviceBloc(deviceRepository: DeviceRepository())
            ..add(DeviceFetch()),
        ),
        BlocProvider<BottomnavigationbarBloc>(
          lazy: true,
          create: (_) => BottomnavigationbarBloc()..add(LoadHomeScreen()),
        ),
      ],
      child: MaterialApp(
        color: Colors.blue,
        theme: ThemeData(
          backgroundColor: Colors.white,
          canvasColor: Colors.grey[300],
          primaryColor: Colors.blue,
          accentColor: Colors.blueGrey,
          bottomAppBarColor: Colors.white,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.blue,
            elevation: 0.0,
            shape: CircularNotchedRectangle(),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          errorColor: Colors.red[700],
          indicatorColor: Colors.blue,
          disabledColor: Colors.blueGrey,
        ),
        debugShowCheckedModeBanner: false,
        title: 'MeshHome App',
        initialRoute: '/signup',
        routes: {
          // '/': (context) => AppScreen(),
          // '/intro': (context) => IntroScreen(),
          // '/splash': (context) => SplashScreen(),
          '/signup': (context) => SignUPScreen(),
          // '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
