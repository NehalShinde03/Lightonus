import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/complaint_screen/controller/complaint_controller.dart';
import 'package:lightonus/register_page/view/register_page.dart';
import 'package:lightonus/sized_config/sized_config.dart';
import 'package:lottie/lottie.dart';

import '../../complaint_preview_page/controller/complaintPreview_controller.dart';
import '../../login_register_controller/login_register_controller.dart';
import '../../snackbars/snackbars.dart';
import '../controoler/otp_controller.dart';

class Enter_OTP extends StatelessWidget {

  final otpController = TextEditingController();
//  final resetTimer = TextEditingController();

//  final loginController = Get.put(LoginRegisterController());
  final timing = Get.put(OTPController());
  var complaintController = Get.put(ComplaintController());
  var complaintPreviewController = Get.put(ComplaintPreviewController());
  final snackbar = SnackBarss();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: SizedConfig.heightAdjust * 8.5),
                  child: Lottie.asset('assets/images/otp_verify.json',
                      fit: BoxFit.fill,
                      width: SizedConfig.widthAdjust * 70,
                      height: SizedConfig.heightAdjust * 40),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizedConfig.heightAdjust * 5.5,
                      right: SizedConfig.heightAdjust * 22.2),
                  child: Text(
                    'OTP Verification...',
                    style: TextStyle(
                      fontFamily: "Ubuntu-Bold",
                      fontSize: SizedConfig.txtAdjust * 2.8,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizedConfig.heightAdjust * 7.5,
                      top: SizedConfig.heightAdjust * 1.8),
                  child: Row(
                    children: [
                      Text('Enter the OTP sent to',
                          style:
                              TextStyle(fontSize: SizedConfig.txtAdjust * 2)),
                      Text('\t +91 ${Get.arguments}',
                          style: TextStyle(
                              color: const Color(0xff34e1cd),
                              fontSize: SizedConfig.txtAdjust * 2)),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120.0,
                      child: TextField(
                        controller: otpController,
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          counterText: "",
                          border: const UnderlineInputBorder(),
                          hintText: 'Enter OTP',
                          hintStyle: TextStyle(
                              fontSize: SizedConfig.txtAdjust * 2.4,
                              fontFamily: 'Cinzel-Variable_wgt',
                              color: Colors.grey),
                        ),
                        style: TextStyle(
                            fontSize: SizedConfig.txtAdjust * 2.7,
                            fontFamily: 'Cinzel-Variable_wgt'),
                      ),
                    ),
                    SizedBox(width: SizedConfig.widthAdjust * 5),
                    Container(
                      padding:
                          EdgeInsets.only(top: SizedConfig.heightAdjust * 2.3),
                      width: SizedConfig.widthAdjust * 13,
                      height: SizedConfig.heightAdjust * 7.4,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.grey, width: 1.5)),
                      child: Obx(() {
                        return Text(
                          timing.otpControl.value.start < 10
                              ? '00:0${timing.otpControl.value.start.toString()}'
                              : '00:${timing.otpControl.value.start.toString()}',
                          style: TextStyle(
                              fontSize: SizedConfig.txtAdjust * 2.5,
                              color: Colors.grey,
                              fontFamily: 'Montez-Regular'),
                          textAlign: TextAlign.center,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: SizedConfig.heightAdjust * 3.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Didn\'t receive the code?'),
                    RichText(
                        text: TextSpan(
                      text: '\t\tResend',
                      style: const TextStyle(
                          color: Color(0xff4b2781), fontSize: 13),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          var phone = Get.arguments;
                          print('resend code = $phone');
                          timing.verifyPhone(Get.arguments);
                          timing.startTimer();
                        },
                    )),
                  ],
                ),
                SizedBox(height: SizedConfig.heightAdjust * 4.0),
                Container(
                  width: SizedConfig.widthAdjust * 45,
                  height: SizedConfig.heightAdjust * 7.4,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: const LinearGradient(
                          colors: [Color(0xff57c9ec), Color(0xff34e1cd)]),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[500]!,
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1),
                      ]),
                  child: OutlinedButton(
                    onPressed: () {
                      if (timing.otpControl.value.start == 0) {
                        snackbar.snackBar(
                            'OTP',
                            '${timing.otpControl.value.authStatus}. Please Resend the OTP',
                            1);
                        timing.otpControl.value.authStatus = null;
                      } else {
                        timing.otpControl.value.authStatus = null;
                        if (complaintPreviewController.sc.value.isComplaintSubmitted == true) {
                          complaintPreviewController.assignData();
                        } else {
                          Get.to(RegisterPage());
                        }
                        complaintController.sc.value.isComplaintSubmitted =
                            false;
                      }
                      timing.otpControl.value.start = 0;
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                    child: const Text('Verify OTP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Itim-Regular')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
