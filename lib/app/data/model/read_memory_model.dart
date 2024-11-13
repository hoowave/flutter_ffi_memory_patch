import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'memory_format.dart';

class ReadMemoryModel {
  ReadMemoryModel({required this.resultValue});

  final RxInt resultValue;
  final TextEditingController addressController = TextEditingController();
  final Rx<MemoryFormat> selectedFormat = Rx<MemoryFormat>(MemoryFormat.FourByte);
  Timer? timer;

  String formatValue(int value) {
    switch (selectedFormat.value) {
      case MemoryFormat.Byte:
      case MemoryFormat.TwoByte:
      case MemoryFormat.FourByte:
        return value.toString();
      case MemoryFormat.Hex:
        return value.toRadixString(16);
      default:
        return value.toString();
    }
  }

}
