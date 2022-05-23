import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Domus/app/data/models/adafruit_get.dart';
import 'package:Domus/app/data/models/room_model.dart';
import 'package:Domus/app/data/provider/TempHumidAPI.dart';
import 'package:Domus/app/modules/connected_device/views/connected_device_view.dart';
import 'package:Domus/app/modules/home/views/dashboard_view.dart';
import 'package:Domus/app/modules/home/views/settings_view.dart';

class HomeController extends GetxController {
  // bottom nav current index.
  final box = GetStorage();
  RxInt _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;

  // userData
  // String userName = box.read("username");
  bool isMale = true;

  // List of bools for selected room
  List<bool> selectedRoom = [true, false, false, false, false];

  // the list of screens switched by bottom navBar
  final List<Widget> homeViews = [
    DashboardView(),
    ConnectedDeviceView(),
    SettingsView(),
  ];

  // List of room data
  List<Room> rooms = [
    Room(roomName: 'Living Room', roomImgUrl: 'assets/icons/sofa.svg'),
    Room(roomName: 'Dining Room', roomImgUrl: 'assets/icons/chair.svg'),
    Room(roomName: 'Bedroom', roomImgUrl: 'assets/icons/bed.svg'),
    Room(roomName: 'Kitchen', roomImgUrl: 'assets/icons/kitchen.svg'),
    Room(roomName: 'Bathroom', roomImgUrl: 'assets/icons/bathtub.svg'),
  ];

  List<bool> isToggled = [false, false, false, false];

  // AdafruitGET & AdafruitGET from sensor;
  late StreamController<AdafruitGET> tempStream;
  late StreamController<AdafruitGET> humidStream;

  // store current color from adafruit IO
  RxString currentRGB = "0xffffff".obs;
  RxString newRGB = "".obs;

  // funtion to set current index
  setCurrentIndex(int index) {
    _currentIndex.value = index;
    if (index == 1 || index == 2) {
      tempStream.close();
      humidStream.close();
    } else if (index == 0) {
      streamInit();
    }
  }

  // function to return correct view on bottom navBar switch
  Widget navBarSwitcher() {
    return homeViews.elementAt(currentIndex);
  }

  // function to move between each room
  void roomChange(int index) {
    selectedRoom = [false, false, false, false, false];
    selectedRoom[index] = true;
    update([1, true]);
  }

  // switches in the room
  onSwitched(int index) {
    isToggled[index] = !isToggled[index];
    if (index == 0) {
      var value = isToggled[index] ? "1" : "0";
      TempHumidAPI.updateLed1Data(value);
    }
    if (index == 1) {
      var value = isToggled[index] ? "#ffffff" : "#000000";
      TempHumidAPI.updateRGBdata(value);
    }
    if (index == 2) {
      var value = isToggled[index] ? "1" : "0";
      TempHumidAPI.updatesocketData(value);
    }
    if (index == 3) {
      var value = isToggled[index] ? "1" : "0";
      TempHumidAPI.updateLed2Data(value);
    }
    update([2, true]);
  }

  // function to retreve sensor data
  retreveSensorData() async {
    // AdafruitGET temperature data fetch
    AdafruitGET temper = await TempHumidAPI.getTempData();
    tempStream.add(temper);

    // AdafruitGET humidity data fetch
    AdafruitGET humid = await TempHumidAPI.getHumidData();
    humidStream.add(humid);
  }

  getSmartSystemStatus() async {
    var data1 = await TempHumidAPI.getLed1Data();
    var data2 = await TempHumidAPI.getsocketData();
    var data3 = await TempHumidAPI.getLed2Data();
    var rgbData = await TempHumidAPI.getRGBstatus();
    currentRGB.value = rgbData.lastValue!;
    var value1 = int.parse(data1.lastValue!);
    var value2 = int.parse(data2.lastValue!);
    var value3 = int.parse(data3.lastValue!);
    if (value1 == 1) {
      isToggled[0] = true;
    } else if (value1 == 0) {
      isToggled[0] = false;
    }
    if (rgbData.lastValue?.compareTo("#000000") == 0) {
      isToggled[1] = false;
    } else {
      isToggled[1] = true;
    }
    if (value2 == 1) {
      isToggled[2] = true;
    } else if (value2 == 0) {
      isToggled[2] = false;
    }
    if (value3 == 1) {
      isToggled[3] = true;
    } else if (value3 == 0) {
      isToggled[3] = false;
    }
    update([2, true]);
  }

  sendRGBColor(String hex) {
    TempHumidAPI.updateRGBdata(hex);
  }

  streamInit() {
    tempStream = StreamController();
    humidStream = StreamController();
    Timer.periodic(
      Duration(seconds: 3),
      (_) {
        getSmartSystemStatus();
        retreveSensorData();
      },
    );
  }

  @override
  void onInit() {
    streamInit();
    newRGB = currentRGB;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tempStream.close();
    humidStream.close();
  }
}
