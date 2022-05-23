import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

import '../controllers/connected_device_controller.dart';

class ConnectedDeviceView extends GetView<ConnectedDeviceController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Automation has become an imperative part of our lives where we seek to modify, handle and mitigate things using ways without interacting with the appliances directly. Therefore, why not get things to your fingertip where things you want to stop could be halted on your simple voice command or a single click. Nothing makes life easier than luxury and flexibility to handle things from where you stand.',
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                'This application tends to bridge the gaps between the user and the home. It not only helps the user to access appliances but also monitor the status of it to reduce power consumption. This project has no radar limit it could access appliances from any part of the world through internet.',
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: size.height * 0.1),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Check Us Out @",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "DOMUS-Home_Automation_Application",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunch(
                                  "https://github.com/HAR5HA-7663/DOMUS-Home_Automation_Application") ==
                              true) {
                            launch(
                                "https://github.com/HAR5HA-7663/DOMUS-Home_Automation_Application");
                          } else {
                            print("Can't launch URL");
                          }
                        })
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
