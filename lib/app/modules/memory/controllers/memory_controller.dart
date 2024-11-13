import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hoowave_memory_patch/app/data/model/current_process_model.dart';
import 'package:hoowave_memory_patch/app/data/model/read_memory_model.dart';
import 'package:hoowave_memory_patch/app/data/service/memory/memory_service.dart';

import '../../../data/model/memory_format.dart';
import '../../../data/model/write_memory_model.dart';

class MemoryController extends GetxController {
  final MemoryService memoryService;
  final Rx<CurrentProcessModel> processHandler = CurrentProcessModel(processHandle: 0, name: '').obs;

  final ScrollController readScrollController = ScrollController();
  final ScrollController writeScrollController = ScrollController();

  final RxList<ReadMemoryModel> readMemoryList = <ReadMemoryModel>[].obs;
  final RxList<WriteMemoryModel> writeMemoryList = <WriteMemoryModel>[].obs;

  MemoryController(this.memoryService);

  @override
  void onInit() {
    super.onInit();
    // processModel = ProcessModel(pid: 123, name: "test.exe");
    // readMemoryList.value = generateDummyData();
  }

  @override
  void onReady(){
    super.onReady();
    processHandler.value = Get.arguments;
    addReadSlot();
    addWriteSlot();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void startReadMemory(int index) {
    if (index < 0 || index >= readMemoryList.length) return;
    readMemoryList[index].timer?.cancel();
    readMemoryList[index].timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _readMemory(index);
    });
  }

  void _readMemory(int index) {
    if (index < 0 || index >= readMemoryList.length) return;
    int handle = processHandler.value.processHandle;
    int? address = int.tryParse(readMemoryList[index].addressController.text, radix: 16);
    if(address == null) return;
    int size = readMemoryList[index].selectedFormat.value.size;
    int result = memoryService.readMemory(handle, address!, size);
    readMemoryList[index].resultValue.value = result;
  }

  void writeMemory(int index) {
    int handle = processHandler.value.processHandle;
    int? address = int.tryParse(writeMemoryList[index].addressController.text, radix: 16);
    if(address == null) return;
    int? value = int.tryParse(writeMemoryList[index].valueController.text, radix: 16);
    if(value == null) return;
    bool result = memoryService.writeMemory(handle, address, value);
  }

  void addReadSlot() {
    readMemoryList.add(ReadMemoryModel(resultValue: RxInt(-1)));
  }

  void deleteReadSlot(int index) {
    if (index < 0 || index >= readMemoryList.length) return;
    readMemoryList[index].timer?.cancel();
    readMemoryList.removeAt(index);
  }

  void addWriteSlot(){
    writeMemoryList.add(WriteMemoryModel());
  }

  void deleteWriteSlot(int index) {
    if (index < 0 || index >= writeMemoryList.length) return;
    writeMemoryList[index].dispose();
    writeMemoryList.removeAt(index);
  }

}
