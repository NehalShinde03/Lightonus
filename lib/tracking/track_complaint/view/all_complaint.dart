import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/complaint_preview_page/controller/complaintPreview_controller.dart';
import 'package:lightonus/reusable_widget/reusable_widget.dart';
import 'package:lightonus/sized_config/sized_config.dart';

import '../../../complaint_preview_page/model/complaint_json.dart';
import '../../../home_page/home_controller.dart';
import '../controller/complaint_track_controller.dart';


class AllComplaint extends StatelessWidget {

//  final loginRegister = Get.put(LoginRegisterController());
  final complaintPreview = Get.put(ComplaintPreviewController());
//  var complaintController = Get.put(ComplaintController());
  final complaintTrackController = Get.put(ComplaintTrackController());
  final homeController = Get.put(HomeController());

  var cID;

  //read complaintID,date,time and status and disp in this widget
  Widget buildUser(User user) {
    Color cr=Colors.red.shade300;
    if(user.complaintStatus=='in Progress'){
            cr=Colors.red.shade300;
    }
    if(user.complaintStatus=='Complete'){
            cr=Colors.teal.shade300;
            // if(homeController.todayTotalComplaint > 0){
            //   homeController.todayTotalComplaint--;
            // }
    }
    cID=user.complaintId.toString();
    return reusableCard(cr, 'C${user.complaintId.toString()}',
          user.complaintCurrDate.toString(),user.complaintCurrTime.toString(),user.complaintStatus.toString(),(){
                  complaintTrackController.sc.value.complaintID=user.complaintId.toString();
                  complaintTrackController.sc.value.complaintStatus=user.complaintStatus.toString();
                  complaintPreview.sc.value.currDate;
                  complaintPreview.sc.value.currTime;
                  complaintTrackController.fetchAllContact(complaintTrackController.sc.value.complaintID);
        });
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
             return reusableText1('Data Fetching Error', 0,0,0 , "Ubuntu-Bold",
                 SizedConfig.heightAdjust*2.5, Colors.black45);
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
                     reusableText1('Please Wait', 0,0,0 , "Ubuntu-Bold",
                         SizedConfig.heightAdjust*2.5, Colors.black45)
                   ],
                 )
             );
           }
         },
       )
       ),
      );
  }
}
