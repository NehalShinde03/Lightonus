import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lightonus/application_submitted/success_controller.dart';
import 'package:lightonus/complaint_screen/controller/complaint_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';


class Success extends StatelessWidget {

  final successComplaint = Get.put(SuccessController());
  final complaintController = Get.put(ComplaintController());
  var  styleText=const TextStyle(
   fontFamily: 'Ubuntu-Regular',
   fontSize: 14
  );

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/application_successful.json',
                    fit: BoxFit.cover,
                    controller: successComplaint.controller,
                    onLoaded: (finished){
                      successComplaint.stopAnimation();
                    }
                  ),
                  AnimatedTextKit(
                      animatedTexts: [
                       ColorizeAnimatedText(
                           '${Get.arguments} Submitted Successfully...!',
                           textStyle: styleText,
                           colors: [
                             const Color(0xff00FF97),
                             const Color(0xffFF8903),
                           ]
                       )
                      ],
                    totalRepeatCount: 1,
                  ),
                ],
              )

          ),
        )
    );
  }
}