import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/home_page/drawer_profile.dart';
import 'package:lightonus/home_page/home_controller.dart';
import 'package:lightonus/sized_config/sized_config.dart';
import 'package:lightonus/tracking/complaint_or_newconnection.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../complaint_screen/view/complaint_page.dart';
import '../feedBack/feedBack.dart';
import '../login_register_controller/login_register_controller.dart';
import '../notice/notice.dart';
import '../report/view/submit_view_report.dart';
import '../reusable_widget/reusable_widget.dart';
import '../snackbars/snackbars.dart';

class Home_Page extends StatelessWidget {

  final loginRegController = Get.put(LoginRegisterController());
  final homeController = Get.put(HomeController());
  final snackbar = SnackBarss();

  var currentPage = DrawerSection.dashboard;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool menu_icon = false;
//  String gemail = '';

  List imgList = [
    {'id':1,'img_path':'assets/images/slider_img1.jpg'},
    {'id':2,'img_path': 'assets/images/slider_img2.jpg'},
    {'id':3,'img_path': 'assets/images/card_new_connection.jpg'},
  ];
  CarouselController carouselSlider = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _globalKey,
            drawer: Drawer(
              width: SizedConfig.widthAdjust * 70,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [DrawerProfile(), DrawerList()],
              ),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: SizedConfig.widthAdjust * 100,
                height: SizedConfig.heightAdjust * 181,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25, left: 10),
                      child: IconButton(
                          onPressed: () {
                            menu_icon = true;
                            _globalKey.currentState?.openDrawer();
                          },
                          icon: const Icon(Icons.menu,
                              size: 32, color: Color(0xc0c56c86))),
                    ),

                    reusableText1("Hii, $lastName", SizedConfig.heightAdjust * 4.3,
                        SizedConfig.heightAdjust * 7.5, SizedConfig.heightAdjust * 0 , "Ubuntu-Bold",
                        SizedConfig.txtAdjust * 3.7 , const Color(0xe5355c7d)),

                    //img slider
                    Container(
                      margin: EdgeInsets.fromLTRB(
                               SizedConfig.widthAdjust * 5,
                               SizedConfig.heightAdjust * 12,
                               SizedConfig.widthAdjust * 5,
                               SizedConfig.widthAdjust * 5
                               ),
                         decoration:  BoxDecoration(
                             borderRadius: const BorderRadius.all(Radius.circular(23)),
                             border: Border.all(
                             color: const Color(0xffa8afab),
                             width: 3
                             )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Image border
                        child: CarouselSlider(
                            items: imgList.map(
                                    (item) => Image.asset(
                                  item['img_path'],
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                )
                            ).toList(),
                            options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: true,
                                aspectRatio: 2,
                                viewportFraction: 1,
                            )
                        ),
                      ),
                    ),


                    Container(
                      height: 90,
                      padding: EdgeInsets.fromLTRB(
                        0,
                        SizedConfig.heightAdjust * 2,
                        20,
                        SizedConfig.heightAdjust * 2,
                      ),
                      margin: EdgeInsets.fromLTRB(
                          SizedConfig.widthAdjust * 5,
                          SizedConfig.heightAdjust * 42,
                          SizedConfig.widthAdjust * 5,
                          SizedConfig.widthAdjust * 5),
                      decoration: const BoxDecoration(
                          color: Color(0xffC7CEEA),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border(
                            left: BorderSide(color: Colors.grey),
                            right: BorderSide(color: Colors.grey),
                            top: BorderSide(color: Colors.grey),
                            bottom: BorderSide(color: Colors.grey),
                          )),
                      child: Column(
                        children: [
                          const Text(
                            'you can submit only 2 Complaint within a 7 Day\'s.',
                            style: TextStyle(fontFamily: 'Ubuntu-Regular'),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: SizedConfig.heightAdjust * 3),
                          Obx(() =>
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 1000,
                              lineHeight: 20,
                              percent:
                                 homeController.todayTotalComplaint / 2, /*   (complaint / 2)  ->  homeController.sc.value.todayTotalComplaint / 2  */
                              barRadius: const Radius.circular(10),
                              progressColor: const Color(0xff5b5f97),
                              backgroundColor:
                              const Color(0xff5b5f97).withOpacity(0.5),
                              center: Text(
                                  '${homeController.todayTotalComplaint} / 2', // ->  '${homeController.sc.value.todayTotalComplaint} / 2'
                                  style: const TextStyle(color: Colors.white))
                            )
                          )
                        ],
                      ),
                    ),

                    reusableCards(
                        SizedConfig.heightAdjust*60,SizedConfig.widthAdjust*4,SizedConfig.widthAdjust * 40,
                        'assets/images/card_complaint.jpg', 'Complaint',
                        Colors.white,Colors.white,
                        0.1, 0.2,
                        BoxFit.cover,
                        () {
                            complaintController.imgList.clear();
                            //if todayTotalComplaint is more than 2 then it disp snackbar msg , other wise you can fire a complaint
                            if (homeController.todayTotalComplaint.value >= 2) {
                              snackbar.snackBar('Complaint',
                                  'you can submit only 2 Complaint within a 7 Day\'s.', 2);
                            } else {
                              Get.to(ComplaintPage());
                            }
                        }
                    ),

                    reusableCards(
                        SizedConfig.heightAdjust*60, SizedConfig.widthAdjust*54,SizedConfig.widthAdjust * 40,
                        'assets/images/card_new_connection.jpg', 'New Connection',
                        Colors.white, Colors.white,
                        0.5, 0.3,
                        BoxFit.cover,
                        () => print('>>>>> New Connection')
                    ),

                    reusableCards(
                        SizedConfig.heightAdjust*90, SizedConfig.widthAdjust*5,SizedConfig.widthAdjust * 40,
                        'assets/images/card_track.jpg', 'Track',
                        Colors.green, Colors.grey,
                        0.1, 0.2,
                        BoxFit.fill,
                        () => Get.to(ComplaintORNewConnection())
                    ),

                    reusableCards(
                        SizedConfig.heightAdjust*90, SizedConfig.widthAdjust*54,SizedConfig.widthAdjust * 40,
                        'assets/images/card_feedback.PNG', 'Feedback',
                        Colors.black, Colors.grey,
                        0.5, 0.3,
                        BoxFit.fill,
                        () => Get.to(FeedBack())
                    ),

                    reusableCards(
                        SizedConfig.heightAdjust*120, SizedConfig.widthAdjust*5,SizedConfig.widthAdjust * 40,
                        'assets/images/card_report.jpg', 'Report',
                        Colors.white, Colors.white,
                        0.1, 0.2,
                        BoxFit.fill,
                            () => Get.to(submitViewReport())
                    ),

                    reusableCards(
                        SizedConfig.heightAdjust*120, SizedConfig.widthAdjust*54,SizedConfig.widthAdjust * 40,
                        'assets/images/card_notice.PNG', 'Notice',
                        Colors.white, Colors.white,
                        0.5, 0.3,
                        BoxFit.fill,
                            () => Get.to(const Notice())
                    ),

              Positioned(
                top: SizedConfig.heightAdjust*150,
                left: SizedConfig.heightAdjust*3,
                child: Row(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        width: SizedConfig.heightAdjust*50,
                        height: SizedConfig.heightAdjust * 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/bg.jpg'),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xF89A9797).withOpacity(0.9),
                                blurRadius: 7,
                                offset: const Offset(7.0, 10.0),
                                spreadRadius: 3),
                          ],
                        ),
                        child: Column(
                          children: [

                            reusableText1("For more Information", SizedConfig.heightAdjust * 2.5,
                                SizedConfig.heightAdjust * 3, 0 , "Ubuntu-Bold",
                                SizedConfig.txtAdjust * 3.7 , Colors.white),

                            reusableText1("Name :  Sachin Nagarpalika", SizedConfig.heightAdjust * 4,
                                0, SizedConfig.heightAdjust * 15 , "Ubuntu-Bold",
                                SizedConfig.txtAdjust * 2 , Colors.white),

                            reusableText1("Contact Number : 1234567890 ", SizedConfig.heightAdjust * 1,
                                0, SizedConfig.heightAdjust * 11.5 , "Ubuntu-Bold",
                                SizedConfig.txtAdjust * 2 , Colors.white),

                            reusableText1("Address : Sachin, Surat - 394230 ", SizedConfig.heightAdjust * 1,
                                0, SizedConfig.heightAdjust * 10 , "Ubuntu-Bold",
                                SizedConfig.txtAdjust * 2 , Colors.white),

                          ],
                        )
                      ),
                    ),
                  ],
                ),
              )
                  ],
                ),
              ),
            )
        )
    );
  }

  Widget DrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          menuItem(1, "Dashboard", Icons.developer_board,
              currentPage == DrawerSection.dashboard ? true : false),
          menuItem(2, "Contacts", Icons.people_alt_outlined,
              currentPage == DrawerSection.contact ? true : false),
          const Divider(),
          menuItem(3, "Privacy policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSection.privacy_policy ? true : false),
          menuItem(4, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSection.send_feedback ? true : false),
          const Divider(),
          menuItem(5, "LogOut", Icons.logout_outlined,
              currentPage == DrawerSection.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.back();
          if (id == 1) {
            currentPage = DrawerSection.dashboard;
          } else if (id == 2) {
            currentPage = DrawerSection.contact;
          } else if (id == 3) {
            currentPage = DrawerSection.privacy_policy;
          } else if (id == 4) {
            currentPage = DrawerSection.send_feedback;
          } else if (id == 5) {
            currentPage = DrawerSection.logout;
            loginRegController.signOut();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Text(title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizedConfig.txtAdjust * 2.2)))
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection { dashboard, contact, privacy_policy, send_feedback, logout }
