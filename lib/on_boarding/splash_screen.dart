import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../core/constants/route_constants.dart';
import '../core/reusable_widgets/reusable_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.toNamed(USER_FIRST_TIME));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: imageFromAssetsFolder(
                width: 320.0,
                height: 150.0,
                path: 'assets/images/simpliby_logo.png')));
  }
}
