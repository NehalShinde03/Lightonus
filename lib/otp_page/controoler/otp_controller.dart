import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/otp_model.dart';

class OTPController extends GetxController{

  final auth = FirebaseAuth.instance;
  var verificationID='';
  int? _resendToken;
 // late Rx<User?> firebaseUser;
 // final snackbar = SnackBarss();
 // Timer? timer;

  var otpControl=OTPModel(authState: '',start: 0, authStatus: "").obs;

  verifyPhone(String phone)async{
    otpControl.value.start=60;
    await auth.verifyPhoneNumber(
      timeout: Duration(seconds: otpControl.value.start),
        phoneNumber: '+91$phone',
        verificationCompleted:(AuthCredential credential){
          print('phone verification success');
        } ,
        verificationFailed: (authException){
        print('phone verification failed');
        },
        codeSent: (String id, forceResendingToken) async{
           verificationID=id;
           _resendToken=forceResendingToken;
           print('resending token = $_resendToken'); // 12486104,249154200
        },
        forceResendingToken: _resendToken,
        codeAutoRetrievalTimeout: (id){
          verificationID=id;
        }
    );
    startTimer();
  }

 void startTimer(){
    const count = Duration(seconds: 1);
    Timer.periodic(count, (timer) {
      if(otpControl.value.start==0){
        timer=Timer(const Duration(seconds: 1), () {});
        timer.cancel();
      }
      else{
        otpControl.update((otpControl) {
          otpControl?.start--;
        });
        print(otpControl.value.start);
      }
    }
    );
 }
}