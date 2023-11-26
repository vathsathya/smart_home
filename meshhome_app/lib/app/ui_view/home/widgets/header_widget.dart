import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import 'room_widget.dart';
import 'favorite_widget.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class HeaderScreen extends StatefulWidget {
  @override
  _HeaderScreenState createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double lat, lon;
  String _currentCity;
  String _currentCountry;
  String _temperature;
  String _cloud;

  @override
  void initState() {
    super.initState();
    ws = new WeatherFactory(key);
    queryWeather();
  }

  Future<void> queryPosition() async {
    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      locationPermissionLevel: GeolocationPermission.locationWhenInUse,
    );
    setState(() {
      _state = AppState.DOWNLOADING;
      lat = position.latitude;
      lon = position.longitude;
    });
  }

  void queryWeather() async {
    await queryPosition();
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(lat, lon);

      Placemark place = p[0];

      // print("${place.locality}, ${place.postalCode}, ${place.country}");
      setState(() {
        _currentCity = place.locality;
        _currentCountry = place.country;
      });
      print(lat);
      if (lat > 0 && lon > 0) {
        Weather weather = await ws.currentWeatherByLocation(lat, lon);
        setState(() {
          _data = [weather];
          _temperature = weather.temperature.toString().trim().substring(0, 5);
          _cloud = weather.weatherMain.toString();
          _state = AppState.FINISHED_DOWNLOADING;
        });
        print(' Weather: ${weather.toString()}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.blue,
        // gradient: new LinearGradient(
        //   colors: [
        //     Colors.blue.withOpacity(1.0),
        //     Colors.blue.withOpacity(1.0),
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   // tileMode: TileMode.clamp,
        //   stops: [0.0, 0.5],
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              // Container(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 30.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         Text(
              //           'Cana Computer',
              //           style: TextStyle(
              //             fontSize: 24,
              //             color: Colors.white,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //         SizedBox(
              //           width: 6.0,
              //         ),
              //         Icon(
              //           AntDesign.down,
              //           color: Colors.white,
              //           semanticLabel: 'Home dropdown',
              //           size: 20.0,
              //         ),
              //         Spacer(),
              //         IconButton(
              //           icon: Icon(
              //             AntDesign.pluscircle,
              //             semanticLabel: 'Add device',
              //           ),
              //           color: Colors.white,
              //           iconSize: 35.0,
              //           onPressed: () {},
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // Degree
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  MaterialCommunityIcons
                                      .weather_lightning_rainy,
                                  color: Colors.white,
                                  size: 60.0,
                                ),
                                Text(
                                  '$_cloud',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _temperature ?? '',
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Text(
                                  '$_currentCity,\n $_currentCountry',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Home is safe!',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          FavoriteDevice(),
          RoomSelector(),
        ],
      ),
    );
  }
}
