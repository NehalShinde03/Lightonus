import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/complaint_screen/controller/complaint_controller.dart';
import 'package:lightonus/home_page/home_page.dart';

class SuccessController extends GetxController with GetSingleTickerProviderStateMixin{

  late AnimationController controller;
  final complaintController = Get.put(ComplaintController());


  @override
  void onInit(){
    super.onInit();
    controller = AnimationController(
        vsync:this,
        duration: const Duration(seconds: 3)
    );
  }

  void stopAnimation(){
    controller..duration = const Duration(seconds: 3)
              ..forward();

    complaintController.imgList.length=0;

    Future.delayed(const Duration(seconds: 3),(){
      Get.offAll(() => Home_Page());
    });
  }
}