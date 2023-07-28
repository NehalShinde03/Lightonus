class User{

  //using this variable data are store in firestore
  int complaintId;
  final String selectComplaint;
  final String name;
  final int phoneNumber;
  final String poleNumber;
  final String address;
  final String description;
  final String imgURL1;
  final String imgURL2;
  final String complaintStatus;
  var complaintCurrDate;
  var complaintExpDate;
  var complaintCurrTime;

  //pass or store value constructor
  User({
    this.complaintId=0,
    this.selectComplaint='',
    this.name='',
    this.phoneNumber=0,
    this.poleNumber='',
    this.address='',
    this.description='',
    this.imgURL1='',
    this.imgURL2='',
    this.complaintStatus='',
    this.complaintCurrDate,
    this.complaintExpDate,
    this.complaintCurrTime
  });

  //write
  Map<String, dynamic> toJson() => {
    'complaintId':complaintId,
    'selectComplaint':selectComplaint,
    'name':name,
    'phoneNumber':phoneNumber,
    'poleNumber':poleNumber,
    'address':address,
    'description':description,
    'imgURL1':imgURL1,
    'imgURL2':imgURL2,
    'complaintStatus':complaintStatus,
    'date':complaintCurrDate,
    'expDate':complaintExpDate,
    'time':complaintCurrTime
  };


  //read
  static User fromJson(Map<String,dynamic> json) => User(
    complaintId: json['complaintId'],
    selectComplaint: json['selectComplaint'],
    name: json['name'],
    phoneNumber: json['phoneNumber'],
    poleNumber: json['poleNumber'],
    address: json['address'],
    description: json['description'],
    imgURL1: json['imgURL1'],
    imgURL2: (json['imgURL2']),
    complaintStatus: (json['complaintStatus']),
    complaintCurrDate: (json['date']),
    complaintExpDate: (json['expDate']),
    complaintCurrTime: (json['time']),
  );

}