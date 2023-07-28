import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lightonus/login_register_controller/login_register_controller.dart';

class HomeController extends GetxController{

  final complaintloginRegController = Get.put(LoginRegisterController());
  var currDate=DateFormat('dd-MM-yyyy').format(DateTime.now());

  var todayTotalComplaint = 0.obs;
  var getDate = DateTime.now().obs;
  var parseCurrDate = DateTime.now().obs;
  var complaintEndingDate = DateTime.now().obs;

  //get date in every complaint
   @override
  void onInit(){
     super.onInit();
     numberOfComplaint();
   }

   //if complaint status is inProgress the inc the todayTotalComplaint, otherwise dec
  void numberOfComplaint(){
    FirebaseFirestore.instance
        .collection(lastEmail!)
        .get()
        .then((QuerySnapshot querySnapshot){
      for (var doc in querySnapshot.docs) {

        if(doc['complaintStatus'] == 'in Progress'){
          getDate( DateFormat('dd-MM-yyyy').parse(doc['date'])); //parse complaint date
          parseCurrDate.value = DateFormat('dd-MM-yyyy').parse(currDate); // parse currDate
          complaintEndingDate.value =  getDate.value.add(const Duration(hours: 168)); //add 7 days in complaint

          if((getDate.value.isBefore(parseCurrDate.value) ||
              getDate.value.isAtSameMomentAs(parseCurrDate.value))
              &&
              (complaintEndingDate.value.isAfter(parseCurrDate.value) ||
                  complaintEndingDate.value.isAtSameMomentAs(parseCurrDate.value)))
          {
            todayTotalComplaint.value++;
            update();
            print('total = ${todayTotalComplaint.value}');
            print('total/2 = ${todayTotalComplaint.value/2}');
          }
        }
        else{
          if((doc['complaintStatus'] == 'Complete') && (todayTotalComplaint.value > 0)) {
            todayTotalComplaint.value--;
          }
        }

        /*it check every complaint date between fireDate and endDate (and the time period is 7 days or firedate + 7 days = endDate),
        suppose new complaint fire and in weeek i already fire 2 new complaint then it show you have already 2 complaint fire
        means per week you can fire only 2 complaint...*/
      }
    });
  }
}