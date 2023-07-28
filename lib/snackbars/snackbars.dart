import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sized_config/sized_config.dart';

class SnackBarss{
  SnackbarController snackBar(String title , String description, int second){
    return Get.snackbar(
      title.toString(),
      description.toString(),
      backgroundColor: const Color(0xffece8e8),
      borderRadius: SizedConfig.widthAdjust*500,
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: Duration(seconds: second),
      icon: const Icon(Icons.warning_amber_rounded),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}

