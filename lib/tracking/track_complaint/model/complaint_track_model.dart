import 'package:flutter/material.dart';

class ComplaintTrackModel{

  String complaintID;
  String complaintStatus;
  Color cr;
  var dispImg1URL;
  var dispImg2URL;
  var complaintDate;
  var complaintExpDate;
  var complaintTime;

  ComplaintTrackModel({
    required this.complaintID,
    required this.complaintStatus,
    required this.cr,
    required this.dispImg1URL,
    required this.dispImg2URL,
    required this.complaintDate,
    required this.complaintExpDate,
    required this.complaintTime,
  });

}