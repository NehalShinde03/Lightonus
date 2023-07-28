import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lightonus/complaint_preview_page/controller/complaintPreview_controller.dart';
import 'package:lightonus/complaint_screen/controller/complaint_controller.dart';
import 'package:lightonus/complaint_screen/view/complaint_page.dart';
import 'package:lightonus/login_register_controller/login_register_controller.dart';
import 'package:lightonus/otp_page/controoler/otp_controller.dart';
import 'package:lightonus/reusable_widget/reusable_widget.dart';
import 'package:lightonus/snackbars/snackbars.dart';
import '../../otp_page/view/enter_otp.dart';
import '../../sized_config/sized_config.dart';

class ComplaintPreview extends StatelessWidget {

  var complaintController = Get.put(ComplaintController());
  final phoneController = Get.put(OTPController());
  final loginRegister=Get.put(LoginRegisterController());
  final complaintPreview=Get.put(ComplaintPreviewController());
  final snackbar = SnackBarss();

  @override
  Widget build(BuildContext context) {

    complaintController.selectComplaintController.text =
        complaintController.selectedComplaintsTypes.value.toString().substring(
            1,
            complaintController.selectedComplaintsTypes.value
                    .toString()
                    .length -
                1);

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //Preview Complaint Details
            reusableText1('Preview Complaint Details.', SizedConfig.heightAdjust * 8.2,
                SizedConfig.heightAdjust * 2, 0, "Ubuntu-Bold",
                SizedConfig.txtAdjust * 3.2, Colors.black),

            //please verify your details
            reusableText1('Please Verify your Details...', SizedConfig.heightAdjust * 1.5,
                SizedConfig.heightAdjust * 4.5, 0, "Ubuntu-Regular",
                SizedConfig.txtAdjust * 2.2, Colors.grey),

            //disp complaint id
            reusableText1('ComplaintID : C${complaintController.sc.value.complainID}', SizedConfig.heightAdjust * 10,
                SizedConfig.heightAdjust * 6, 0, "Itim-Regular",
                SizedConfig.txtAdjust * 2.6, const Color(0xff3b3b3b)),

            //Selected Complaints
            SizedBox(height: SizedConfig.heightAdjust * 2.0),
            reusableTextField1('Selected Complaints', SizedConfig.widthAdjust * 95,
                SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                Icons.note, complaintController.selectComplaintController, TextInputType.text,
                50, 3, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30))
                    .copyWith(bottomRight: const Radius.circular(0)))
            ),

            //Name
            SizedBox(height: SizedConfig.heightAdjust * 5.2),
            reusableTextField1('Your Name', SizedConfig.widthAdjust * 95,
                0, SizedConfig.widthAdjust * 5.5,
                Icons.person, complaintController.nameController, TextInputType.text,
                50, 1, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30))
                        .copyWith(bottomRight: const Radius.circular(0)))
            ),


            //Phone Number
            SizedBox(height: SizedConfig.heightAdjust * 5.2),
            reusableTextField1('Your Phone Number', SizedConfig.widthAdjust * 95,
                0, SizedConfig.widthAdjust * 5.5,
                Icons.phone, complaintController.phoneNumberController, TextInputType.text,
                50, 1, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30))
                        .copyWith(bottomRight: const Radius.circular(0)))
            ),

            //Pole Number
            SizedBox(height: SizedConfig.heightAdjust * 5.2),
            reusableTextField1('Your Pole Number', SizedConfig.widthAdjust * 95,
                0, SizedConfig.widthAdjust * 5.5,
                Icons.account_tree, complaintController.poleNumberController, TextInputType.text,
                50, 1, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30))
                        .copyWith(bottomRight: const Radius.circular(0)))
            ),

            //address
            SizedBox(height: SizedConfig.heightAdjust * 5.2),
            reusableTextField1('Your Address', SizedConfig.widthAdjust * 95,
                0, SizedConfig.widthAdjust * 5.5,
                Icons.location_on, complaintController.addressController, TextInputType.text,
                50, 3, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30))
                        .copyWith(bottomRight: const Radius.circular(0)))
            ),

            //for complaint description
            SizedBox(height: SizedConfig.heightAdjust * 5.2),
            complaintController.descriptionController.text.isEmpty
                ? const SizedBox()
                : reusableTextField1('Complaint Description', SizedConfig.widthAdjust * 95,
                0, SizedConfig.widthAdjust * 5.5,
                Icons.description, complaintController.descriptionController, TextInputType.text,
                50, 3, false, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.grey,
                SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45,
                OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30))
                        .copyWith(bottomRight: const Radius.circular(0)))
            ),

            //disp msg for select img
            reusableText1('Selected Image :', SizedConfig.heightAdjust * 7.5,
                SizedConfig.heightAdjust * 5.5, 0, "Itim-Regular",
                SizedConfig.txtAdjust * 2.3, Colors.black45),


            //disp img
            SizedBox(height: SizedConfig.heightAdjust*4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //complaint img
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    complaintController.imgList.length==1 || complaintController.imgList.length==2
                        ? Obx(() => reusableGalleryIcon(Icons.circle,Color(complaintController.sc.value.colrs)))
                        : reusableGalleryIcon(Icons.circle,const Color(0xdbc4bfbf)),
                    reusableText1('First Image', 0, SizedConfig.heightAdjust*1, 0, "Ubuntu-Regular",
                        SizedConfig.txtAdjust * 2, Colors.grey),
                  ],
                ),
                Row(
                  children: [
                    complaintController.imgList.length==2
                        ? Obx(() => reusableCameraIcon(Icons.circle,Color(complaintController.sc.value.colrs)))
                        : reusableCameraIcon(Icons.circle,const Color(0xdbc4bfbf)),
                    reusableText1('Second Image', 0, SizedConfig.heightAdjust*1, 0, "Ubuntu-Regular",
                        SizedConfig.txtAdjust * 2, Colors.grey),
                  ],
                ),

              ],
            ),

            //submit bun
            SizedBox(height: SizedConfig.heightAdjust * 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                //goto ComplaintPage and set otp countDown value to 0
                reusableButton('Cancel',() {
                  phoneController.otpControl.value.start=0;
                  Get.to(ComplaintPage());
                }),

                reusableButton('Next',(){
                  //if img are not uploaded then disp this msg
                  if(complaintController.downloadImgUrl.toString().isEmpty){
                    snackbar.snackBar('Image Uploaded','please wait...',1);
                  }
                  else{
                    complaintPreview.sc.value.diffDate = DateFormat('dd-MM-yyyy').format(DateTime.now()); //fetch currDate and set
                    complaintPreview.sc.value.currDate =
                    complaintPreview.currentDate.add(const Duration(hours: 48)); //add 48 hours in currDate
                    complaintPreview.sc.value.expiryDate =  DateFormat('dd-MM-yyyy').format(complaintPreview.sc.value.currDate); //set Complaint expiry Date
                    complaintPreview.sc.value.currTime=   DateFormat("HH:mm a").format(complaintPreview.sc.value.currDate); //set currTime

                    phoneController.verifyPhone(complaintController.phoneNumberController.text);  //verify phone.no for otp verification
                    complaintPreview.sc.value.isComplaintSubmitted = true;
                    Get.to(Enter_OTP(), arguments: complaintController.phoneNumberController.text); //goto Enter_OTP screen and pass arg as a phone number

                  }
                }),
              ],
            )
          ],
        ),
      ),
    ));
  }
}