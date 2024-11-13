import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hoowave_memory_patch/app/data/model/current_process_model.dart';
import 'package:hoowave_memory_patch/app/data/service/process/process_service.dart';
import 'package:hoowave_memory_patch/app/routes/app_pages.dart';

import '../../../../env.dart';
import '../../../data/model/process_model.dart';
import '../../widgets/common_dialog.dart';

class ProcessController extends GetxController {
  final ProcessService processService;

  ProcessController(this.processService);

  final ScrollController scrollController = ScrollController();
  final RxInt selectedProcessIndex = 65535.obs;
  final RxList<ProcessModel> processList = <ProcessModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void pushMemory() {
    if (selectedProcessIndex.value == 65535) return;
    if (Env.isMac) {
      CurrentProcessModel currentProcessModel = CurrentProcessModel(
          processHandle: processList[selectedProcessIndex.value].pid,
          name: processList[selectedProcessIndex.value].name);
      Get.toNamed(Routes.MEMORY, arguments: currentProcessModel);
      return;
    }
    ProcessModel processModel = processList[selectedProcessIndex.value];
    CurrentProcessModel currentProcessModel =
        processService.openTargetProcess(processModel);
    Get.toNamed(Routes.MEMORY, arguments: currentProcessModel);
  }

  void loadList() {
    if (Env.isMac) {
      processList.value = ProcessModel.loadDummyProcesses();
      return;
    }
    if (!processService.libraryService.getLoadStatus()) {
      CommonDialog.error(
          content: "${Env.libName}\nNot Load",
          onRetryPressed: () {
            exit(0);
          });
    }
    processList.value = processService.fetchApplicationList();
  }
}
