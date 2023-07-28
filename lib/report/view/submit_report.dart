import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/report/view/submit_view_report.dart';

import '../../application_submitted/success.dart';
import '../controller/report_controller.dart';
import '../../reusable_widget/reusable_widget.dart';
import '../../sized_config/sized_config.dart';
import '../../snackbars/snackbars.dart';

class SubmitReport extends StatelessWidget {

  final snackbar = SnackBarss();
  var reportController = Get.put(ReportController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText1('Report', SizedConfig.heightAdjust * 8.2,
                    SizedConfig.heightAdjust * 2, 0 , "Ubuntu-Bold",
                    SizedConfig.txtAdjust * 6.9, Colors.black),

                //disp fill details msg
                reusableText1('Fill Details', SizedConfig.heightAdjust * 10.9,
                    SizedConfig.heightAdjust * 4.9, SizedConfig.heightAdjust * 25 , "Ubuntu-Bold",
                    SizedConfig.txtAdjust * 2.8 , Colors.black),

                //disp Please fill report details
                reusableText1('Please fill report details.', SizedConfig.heightAdjust * 1.7,
                    SizedConfig.heightAdjust * 4.9, SizedConfig.heightAdjust * 24.5 , "Ubuntu-Bold",
                    SizedConfig.txtAdjust * 1.8, Colors.black45),

                //enter complaint id
                reusableTextField1( 'Enter Complaint-ID', SizedConfig.widthAdjust * 95,
                    SizedConfig.widthAdjust * 5, SizedConfig.widthAdjust * 5.5,
                    Icons.note_add_rounded, reportController.complaintIDController, TextInputType.text,
                    6, 1, true, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', const Color(0xff5e5e5e),
                    SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                ),

                //enter complaint status
                reusableTextField1( 'Enter Complaint Status', SizedConfig.widthAdjust * 95,
                    SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                    Icons.edit_attributes, reportController.statusController, TextInputType.text,
                    12, 1, true, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', const Color(0xff5e5e5e),
                    SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                ),

                //enter date
                reusableTextField1( 'Enter Date', SizedConfig.widthAdjust * 95,
                    SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                    Icons.date_range, reportController.dateController, TextInputType.datetime,
                    10, 1, true,SizedConfig.txtAdjust * 2.6, 'Itim-Regular', const Color(0xff5e5e5e),
                    SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                ),

                //enter description
                reusableTextField1( 'Enter Report Description', SizedConfig.widthAdjust * 95,
                    SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                    Icons.description, reportController.descriptionController, TextInputType.text,
                    70, 3, true, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', const Color(0xff5e5e5e),
                    SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                ),

                SizedBox(height: SizedConfig.heightAdjust*6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    reusableButton('Cancel',(){
                      reportController.complaintIDController.clear();
                      reportController.statusController.clear();
                      reportController.dateController.clear();
                      reportController.descriptionController.clear();
                       Get.to(submitViewReport());
                    }),

                    reusableButton('Submit',(){
                      reportController.detailsVerify();
                    }),
                  ],
                )

              ],
            ),
          ),
        )
    );
  }
}
