import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'common_button.dart';

class CommonDialog {
  static Future<void> error({
    required String content,
    required Function()? onRetryPressed,
  }) async {
    await Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(0),
        child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("ERROR !",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Gap(20),
                  Text(content, textAlign: TextAlign.center),
                  Gap(20),
                  CommonButton(
                    width: 200,
                    color: Colors.red,
                    text: "Exit",
                    onPressed: onRetryPressed,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
