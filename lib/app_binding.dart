import 'package:get/get.dart';
import 'package:hoowave_memory_patch/app/data/service/library/library_service.dart';
import 'package:hoowave_memory_patch/app/data/service/memory/memory_service.dart';
import 'package:hoowave_memory_patch/app/data/service/process/process_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LibraryService>(LibraryService(), permanent: true);
    Get.put<ProcessService>(ProcessService(Get.find<LibraryService>()), permanent: true);
    Get.put<MemoryService>(MemoryService(Get.find<LibraryService>()), permanent: true);
  }
}
