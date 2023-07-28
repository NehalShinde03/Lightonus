import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/login_page/view/login_page.dart';
import 'package:lightonus/otp_page/view/enter_otp.dart';
import 'package:lightonus/sized_config/sized_config.dart';
import 'package:lottie/lottie.dart';
import '../../snackbars/snackbars.dart';
import '../controoler/otp_controller.dart';

class Enter_MobNum extends StatelessWidget {

  final phoneController = TextEditingController();
  final enterPhoneController = Get.put(OTPController());
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
              children:  [

                Padding(
                  padding: EdgeInsets.only(top: SizedConfig.heightAdjust*0.0),
                  child: Lottie.asset('assets/images/enter_phonenum.json',fit: BoxFit.fill,width: SizedConfig.widthAdjust*90,height: SizedConfig.heightAdjust*50),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: SizedConfig.heightAdjust*1.5,right: SizedConfig.heightAdjust*22.2),
                  child: Text(
                    'OTP Verification...',
                    style: TextStyle(
                      fontFamily: "Ubuntu-Bold",
                      fontSize: SizedConfig.txtAdjust*2.8,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(right: SizedConfig.heightAdjust*7.5, top: SizedConfig.heightAdjust*1.5),
                  child: Text('We will send you a One Time Password\non this Phone number.',style: TextStyle(color: Colors.black45,fontSize: SizedConfig.txtAdjust*2)),
                ),

                SizedBox(height: SizedConfig.heightAdjust*4.0),

                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [

                      Padding(
                        padding: EdgeInsets.only(left: SizedConfig.widthAdjust*3),
                        child: Text('+91 |' ,style: TextStyle( fontSize: SizedConfig.txtAdjust*2.6,
                            fontFamily: 'Cinzel-Variable_wgt',
                            color: Colors.grey)),
                      ),
                      Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 90),
                        child: TextField(
                              maxLength: 10,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: 'Enter Phone Number',
                                hintStyle: TextStyle( fontSize: SizedConfig.txtAdjust*2.4,
                                    fontFamily: 'Cinzel-Variable_wgt',
                                color: Colors.grey),
                              ),
                              style: TextStyle( fontSize: SizedConfig.txtAdjust*2.7,
                                fontFamily: 'Cinzel-Variable_wgt'),
                              ),
                      ),
                    ),
                    ],
                  ),
                ),

                SizedBox(height: SizedConfig.heightAdjust*4.0),
                Container(
                  width:SizedConfig.widthAdjust*45,
                  height: SizedConfig.heightAdjust* 7.4,
                  decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xff57c9ec),
                            Color(0xff34e1cd)
                          ]
                      ),
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
                      ]
                  ),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        )
                    ),
                    onPressed: () {
                      if(phoneController.text.length==10){
                        enterPhoneController.verifyPhone(phoneController.text);
                        //enterPhoneController.startTimer();
                        Get.to(Enter_OTP(),arguments: phoneController.text);
                      }
                      else if(phoneController.text.isEmpty){
                        snackbar.snackBar('OTP Verification', 'Please Enter Mobile Number',2);
                      }
                      else{
                        snackbar.snackBar('OTP Verification', 'Something Missing',2);
                      }

                      },
                    child: const Text('Get OTP',style:TextStyle(color: Colors.white,fontSize: 17)),
                  ),
                ),

                SizedBox(height: SizedConfig.heightAdjust*4.1),

                RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: const TextStyle(color: Colors.grey,fontSize: 13),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(LoginPage());
                        } ,
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
