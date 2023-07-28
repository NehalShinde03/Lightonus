import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/sized_config/sized_config.dart';

import '../reusable_widget/reusable_widget.dart';
import 'track_complaint/view/complaint_track_view.dart';
import 'track_newconnection/view/newconn_track_view.dart';

class ComplaintORNewConnection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //Complaint
              reusableText1('Track Status', 0,0, SizedConfig.heightAdjust * 23 , "Ubuntu-Bold",
                  SizedConfig.txtAdjust * 4.4 , Colors.black),

              reusableText1('You can track your Complaint / application for New Connection from here.',
                  SizedConfig.heightAdjust * 2.7, SizedConfig.widthAdjust * 6.8, 0, "Ubuntu-Bold",
                  SizedConfig.txtAdjust * 1.7 , Colors.black45),


              SizedBox(height: SizedConfig.heightAdjust*4),
              SizedBox(
                width: SizedConfig.widthAdjust*50,
                height: SizedConfig.heightAdjust*10,
                child:  reusableButton('Complaint',() => Get.to(ComplaintTrack()))
              ),

              SizedBox(
                width: SizedConfig.widthAdjust*50,
                height: SizedConfig.heightAdjust*10,
                child:  reusableButton('New Connection',() => Get.to(NewConnTrack()))
              ),

            ],
          ),
        ),
      ),
    );
  }
}
