import 'package:get/get.dart';

import '../../../data/service/memory/memory_service.dart';
import '../controllers/memory_controller.dart';

class MemoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      MemoryController(
        Get.find<MemoryService>(),
      ),
    );
  }
}
