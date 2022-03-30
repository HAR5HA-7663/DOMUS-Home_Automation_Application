import 'dart:convert';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:Domus/app/data/models/adafruit_get.dart';
import 'package:http/http.dart' as http;

class TempHumidAPI {
  static String username = 'HAR5HA';
  static String? aioKey = 'aio_duBA06ohOw5KzLRkneRoR1YBZi7I';
  static String tempFeed = 'temperature';
  static String humidFeed = 'humidity';
  static String led1Feed = 'led-1';
  static String led2Feed = 'led-2';
  static String socketFeed = 'socket';
  static String rgbFeed = 'color';
  static String mainURL = 'https://io.adafruit.com/api/v2/';

  static Future<AdafruitGET> getTempData() async {
    http.Response response = await http.get(
      Uri.parse(mainURL + '$username/feeds/$tempFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<AdafruitGET> getHumidData() async {
    http.Response response = await http.get(
      Uri.parse(mainURL + '$username/feeds/$humidFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<AdafruitGET> getLed1Data() async {
    http.Response response = await http.get(
      Uri.parse(mainURL + '$username/feeds/$led1Feed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateLed1Data(String value) async {
    http.Response response = await http.post(
      Uri.parse(mainURL + '$username/feeds/$led1Feed/data'),
      headers: <String, String>{
        'X-AIO-Key': aioKey!,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "datum": {"value": value}
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Error();
    }
  }

  static Future<AdafruitGET> getLed2Data() async {
    http.Response response = await http.get(
      Uri.parse(mainURL + '$username/feeds/$led2Feed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateLed2Data(String value) async {
    http.Response response = await http.post(
      Uri.parse(mainURL + '$username/feeds/$led2Feed/data'),
      headers: <String, String>{
        'X-AIO-Key': aioKey!,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "datum": {"value": value}
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Error();
    }
  }

  static Future<AdafruitGET> getsocketData() async {
    http.Response response = await http.get(
      Uri.parse(mainURL + '$username/feeds/$socketFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updatesocketData(String value) async {
    http.Response response = await http.post(
      Uri.parse(mainURL + '$username/feeds/$socketFeed/data'),
      headers: <String, String>{
        'X-AIO-Key': aioKey!,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "datum": {"value": value}
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Error();
    }
  }

  static Future<AdafruitGET> getRGBstatus() async {
    http.Response response = await http.get(
      Uri.parse(mainURL + '$username/feeds/$rgbFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateRGBdata(String value) async {
    http.Response response = await http.post(
      Uri.parse(mainURL + '$username/feeds/$rgbFeed/data'),
      headers: <String, String>{
        'X-AIO-Key': aioKey!,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "datum": {"value": value}
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Error();
    }
  }
}
