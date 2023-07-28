import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_page/view/login_page.dart';
import '../login_register_controller/login_register_controller.dart';

String? userName=null;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState(){
      animationController=AnimationController(vsync: this,duration: const Duration(seconds: 5));
      animation=CurvedAnimation(parent: animationController, curve: Curves.ease);
      animationController.repeat(reverse: false);
      getValidationData().whenComplete(() {
          Timer(const Duration(seconds: 3),() => LoginPage());
      });
    super.initState();
  }


  Future getValidationData() async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState((){
      lastEmail=sharedPreferences.getString('email');
      lastName=sharedPreferences.getString('name');
    });
  }


  void dispose(){
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [

            Container(
              height: height / 1.1,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(350.0),
                      bottomRight: Radius.circular(350.0)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff34e1cd),
                        Color(0xff57c9ec),
                      ]
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(2.0, 1.0)
                    )
                  ]
              ),
            ),

            Center(
              child: FadeTransition(
                opacity: animation,
                child: Container(
                  width: width / 3.5,
                  height: height / 5.5,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xbe868484),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(2.0, 1.0)
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 5.0),
                    child: Image.asset(
                        'assets/images/strees.png', fit: BoxFit.fill,
                        color: Colors.black,
                        alignment: Alignment.center),
                  ),
                ),
              ),
            ),

            FadeTransition(
              opacity: animation,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 110.0),
                child: const Text('Lightonus', style: TextStyle(
                    fontFamily: 'Montez-Regular',
                    fontSize: 49.0,
                    color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

