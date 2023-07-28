import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/login_page/view/login_page.dart';
import 'package:lightonus/sized_config/sized_config.dart';

import '../../login_register_controller/login_register_controller.dart';
import '../../snackbars/snackbars.dart';

class RegisterPage extends StatelessWidget {


  final register_control=Get.put(LoginRegisterController());
  final snackbar = SnackBarss();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children:  [

              Padding(
                padding: EdgeInsets.only(
                    top: SizedConfig.heightAdjust*9.5,right: SizedConfig.widthAdjust*34),
                child: Text(
                  'Hi, Welcome!',
                  style: TextStyle(
                    fontFamily: "Ubuntu-Bold",
                    fontSize: SizedConfig.txtAdjust*4.4,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: SizedConfig.heightAdjust*1.2,right: SizedConfig.widthAdjust*25),
                child: Text(
                  'Create a new account...',
                  style: TextStyle(
                      fontFamily: "Ubuntu-Bold",
                      fontSize: SizedConfig.txtAdjust*2.5,
                      color: Colors.grey
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: SizedConfig.widthAdjust*4, right: SizedConfig.widthAdjust*5,
                    top: SizedConfig.heightAdjust*14),
                child: TextField(
                  controller:  register_control.registerEmailController.value,
                  decoration: InputDecoration(
                    label: const Text('Enter Email-id'),
                    labelStyle: TextStyle(
                        fontSize: SizedConfig.txtAdjust*2.0,
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
                  padding: EdgeInsets.only(left: SizedConfig.widthAdjust*4, right: SizedConfig.widthAdjust*5,
                      top: SizedConfig.heightAdjust*5),
                  child: Obx((){
                    return TextField(
                      controller: register_control.registerPasswordController.value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: const Text('Enter Password'),
                        labelStyle: TextStyle(
                            fontSize:SizedConfig.txtAdjust*2.0,
                            fontFamily: 'Cinzel-Variable_wgt',
                            color: Colors.grey
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: register_control.data.value.ic,
                          onPressed:  () {
                            register_control.convert();
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0,color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      obscureText:register_control.data.value.securepass,
                    );
                  })
              ),

              Padding(
                  padding: EdgeInsets.only(left: SizedConfig.widthAdjust*4, right: SizedConfig.widthAdjust*5,
                      top: SizedConfig.heightAdjust*5),
                  child: Obx((){
                    return TextField(
                      controller: register_control.registerConfirmPasswordController.value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: const Text('Confirm Password'),
                        labelStyle: TextStyle(
                            fontSize:SizedConfig.txtAdjust*2.0,
                            fontFamily: 'Cinzel-Variable_wgt',
                            color: Colors.grey
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: register_control.data.value.ic,
                          onPressed: () => register_control.convert(),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0,color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      obscureText:register_control.data.value.securepass,
                    );
                  })
              ),

              SizedBox(height: SizedConfig.heightAdjust*6.5),
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
                  onPressed: () async{
                    try {
                      const CircularProgressIndicator();
                      if(register_control.registerPasswordController.value.text == register_control.registerConfirmPasswordController.value.text){
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: register_control.registerEmailController.value.text,
                            password: register_control.registerPasswordController.value.text);
                        Get.to(LoginPage());
                      }
                      else{
                        snackbar.snackBar('Password...','The password does\'t Match',2);
                      }
                    }
                    on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        snackbar.snackBar('Firebase Authentication','No user found for that email',2);
                      }
                      else if (e.code == 'wrong-password') {
                        snackbar.snackBar('Firebase Authentication','Wrong password provided for that user',2);
                      }
                      else {
                        snackbar.snackBar('Firebase Authentication','Something missing',2);
                      }
                     }
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                      )
                  ),
                  child: const Text('Signup',style:TextStyle(color: Colors.white,fontSize: 17)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
