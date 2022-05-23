import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class SettingsView extends GetView {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    String name;
    if (box.read('name') == null) {
      box.write('name', 'name');
    }
    String username;
    if (box.read('username') == null) {
      box.write('username', 'username');
    }
    String apikey;
    if (box.read('apikey') == null) {
      box.write('apikey', 'apikey');
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('SettingsView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
                top: 40, left: 40, right: 40, bottom: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        onChanged: (val) {
                          name = val;
                          box.write('name', name);
                        },
                        controller: TextEditingController()
                          ..text = box.read('name'),
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "User Name [ADAFURIT.IO]",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        onChanged: (val) {
                          username = val;
                          box.write('username', username);
                        },
                        controller: TextEditingController()
                          ..text = box.read('username'),
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "AIO Key [ADAFURIT.IO]",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        onChanged: (val) {
                          apikey = val;
                          box.write('apikey', apikey);
                        },
                        controller: TextEditingController()
                          ..text = box.read('apikey'),
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ));
  }
}
