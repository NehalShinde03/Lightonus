import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/report/controller/report_controller.dart';
import 'package:lightonus/report/controller/report_json.dart';

import '../../reusable_widget/reusable_widget.dart';
import '../../sized_config/sized_config.dart';

class AllReport extends StatelessWidget {

  var reportControl = Get.put(ReportController());

  Widget buildUser(ReportJson reportJson) {
    return reusableReportCard(
        reportControl.complaintIDController.text = reportJson.complaintId.toString(),
        reportControl.statusController.text = reportJson.status.toString(),
        reportControl.dateController.text = reportJson.date.toString(),
        reportControl.descriptionController.text = reportJson.description.toString(),(){
          reportControl.complaintIDController.text='';
          reportControl.complaintIDController.text = reportJson.complaintId.toString();
          reportControl.fetchAllContact(reportControl.complaintIDController.text);
  });
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            title:reusableText1('Complaint Status', 0,0,0 , "Ubuntu-Bold",
                SizedConfig.txtAdjust * 3.1, Colors.black87),
            backgroundColor: Colors.white,
            toolbarHeight: SizedConfig.heightAdjust*13,
            elevation: 40,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30)
              ),
              side: BorderSide(color: Colors.grey, width: SizedConfig.widthAdjust*0.5)
            ),
          ),
          body: StreamBuilder<List<ReportJson>>(
            stream: reportControl.readUser(),
            builder: (context,snapshot){
              if(snapshot.hasError){
                return Center(
                  child: reusableText1('Data Fetching Error', 0,0,0 , "Ubuntu-Bold",
                      SizedConfig.heightAdjust*2.5, Colors.black45),
                );
              }
              else if(snapshot.hasData){
                final users = snapshot.data!;
                if(users.isEmpty){
                  return Center(
                      child: reusableText1('Data Not Available..!!!', 0,0,0 , "Ubuntu-Bold",
                          SizedConfig.heightAdjust*2.5, Colors.black45)
                  );
                }
                else{
                  return ListView(
                    children: users.map(buildUser).toList(),
                  );
                }
              }
              else{
                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 10.0),
                        Center(
                          child: reusableText1('Please Wait', 0,0,0 , "Ubuntu-Bold",
                              SizedConfig.heightAdjust*2.5, Colors.black45),
                        )
                      ],
                    )
                );
              }
            },
          )
        )
    );
  }
}
