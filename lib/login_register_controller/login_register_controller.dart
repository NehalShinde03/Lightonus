import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lightonus/home_page/home_page.dart';
import 'package:lightonus/sized_config/sized_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../info_page/info_pages_call.dart';
import '../login_page/model/passWords.dart';
import '../login_page/view/login_page.dart';
import '../snackbars/snackbars.dart';

String? lastEmail = '';
String? lastName = '';

class LoginRegisterController extends GetxController{

  final snackbar = SnackBarss();

 // bool goto_infoPage=false;
  //for login
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  //for register
  final Rx<TextEditingController> registerEmailController = TextEditingController().obs;
  final Rx<TextEditingController> registerPasswordController = TextEditingController().obs;
  final Rx<TextEditingController> registerConfirmPasswordController = TextEditingController().obs;

  //for show and hide password use eye symbol
  var data=passWords(securepass: true, ic: const Icon(Icons.remove_red_eye),
      complaintID: 0).obs;

  //custom = var declare and initialized
  FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  //google = var declare and initialized
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  //set google profileimage
  String profileImage='';
  //googel email
  String gemail='';
  //google name
  String gname='';

  //var fireInstace=FirebaseFirestore.instance;

  bool isLoginPage = false;

  //password visible and invisible
  convert(){
    data.update((data) {
      if(data?.securepass == true){
        data?.ic = const Icon(Icons.visibility_off);
        data?.securepass=false;
      }
      else{
        data?.ic = const Icon(Icons.remove_red_eye);
        data?.securepass=true;
      }
    });
  }

  @override
  onInit(){
     //custom = id and password
      firebaseUser = Rx<User?>(auth.currentUser);
      firebaseUser.bindStream(auth.userChanges());
      ever(firebaseUser, setInitialScreen);

      //google
      googleSignInAccount = Rx<GoogleSignInAccount?>(_googleSignIn.currentUser);
      googleSignInAccount.bindStream(_googleSignIn.onCurrentUserChanged);
      ever(googleSignInAccount,setInitialScreenGoogle);
      super.onInit();
  }

  setInitialScreen(User? user) {
    signedIn(user);
  }

  //google
  setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount){
    signedIn(googleSignInAccount);
  }

  signedIn(var signedin) async{
    if (signedin == null) {
      Get.offAll(() => LoginPage());
    }
    else {
      if(isLoginPage==true){
        Get.offAll(() => InfoPagesCall());
      }else{
        Get.offAll(() => Home_Page());
      }
    }
  }

  //google
  void signInWithGoogle() async{
    try{
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if(googleSignInAccount!=null){
        GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

        AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        await auth
            .signInWithCredential(authCredential)
            .catchError((onError) => onError);
      }

      if (loginEmailController.text.isNotEmpty &&
          loginPasswordController.text.isNotEmpty) {
        gemail=loginEmailController.text.toString().trim();
        gname='';
      }
      else{
        gemail=googleSignInAccount?.email.toString().trim() ?? '';
        gname=googleSignInAccount?.displayName.toString()??'';
      }


      if(gemail.toString().contains('@gmail.com')){
        final SharedPreferences sharedpreferences=await SharedPreferences.getInstance();
        sharedpreferences.setString('email', gemail);
        sharedpreferences.setString('name', gname);
        lastEmail=sharedpreferences.getString('email')!;
        lastName=sharedpreferences.getString('name')!;
        print('loginpage email=$lastEmail');
        print('loginpage name=$lastName');
      }else{
        print('>>>>>>>>>>>>>> not a valid email');
      }


      Get.put(Home_Page());
    }catch(e){
      snackbar.snackBar("Something Wrong",'',2);
      print(e.toString());
    }
  }

  setProfilePhoto(){
    if(loginEmailController.text.isNotEmpty && loginPasswordController.text.isNotEmpty){
      return Image.asset('assets/images/user.png',fit: BoxFit.fill);
    }
    else{
      if(googleSignInAccount.value?.photoUrl != null){
        return Image.network(googleSignInAccount.value?.photoUrl ?? '',scale: 2,);
      }
      else{
        profileImage=googleSignInAccount.value?.displayName ?? '' ;
        profileImage=profileImage.substring(0,1);
        return Text(profileImage.toString(),style: const TextStyle(color: Colors.white,fontSize: 45));
      }
    }
  }

  setProfileEmail() {
    if (loginEmailController.text.isNotEmpty &&
        loginPasswordController.text.isNotEmpty) {
      return Text(loginEmailController.text.toString().trim(),
        style: TextStyle(color: Colors.white, fontSize: SizedConfig.txtAdjust*2.7));
    }
    else {
      if (googleSignInAccount.value?.email != null) {
        //gemail=googleSignInAccount.value?.email.toString().trim() ?? '';
        return Text(lastEmail!,
            style: TextStyle(color: Colors.white, fontSize: SizedConfig.txtAdjust*2));
      }
    }
  }

  setProfileName() {
    if (loginEmailController.text.isNotEmpty &&
        loginPasswordController.text.isNotEmpty) {
      return const Text('');
    }
    else {
      if (googleSignInAccount.value?.displayName != null) {
        return Padding(
          padding: EdgeInsets.only(top: SizedConfig.heightAdjust*2),
          child: Text(lastName!,
              style: TextStyle(color: Colors.white, fontSize: SizedConfig.txtAdjust*3)),
        );
      }
    }
  }

  signOut() async {
    loginEmailController.text='';
    loginPasswordController.text='';
    await auth.signOut();
    Get.to(LoginPage());
  }

  @override
  void onClose() {
    gemail='';
    gname='';

    loginEmailController.clear();
    loginPasswordController.clear();
    loginEmailController.dispose();
    loginPasswordController.dispose();

    registerEmailController.close();
    registerPasswordController.close();
    registerConfirmPasswordController.close();
  }
}