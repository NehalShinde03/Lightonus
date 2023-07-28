import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../login_register_controller/login_register_controller.dart';
import '../sized_config/sized_config.dart';

class DrawerProfile extends StatelessWidget {

  var googleauth = Get.put(LoginRegisterController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizedConfig.widthAdjust*3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white),
        color: const Color(0xfff69c6c),
        boxShadow:[
          BoxShadow(
              color: const Color(0xF89A9797).withOpacity(0.9),
              blurRadius:7,
              offset: const Offset(7.0,10.0),
              spreadRadius: 3
          ),
        ],
      ),
      width: double.infinity,
      height: SizedConfig.heightAdjust*30,
      padding: EdgeInsets.only(top: SizedConfig.widthAdjust*2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: SizedConfig.widthAdjust*0),
            height: SizedConfig.heightAdjust*14,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              border: Border(
                right: BorderSide(color: Colors.white),
                left: BorderSide(color: Colors.white),
                top: BorderSide(color: Colors.white),
                bottom: BorderSide(color: Colors.white),
              ),
            ),
            child: CircleAvatar(
              radius: SizedConfig.widthAdjust*12,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child:  googleauth.setProfilePhoto(),
              ),
            ),
          ),
          googleauth.setProfileName(),
          googleauth.setProfileEmail()
        ],
      ),
    );
  }
}
