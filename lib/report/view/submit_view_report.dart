import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/report/view/submit_report.dart';
import 'package:lightonus/report/view/all_report.dart';
import 'package:lightonus/sized_config/sized_config.dart';

import '../../reusable_widget/reusable_widget.dart';

class submitViewReport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //Complaint
              reusableText1('Report', 0,0, SizedConfig.heightAdjust * 35 , "Ubuntu-Bold",
                  SizedConfig.txtAdjust * 4.4 , Colors.black),

              reusableText1('you can submit report/ view the report.',
                  SizedConfig.heightAdjust * 1.9, 0, SizedConfig.widthAdjust * 23, "Ubuntu-Bold",
                  SizedConfig.txtAdjust * 1.7 , Colors.black45),


              SizedBox(height: SizedConfig.heightAdjust*8),
              SizedBox(
                  width: SizedConfig.widthAdjust*50,
                  height: SizedConfig.heightAdjust*10,
                  child:  reusableButton('Submit Report',(){
                    Get.to(SubmitReport());
                  })
              ),

              SizedBox(
                  width: SizedConfig.widthAdjust*50,
                  height: SizedConfig.heightAdjust*10,
                  child:  reusableButton('View Report',(){
                    Get.to(AllReport());
                  })
              ),

            ],
          ),
        ),
      ),
    );
  }
}
