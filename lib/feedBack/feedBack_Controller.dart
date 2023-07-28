import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lightonus/complaint_preview_page/controller/complaintPreview_controller.dart';
import 'package:lightonus/feedBack/feedback_json.dart';
import '../login_register_controller/login_register_controller.dart';

class FeedBackController extends GetxController{

  //final complaintPreviewController = Get.put(ComplaintPreviewController());
  final complaintLogRegController = Get.put(LoginRegisterController());
  TextEditingController feedBackController = TextEditingController();

 assignData(){
    final feedbackJson = FeedbackJson(
      feedBack: feedBackController.text.toString().trim()
    );
   insertFeedBack(feedbackJson);
  }

  insertFeedBack(FeedbackJson feedbackJson) async{
    final insertFeedBack = FirebaseFirestore.instance
                       .collection('FeedBacks')
                       .doc(lastEmail!);

    final json = feedbackJson.toJson();
    await insertFeedBack.set(json);
   print('insertion success');
  }

  @override
  void dispose(){
    feedBackController.clear();
    super.dispose();
  }
}