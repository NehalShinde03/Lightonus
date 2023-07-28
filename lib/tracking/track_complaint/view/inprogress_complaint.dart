import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/reusable_widget/reusable_widget.dart';
import 'package:lightonus/sized_config/sized_config.dart';

import '../../../complaint_preview_page/controller/complaintPreview_controller.dart';
import '../../../complaint_preview_page/model/complaint_json.dart';

class InProgressComplaint extends StatelessWidget {
//  final loginRegister = Get.put(LoginRegisterController());
  final complaintPreview = Get.put(ComplaintPreviewController());
//  final complaintTrackController = Get.put(ComplaintTrackController());


  //read complaintID,date,time and status and disp in this widget
  Widget buildUser(User user) {
    if(user.complaintStatus.toString() =='in Progress'){
      //complaintTrackController.totalComplaints.value++;
      return reusableCard(Colors.red.shade300, 'C${user.complaintId.toString()}',
          user.complaintCurrDate.toString(),user.complaintCurrTime.toString(),user.complaintStatus.toString(),(){
            complaintTrackController.sc.value.complaintID=user.complaintId.toString();
            complaintTrackController.sc.value.complaintStatus=user.complaintStatus.toString();
            complaintPreview.sc.value.currDate;
            complaintPreview.sc.value.currTime;
            complaintTrackController.fetchAllContact(complaintTrackController.sc.value.complaintID);
          });
    }
    else{return const SizedBox();}

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //read operation
          body: StreamBuilder<List<User>>(
            stream: complaintTrackController.readUser(),
            builder: (context,snapshot){
              if(snapshot.hasError){
                return Center(
                  child: reusableText1('Data Fetching Error', 0,0,0 , "Ubuntu-Bold",
                      SizedConfig.heightAdjust*2.5, Colors.black45)
                );
              }
              else if(snapshot.hasData){
                final users = snapshot.data!;
                if(users.isEmpty){
                  return Center(
                      child: reusableText1('Data Not Available..!!!', 0,0,0 , "Ubuntu-Bold",
                          SizedConfig.heightAdjust*2.5, Colors.black45)
                  );
                }else{
                  return ListView(
                    children: users.map(buildUser).toList(),
                  );
                }
              }
              else{
                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 10.0),
                        Center(
                            child: reusableText1('Please Wait', 0,0,0 , "Ubuntu-Bold",
                                SizedConfig.heightAdjust*2.5, Colors.black45))
                      ],
                    )
                );
              }
            },
          )
        //read operation complete
      ),
    );
  }
}
