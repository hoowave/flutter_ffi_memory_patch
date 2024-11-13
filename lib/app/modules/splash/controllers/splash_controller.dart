import 'package:get/get.dart';
import 'package:hoowave_memory_patch/app/routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 1), () {
      Get.offNamed(Routes.PROCESS);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

}
