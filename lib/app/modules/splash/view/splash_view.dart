import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vehicle_man/app/modules/splash/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Visibility(
                visible: controller.showLoader.value,
                child: AnimatedOpacity(
                  opacity: controller.showLoader.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 4.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
