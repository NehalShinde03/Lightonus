import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../complaint_preview_page/model/complaint_json.dart';
import '../../../complaint_screen/controller/complaint_controller.dart';
import '../../../login_register_controller/login_register_controller.dart';
import '../model/complaint_track_model.dart';
import '../view/show_selected_complaint.dart';

//class ComplaintTrackController extends GetxController{
class ComplaintTrackController extends GetxController with GetSingleTickerProviderStateMixin{

  static var complaintController = Get.put(ComplaintController());
  final loginRegister = Get.put(LoginRegisterController());


  final selectComplaintController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final poleNumberController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  final fireStoreInstance = FirebaseFirestore.instance;

  var sc = ComplaintTrackModel(
    complaintID: complaintController.sc.value.complainID.toString(),
    complaintStatus:'',
    cr: Colors.red.shade300,
    dispImg1URL: null,
    dispImg2URL: null,
    complaintDate: '',
    complaintExpDate: '',
    complaintTime: '',
  ).obs;

//fetch data
  Stream<List<User>> readUser() {
    print('===============================${loginRegister.gemail}');
    return fireStoreInstance
        .collection(loginRegister.gemail)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((e) => User.fromJson(e.data())).toList());
  }

  //disp data
  Future<String> fetchAllContact(String complaintID) async {
    var documentSnapshot =
    await fireStoreInstance.collection(lastEmail!).doc(complaintID.toString()).get();

    selectComplaintController.text = documentSnapshot['selectComplaint'];
    nameController.text = documentSnapshot['name'];
    phoneNumberController.text = documentSnapshot['phoneNumber'].toString();
    poleNumberController.text = documentSnapshot['poleNumber'];
    addressController.text = documentSnapshot['address'];
    descriptionController.text = documentSnapshot['description'];

    sc.value.dispImg1URL = documentSnapshot['imgURL1'];
    sc.value.dispImg2URL = documentSnapshot['imgURL2'];

    sc.value.complaintDate = documentSnapshot['date'];
    sc.value.complaintExpDate = documentSnapshot['expDate'];
    sc.value.complaintTime = documentSnapshot['time'];

    update();
    Get.to(ShowSelectedComplaint());
    return '';
  }

  //deletion
  deleteComplaint(String complaintID) {
    return FirebaseFirestore.instance.
    collection(lastEmail!).
    doc(complaintID.toString())
        .delete();
  }

  @override
  void dispose(){
     selectComplaintController.dispose();
     nameController.dispose();
     phoneNumberController.dispose();
     poleNumberController.dispose();
     addressController.dispose();
     descriptionController.dispose();
     super.dispose();
  }

}