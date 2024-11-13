import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hoowave_memory_patch/app/modules/memory/controllers/memory_controller.dart';

import '../../../../data/model/memory_format.dart';

class MemoryReadBox {
  static Widget build({required MemoryController controller}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF9EA7B3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _buildReadText(controller: controller),
            Divider(
              height: 0,
            ),
            Obx(
              () {
                return Expanded(
                  child: ListView.builder(
                    controller: controller.readScrollController,
                    itemCount: controller.readMemoryList.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () {
                          return _buildItem(
                              controller: controller, index: index);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildItem(
      {required int index, required MemoryController controller}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFEFF1F4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                child: TextField(
                  controller:
                      controller.readMemoryList[index].addressController,
                  onChanged: (_) {
                    controller.startReadMemory(index);
                  },
                  style: const TextStyle(fontSize: 12),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 12),
                    hintText: '00400000',
                    labelText: '0x',
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              Obx(
                () {
                  return Text(
                    controller.readMemoryList[index].resultValue.value == -1
                        ? '??'
                        : controller.readMemoryList[index].formatValue(
                            controller.readMemoryList[index].resultValue.value,
                          ),
                  );
                },
              ),
              Obx(
                () {
                  return DropdownButton<MemoryFormat>(
                    value:
                        controller.readMemoryList[index].selectedFormat.value,
                    iconSize: 16,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    onChanged: (newFormat) {
                      if (newFormat != null) {
                        controller.readMemoryList[index].selectedFormat.value =
                            newFormat;
                      }
                    },
                    items: MemoryFormat.values.map((format) {
                      return DropdownMenuItem(
                        value: format,
                        child: Text(format.displayName), // displayName을 사용
                      );
                    }).toList(),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  controller.deleteReadSlot(index);
                },
              ),
            ],
          ),
        ),
        Divider(color: Color(0xFF9EA7B3), height: 0),
      ],
    );
  }

  static Widget _buildReadText({required MemoryController controller}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Color(0xFFCFD3DB),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Address"),
            Text("   Value"),
            Text("Format"),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                controller.addReadSlot();
              },
            ),
          ],
        ),
      ),
    );
  }
}
