import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/complaint_screen/controller/complaint_controller.dart';
import 'package:lightonus/login_register_controller/login_register_controller.dart';
import 'package:lightonus/snackbars/snackbars.dart';
import 'package:lightonus/tracking/track_complaint/controller/complaint_track_controller.dart';
import '../../application_submitted/success.dart';
import '../../otp_page/controoler/otp_controller.dart';
import '../model/complaintPreview_Model.dart';
import '../model/complaint_json.dart';

class ComplaintPreviewController extends GetxController {

  final complaintController = Get.put(ComplaintController());
  final complaintLogRegController = Get.put(LoginRegisterController());
//  final trackController = Get.put(ComplaintTrackController());
 // final phoneController = Get.put(OTPController());

  var fireInstace = FirebaseFirestore.instance; //firestore instance create
  //String? insertCollection;
  //final snackbar = SnackBarss();
 // bool isSuccess = false;

  var currentDate = DateTime.now();
  //var times = TimeOfDay.now();
  var sc = ComplaintPreviewModel(
          currDate: '',
          currTime: TimeOfDay.now(),
          expiryDate: '',
          diffDate: '',
          isComplaintSubmitted: false)
      .obs;

  //store temp data to this variable
  assignData() {
    var complainStatus = 'in Progress';
    final user = User(
        complaintId: complaintController.sc.value.complainID,
        selectComplaint:
            complaintController.selectComplaintController.text.trim(),
        name: complaintController.nameController.text.trim(),
        phoneNumber:
            int.parse(complaintController.phoneNumberController.text.trim()),
        poleNumber: complaintController.poleNumberController.text.trim(),
        address: complaintController.addressController.text.trim(),
        description: complaintController.descriptionController.text.trim(),
        imgURL1: complaintController.downloadImgUrl[0].toString(),
        imgURL2: complaintController.downloadImgUrl.length == 2
            ? complaintController.downloadImgUrl[1].toString()
            : 'No Image'.toString(),
        complaintStatus: complainStatus,
        complaintCurrDate: sc.value.diffDate,
        complaintExpDate: sc.value.expiryDate,
        complaintCurrTime: sc.value.currTime
    );
    insertData(user);
  }

  //insert data
  insertData(User user) async {
    final docUser = fireInstace
        .collection(lastEmail!)
        .doc(complaintController.sc.value.complainID.toString());
    user.complaintId = int.parse(docUser.id); //get id
    final json = user.toJson();
    await docUser.set(json);
    complaintController.imgList.clear();
    Get.off(Success(), arguments: 'Complaint');
  }

  @override
  void dispose() {
    complaintController.dispose();
    complaintLogRegController.dispose();
    complaintController.downloadImgUrl.clear();
    complaintController.imgList.clear();
    super.dispose();
  }
}
