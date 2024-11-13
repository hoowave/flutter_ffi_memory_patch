import 'package:get/get.dart';
import 'package:hoowave_memory_patch/app/data/service/process/process_service.dart';

import '../controllers/process_controller.dart';

class ProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ProcessController(
        Get.find<ProcessService>(),
      ),
    );
  }
}
