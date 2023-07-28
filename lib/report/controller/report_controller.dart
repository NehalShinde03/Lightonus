import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/report/controller/report_json.dart';

import '../../application_submitted/success.dart';
import '../../complaint_screen/controller/complaint_controller.dart';
import '../../login_register_controller/login_register_controller.dart';
import '../../snackbars/snackbars.dart';
import '../view/view_report.dart';

class ReportController extends GetxController{

  TextEditingController complaintIDController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final complaintLogRegController = Get.put(LoginRegisterController());
  static var complaintController = Get.put(ComplaintController());

  final snackbar = SnackBarss();
  final fireStoreInstance = FirebaseFirestore.instance;

  assignData(){
    final reportJson = ReportJson(
      complaintId: complaintIDController.text.toString().trim(),
      status: statusController.text.toString().trim(),
      date: dateController.text.toString().trim(),
      description: descriptionController.text.toString().trim()
    );
    insertReport(reportJson);
  }

  insertReport(ReportJson reportJson) async{
    final insertReport = FirebaseFirestore.instance
        .collection('Report')
        .doc('${complaintIDController.text.toString()}) ${lastEmail!}');

    final json = reportJson.toJson();
    await insertReport.set(json);
    Get.off(Success(),arguments: 'Report');
  }

  Stream<List<ReportJson>> readUser() {
    return fireStoreInstance
        .collection('Report')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((e) => ReportJson.fromJson(e.data())).toList());
  }

  //disp data
  Future<String> fetchAllContact(String complaintID) async {
    var documentSnapshot =
    await fireStoreInstance.collection('Report').doc('${complaintID.toString()}) ${lastEmail!}').get();

    complaintIDController.text = documentSnapshot['complaintId'];
    statusController.text = documentSnapshot['status'];
    dateController.text = documentSnapshot['date'].toString();
    descriptionController.text = documentSnapshot['description'];

    update();
    Get.to(ViewReport());
    return '';
  }

  //deletion
  deleteReport(String complaintID) {
    return FirebaseFirestore.instance.
    collection('Report').
    doc('${complaintID.toString()}) ${lastEmail!}')
        .delete();
  }

  detailsVerify(){
    if((complaintIDController.text.isNotEmpty)
        && (statusController.text.isNotEmpty)
        && (dateController.text.isNotEmpty)
        && (descriptionController.text.isNotEmpty)){
      assignData();
    }
    else{
      snackbar.snackBar('Fill Details', 'Something Missing', 1);
    }
  }

  @override
  void dispose(){
    complaintIDController.dispose();
    statusController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

}