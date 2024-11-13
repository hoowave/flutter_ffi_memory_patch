import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'memory_format.dart';

class WriteMemoryModel {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final Rx<MemoryFormat> selectedFormat = Rx<MemoryFormat>(MemoryFormat.FourByte);
  final RxBool isDisable = true.obs;

  WriteMemoryModel() {
    addressController.addListener(_updateIsDisable);
    valueController.addListener(_updateIsDisable);
  }

  void _updateIsDisable() {
    if (addressController.text.isNotEmpty && valueController.text.isNotEmpty) {
      isDisable.value = false;
    } else {
      isDisable.value = true;
    }
  }

  void dispose() {
    addressController.removeListener(_updateIsDisable);
    valueController.removeListener(_updateIsDisable);
    addressController.dispose();
    valueController.dispose();
  }
}