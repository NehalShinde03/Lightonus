import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/report/view/all_report.dart';
import 'package:lightonus/report/view/submit_view_report.dart';
import '../controller/report_controller.dart';
import '../../reusable_widget/reusable_widget.dart';
import '../../sized_config/sized_config.dart';
import '../../snackbars/snackbars.dart';

class ViewReport extends StatelessWidget {

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
                reusableText1('View Report', SizedConfig.heightAdjust * 8.2,
                    SizedConfig.heightAdjust * 2, 0 , "Ubuntu-Bold",
                    SizedConfig.txtAdjust * 4.9, Colors.black),

                SizedBox(height: SizedConfig.heightAdjust*6),

                //enter complaint id
                reusableTextField1( 'Your Complaint-ID', SizedConfig.widthAdjust * 95,
                    SizedConfig.widthAdjust * 5, SizedConfig.widthAdjust * 5.5,
                    Icons.note_add_rounded, reportController.complaintIDController, TextInputType.text,
                    6, 1, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                    SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none,

                ),

                //enter complaint status
                reusableTextField1( 'Your Complaint Status', SizedConfig.widthAdjust * 95,
                    SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                    Icons.edit_attributes, reportController.statusController, TextInputType.text,
                    12, 1, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                    SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                ),

                //enter date
                reusableTextField1( 'Your Date', SizedConfig.widthAdjust * 95,
                    SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                    Icons.date_range, reportController.dateController, TextInputType.datetime,
                    10, 1, false,SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                    SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                ),

                //enter description
                reusableTextField1( 'Your Report Description', SizedConfig.widthAdjust * 95,
                    SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                    Icons.description, reportController.descriptionController, TextInputType.text,
                    70, 3, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                    SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                ),

                SizedBox(height: SizedConfig.heightAdjust*4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    reusableButton('Cancel',(){
                      Get.to(AllReport());
                    }),

                    reusableButton('Delete',(){
                      reportController.deleteReport(reportController.complaintIDController.text);
                      Get.back();
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
