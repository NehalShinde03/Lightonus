import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/tracking/track_complaint/controller/complaint_track_controller.dart';

import '../../../home_page/home_controller.dart';
import '../../../reusable_widget/reusable_widget.dart';
import '../../../sized_config/sized_config.dart';

class ShowSelectedComplaint extends StatelessWidget {

//  var complaintController = Get.put(ComplaintController());
//  final complaintTrackController = Get.put(ComplaintTrackController());
//  final complaintPreview = Get.put(ComplaintPreviewController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                  margin: EdgeInsets.only(
                    left: SizedConfig.heightAdjust*1,
                    top: SizedConfig.heightAdjust*6,
                  ),
                  width: SizedConfig.heightAdjust*31.25,
                  height: SizedConfig.heightAdjust*46.875,
                  color: const Color(0xff4d4b4b),
                  child: complaintTrackController.sc.value.dispImg2URL.toString()=="No Image".toString()
                  ? Image.network(complaintTrackController.sc.value.dispImg1URL,fit: BoxFit.fill)
                  : PageView(
                    children: [
                      Image.network(complaintTrackController.sc.value.dispImg1URL,fit: BoxFit.fill),
                      Image.network(complaintTrackController.sc.value.dispImg2URL,fit: BoxFit.fill)
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(
                    top: SizedConfig.heightAdjust*4,
                    right: SizedConfig.heightAdjust*3,
                  ),
                  width: double.infinity,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(
                            left: SizedConfig.heightAdjust*2
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //complaint img
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                complaintTrackController.sc.value.dispImg2URL.toString()=="No Image".toString()
                                ? reusableGalleryIcon(Icons.circle,Colors.greenAccent)
                                : Row(
                                  children: [
                                    reusableGalleryIcon(Icons.circle,Colors.greenAccent),
                                    SizedBox(width: SizedConfig.heightAdjust*2),
                                    reusableGalleryIcon(Icons.circle,Colors.greenAccent)
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: SizedConfig.heightAdjust*10),

                      reusableText1('ComplaintID: C${complaintTrackController.sc.value.complaintID}', 0,
                          0, 0 , "Ubuntu-Bold", SizedConfig.txtAdjust * 2.6, const Color(0xff3b3b3b)),

                      SizedBox(height: SizedConfig.heightAdjust*6.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          reusableText1('Date: ${complaintTrackController.sc.value.complaintDate}', 0,
                              0, 0 , "", SizedConfig.txtAdjust * 1.9, const Color(0xff3b3b3b)),

                          reusableText1('Expiry Date: ${complaintTrackController.sc.value.complaintExpDate}', 0,
                              0, 0 , "", SizedConfig.txtAdjust * 1.9, const Color(0xff3b3b3b)),
                        ],
                      ),

                      SizedBox(height: SizedConfig.heightAdjust*2.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          reusableText1('Time: ${complaintTrackController.sc.value.complaintTime}', 0,
                              0, 0 , "", SizedConfig.txtAdjust * 1.9, const Color(0xff3b3b3b)),

                          Obx((){
                            return reusableText1(
                                'Status:  ${complaintTrackController.sc.value.complaintStatus}', 0,
                                SizedConfig.heightAdjust*1.5, SizedConfig.heightAdjust*1.9, "Ubuntu-Bold", SizedConfig.txtAdjust * 1.9,
                                complaintTrackController.sc.value.complaintStatus.toString() == 'in Progress'
                                    ? Colors.red.shade300
                                    : Colors.teal.shade300
                            );
                          })
                        ],
                      ),


                      reusableTextField1('Complaint Types', SizedConfig.widthAdjust * 95,
                          SizedConfig.heightAdjust * 9.1, SizedConfig.widthAdjust * 5.5,
                          Icons.note, complaintTrackController.selectComplaintController, TextInputType.text,
                          50, 3, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                          SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                          OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(30))
                                  .copyWith(bottomRight: const Radius.circular(0)))
                      ),

                      reusableTextField1('Your Name', SizedConfig.widthAdjust * 95,
                          SizedConfig.heightAdjust * 5, SizedConfig.widthAdjust * 5.5,
                          Icons.person, complaintTrackController.nameController, TextInputType.text,
                          50, 1, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                          SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                          OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(30))
                                  .copyWith(bottomRight: const Radius.circular(0)))
                      ),

                      reusableTextField1('Your Phone Number', SizedConfig.widthAdjust * 95,
                          SizedConfig.heightAdjust * 5, SizedConfig.widthAdjust * 5.5,
                          Icons.phone, complaintTrackController.phoneNumberController, TextInputType.text,
                          50, 1, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                          SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                          OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(30))
                                  .copyWith(bottomRight: const Radius.circular(0)))
                      ),

                      reusableTextField1('Pole Number', SizedConfig.widthAdjust * 95,
                          SizedConfig.heightAdjust * 5, SizedConfig.widthAdjust * 5.5,
                          Icons.account_tree, complaintTrackController.poleNumberController, TextInputType.text,
                          50, 1, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                          SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                          OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(30))
                                  .copyWith(bottomRight: const Radius.circular(0)))
                      ),

                      reusableTextField1('Your Address', SizedConfig.widthAdjust * 95,
                          SizedConfig.heightAdjust * 5, SizedConfig.widthAdjust * 5.5,
                          Icons.location_on, complaintTrackController.addressController, TextInputType.text,
                          50, 3, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                          SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                          OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(30))
                                  .copyWith(bottomRight: const Radius.circular(0)))
                      ),


                      SizedBox(height: SizedConfig.heightAdjust * 5.2),
                      complaintTrackController.descriptionController.text.isEmpty
                          ? const SizedBox()
                          : reusableTextField1('Your Description', SizedConfig.widthAdjust * 95,
                          0, SizedConfig.widthAdjust * 5.5,
                          Icons.description, complaintTrackController.descriptionController, TextInputType.text,
                          50, 3, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                          SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                          OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(30))
                                  .copyWith(bottomRight: const Radius.circular(0)))
                      ),


                      SizedBox(height: SizedConfig.heightAdjust*4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          reusableButton('Cancel',() => Get.back()),

                          reusableButton('Delete',(){
                            complaintTrackController.deleteComplaint(complaintTrackController.sc.value.complaintID.toString());
                            homeController.todayTotalComplaint--;
                            Get.back();
                          }),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ));
  }
}
