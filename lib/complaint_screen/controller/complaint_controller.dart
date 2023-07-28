import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lightonus/complaint_preview_page/view/complaint_preview.dart';
import 'package:lightonus/complaint_screen/model/complaint_model.dart';
import 'package:lightonus/login_register_controller/login_register_controller.dart';
import '../../snackbars/snackbars.dart';

class ComplaintController extends GetxController {
  List<String> complainTypes = [
    'Light Not-Working',
    'Misuse',
    'Bracket Damage /Arm',
    'Light Blinking',
    'Sparking /Short Circuit',
    'light on Dimmer',
    'Pole Damage',
    'Shock on Pole',
    'Pole Shifting Required',
    'Junction Box Damage',
    'Cable Break',
    'Cable Joint Open',
    'Other'
  ];

  final snackbar = SnackBarss();

  TextEditingController selectComplaintController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController poleNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //final phoneController = Get.put(OTPController());
  //final complaintloginRegController = Get.put(LoginRegisterController());

  //String url='';


  //for dropdownbutton
  Rx<List<String>> selectedComplaintsTypes = Rx<List<String>>([]);
  var sc = ComplaintModel(
          complainID: 1,
          selectedComplaints: '',
          maxComplaint: '',
          selectLocationType: '',
          isLocationSelected: false,
          selectedImage: File(''),
          isComplaintSubmitted: false,
          isImgNComplaintLengthEqual: false,
          colrs: const Color(0xdbc4bfbf).value).obs;

  //for select location
  final List<String> selectLocation = ['Current Location', 'Manual Location'];

  //store img in this list
  List imgList = [];
  //picked img
  var imgPicker;
  //store img url;
  List downloadImgUrl=[];

  //img inc.
  //int imgInc = 0;

  //first img
  bool galleryImg=false;
  //second img
  bool cameraImg=false;
  //
  //bool galleryIconColor=false;
  //bool cameraIconColor=false;

  //get emailID
  //String emailidCollection='';

  //instance of firestore
  var fireInstace=FirebaseFirestore.instance;

  @override
  void onInit() {
    renderComplaintID();  //using this fun to get complaint id
    super.onInit();
  }
  void renderComplaintID(){
    //we retrieve specific column
    fireInstace.collection(lastEmail!)
        .get()
        .then((QuerySnapshot querySnapshot){
      for (var doc in querySnapshot.docs) {
        sc.value.complainID = doc['complaintId']; //here i retrieve only complaintID
        sc.value.complainID++;  //inc complaintID
      }
    });
  }

  //for selectLocation Method
  void chooseLocation(var value) {
    sc.value.selectLocationType = value;
    update();
  }

  //for image select in device
  Future getImage(ImageSource imageSource) async {
    //get Image
    try {
      imgPicker = await ImagePicker().pickImage(source: imageSource);  //pick img
      if (imgPicker != null) {
        sc.value.selectedImage = File(imgPicker.path);
        imgList.add(sc.value.selectedImage);
      }
    } catch (e) {
      print('Image Exception = $e');
    }

    if ((selectedComplaintsTypes.value.length == imgList.length)
           || (selectedComplaintsTypes.value.length >= imgList.length)
           || (selectedComplaintsTypes.value.length <= imgList.length)) {

      if ((imgList.length == 1 || imgList.length == 2) && galleryImg==true) {
            sc.value.colrs = const Color(0xff00FF97).value;
            galleryImg=false;
      } else if ((imgList.length == 1 || imgList.length == 2) && cameraImg==true) {
            sc.value.colrs = const Color(0xff00FF97).value;
            cameraImg=false;
      }
    }
    update();
  }

  //upload img and fetch img URL
  Future uploadImage(File image,int i) async {
    var reference = FirebaseStorage.instance
          .ref()
          .child('ComplaintImage')
          .child('img ${sc.value.complainID}($i)');
       var task = reference.putFile(image);
    downloadImgUrl.add(await(await task).ref.getDownloadURL()); //fetch img URL
    print('img url $i=${downloadImgUrl[0].toString()}');
    update();
  }

  //for Maximum Complaint Selection Reached
  void complaintReachedStatus() {
    if (selectedComplaintsTypes.value.length >= 3) {
      sc.value.maxComplaint = 'Maximum Selection Reached.';
      snackbar.snackBar('Select Complaint', 'Maximum Selection Reached.', 1);
    } else if (selectedComplaintsTypes.value.isEmpty) {
      sc.value.maxComplaint = 'Please Select Complaint Types.';
      snackbar.snackBar(
          'Select Complaint', 'Please Select Complaint Types.', 1);
    } else {
      sc.value.maxComplaint = '';
    }
    update();
  }


  //verify enter details if right then goto complaintPreview page
  void verifyDetails() {
    if (selectedComplaintsTypes.value.isNotEmpty &&
        nameController.text.isNotEmpty &&
        poleNumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        imgList.length!=0 && phoneNumberController.text.length == 10) {
      Get.to(ComplaintPreview());
    } else {
      snackbar.snackBar('Fill Details', 'Something Missing', 1);
    }
  }

  @override
  void dispose() {
    imgPicker = null;
    selectComplaintController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    poleNumberController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
