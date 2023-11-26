import 'dart:convert';

import 'models/models.dart';
import 'package:http/http.dart' as http;

class DeviceRepository {
  List<Device> devices;

  DeviceRepository() : super();

  Future<void> fetchData() async {
    List<Device> _devices = [];
    // simulate real data fetching
    String url =
        "http://io.meshtechkh.com:8080/user_products/5f10baa48978d50debc97295";
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InZhdGguc2F0aHlhQGdtYWlsLmNvbSIsInVzZXJJZCI6IjVmMTBiYWE0ODk3OGQ1MGRlYmM5NzI5NSIsImlhdCI6MTU5NTM2MjUzNCwiZXhwIjoxNjI2NDY2NTM0fQ.RE6EOU6hqCFXtmkmUZeHwYhy9jZN2l_C-B4M62XQifs',
    };

    await http.Client()
        .get(url, headers: headers)
        .timeout(const Duration(seconds: 5))
        .then((http.Response response) {
      if (response.statusCode >= 200 && response.statusCode < 400) {
        var responseBody = json.decode(utf8.decode(response.bodyBytes));
        for (var json in responseBody['products']) {
          _devices.add(new Device.fromJson(json));
        }
        devices = _devices;
      }
    }).catchError((error) {
      print(error);
    });
    // store dummy data
  }

  List<Device> get data => devices;
}
