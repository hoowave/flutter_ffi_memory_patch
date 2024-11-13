import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hoowave_memory_patch/app/modules/memory/controllers/memory_controller.dart';

class MemoryWriteBox {
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
            _buildWriteText(controller: controller),
            Divider(
              height: 0,
            ),
            Obx(
              () {
                return Expanded(
                  child: ListView.builder(
                    controller: controller.writeScrollController,
                    itemCount: controller.writeMemoryList.length,
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
                      controller.writeMemoryList[index].addressController,
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
              Container(
                width: 100,
                child: TextField(
                  controller: controller.writeMemoryList[index].valueController,
                  style: const TextStyle(fontSize: 12),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 12),
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: controller.writeMemoryList[index].isDisable.value ? null : () {
                  controller.writeMemory(index);
                },
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                    BorderSide(color: Color(0xFF9EA7B3)),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(WidgetState.hovered)) {
                        return Color(0xFFE0E6F1);
                      }
                      if (states.contains(WidgetState.pressed)) {
                        return Color(0xFF4A90E2);
                      }
                      return Colors.transparent;
                    },
                  ),
                ),
                child: Text(
                  "Send",
                  style: TextStyle(color: controller.writeMemoryList[index].isDisable.value ? Colors.grey : Colors.green),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  controller.deleteWriteSlot(index);
                },
              ),
            ],
          ),
        ),
        Divider(color: Color(0xFF9EA7B3), height: 0),
      ],
    );
  }

  static Widget _buildWriteText({required MemoryController controller}) {
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
            Text("Value"),
            Text(""),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                controller.addWriteSlot();
              },
            ),
          ],
        ),
      ),
    );
  }
}
