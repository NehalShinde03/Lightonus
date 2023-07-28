class ReportJson{

  final String complaintId;
  final String status;
  final String date;
  final String description;

  ReportJson({
    this.complaintId='',
    this.status='',
    this.date='',
    this.description=''
  });

  //write
  Map<String, dynamic> toJson() => {
    'complaintId':complaintId,
    'status':status,
    'date':date,
    'description':description
  };

  //read
  static ReportJson fromJson(Map<String,dynamic> json) => ReportJson(
    complaintId: json['complaintId'],
    status: json['status'],
    date: json['date'],
    description: json['description']
  );
}