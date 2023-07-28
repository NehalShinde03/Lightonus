import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/reusable_widget/reusable_widget.dart';
import 'package:lightonus/sized_config/sized_config.dart';
import '../../info_page/info_pages_call.dart';
import '../../login_register_controller/login_register_controller.dart';
import '../../otp_page/view/enter_mobnum.dart';
import '../../snackbars/snackbars.dart';


class LoginPage extends StatelessWidget {

  final loginController = Get.put(LoginRegisterController());
  final snackbar = SnackBarss();
  //bool isLoading = false;
  //final fire_inst=FirebaseFirestore.instance;
  //bool disp_infoPage=false;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children:  [

              reusableText1('Welcome Back!', SizedConfig.heightAdjust * 9.2,
                  0, SizedConfig.heightAdjust * 14.69 , "Ubuntu-Bold",
                  SizedConfig.txtAdjust * 4.4, Colors.black),

              reusableText1('Signin to Continue...', SizedConfig.heightAdjust * 1.4,
                  0, SizedConfig.heightAdjust * 17.3 , "Ubuntu-Bold",
                  SizedConfig.txtAdjust * 2.5, Colors.grey),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15,
                top: SizedConfig.heightAdjust*14),
                child: TextField(
                  controller: loginController.loginEmailController,
                  decoration: InputDecoration(
                      label: const Text('Enter Email-id'),
                      labelStyle: TextStyle(
                          fontSize: SizedConfig.txtAdjust*1.8,
                          fontFamily: 'Cinzel-Variable_wgt',
                          color: Colors.grey
                      ),
                      prefixIcon: const Icon(Icons.email),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0,color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                  ),
                ),
              ),


             Padding(
                  padding: EdgeInsets.only(left: 15, right: 15,
                      top: SizedConfig.heightAdjust*5),
                  child: Obx((){
                    return TextField(
                      controller: loginController.loginPasswordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          label: const Text('Enter Password'),
                          labelStyle: TextStyle(
                              fontSize:SizedConfig.txtAdjust*1.8,
                              fontFamily: 'Cinzel-Variable_wgt',
                              color: Colors.grey
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: loginController.data.value.ic,
                            onPressed: (){
                              loginController.convert();
                            },
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0,color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                      ),
                      obscureText:loginController.data.value.securepass,
                    );
                  })
                ),

             SizedBox(height: SizedConfig.heightAdjust*3),

             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 RichText(
                     text: TextSpan(
                       text: 'Don\'t have account?',
                       style: const TextStyle(color: Colors.grey,fontSize: 13),
                       recognizer: TapGestureRecognizer()
                         ..onTap = () {
                           Get.to(Enter_MobNum());
                         }
                     )
                 ),

                 RichText(
                     text: TextSpan(
                       text: ' SignUp',
                       style: const TextStyle(color: Color(0xff626161),fontSize: 12),
                       recognizer: TapGestureRecognizer()
                         ..onTap = () {
                           Get.to(Enter_MobNum());
                         }
                     )
                 ),
               ],
             ),

              SizedBox(height: SizedConfig.heightAdjust*4),
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
                    onPressed: () async {
                      try{
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: loginController.loginEmailController.value.text,
                            password: loginController.loginPasswordController.value.text
                        );
                        Get.off(InfoPagesCall());
                      }
                      on FirebaseException catch(e){
                        if(e.code=='user-not-found') {
                          snackbar.snackBar('Firebase Authentication',
                              'No user found for that email',2);
                        }

                        else if(e.code == 'wrong-password'){
                          snackbar.snackBar('Firebase Authentication',
                            'Wrong password provided for that user',2);
                        }
                        else{
                          snackbar.snackBar('Firebase Authentication', 'Something missing',2);
                        }
                      }
                     },
                    child: const Text('Sign in',style:TextStyle(color: Colors.white,fontSize: 17)),
                ),
              ),

              SizedBox(height: SizedConfig.heightAdjust*5),
              const Text('--------------------  or connect using  --------------------',
                  style: TextStyle(
                    color: Colors.grey,fontSize: 13
                  )
                ),

              SizedBox(height: SizedConfig.heightAdjust*5),
              InkWell(
                child: Container(
                    width:SizedConfig.widthAdjust*50.0,
                    height: SizedConfig.heightAdjust* 8.5,
                    padding: EdgeInsets.only(left: SizedConfig.widthAdjust*0.5),
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      color: Colors.white,
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
                  child: Row(
                    children: [
                      Image.asset('assets/images/google_imgs.png',scale: SizedConfig.imgAdjust*1.1),
                      Text('Sign in with Google',style: TextStyle(color: Colors.grey,fontSize: SizedConfig.txtAdjust*2,fontFamily: "Ubuntu-Bold"))
                    ],
                  ),
                ),
                onTap: () {
                  loginController.isLoginPage=true;
                  loginController.signInWithGoogle();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
