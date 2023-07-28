class ComplaintPreviewModel{

  var currDate;
  var currTime;
  var times;
  var expiryDate;
  var diffDate;
  bool isComplaintSubmitted;


  ComplaintPreviewModel({
    required this.currDate,
    required this.currTime,
    required this.expiryDate,
    required this.diffDate,
    required this.isComplaintSubmitted
  });
}