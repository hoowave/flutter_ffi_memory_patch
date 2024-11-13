import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset('assets/logo/logo.png'),
            Gap(50),
            Text("Hoowave Memory Editor", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        )
      ),
    );
  }
}
