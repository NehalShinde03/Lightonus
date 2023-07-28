import 'dart:io';
class ComplaintModel{

  int complainID;
  String selectedComplaints;
  String maxComplaint;
  String selectLocationType;
  bool isLocationSelected;
  bool isComplaintSubmitted;
  File selectedImage;
  bool isImgNComplaintLengthEqual;
  int colrs;

  ComplaintModel({required this.complainID,
                  required this.selectedComplaints, required this.maxComplaint,
                  required this.selectLocationType, required this.isLocationSelected,
                  required this.selectedImage,required this.isComplaintSubmitted,
                  required this.isImgNComplaintLengthEqual, required this.colrs});

}