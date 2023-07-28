import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/login_register_controller/login_register_controller.dart';
import '../home_page/home_page.dart';
import '../reusable_widget/reusable_widget.dart';
import '../sized_config/sized_config.dart';

class InfoPagesCall extends StatelessWidget {

   final pageController=PageController();
   final loginRegisterController = LoginRegisterController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff1b1b1b),
                    Color(0xff222021)
                  ]
              ),
            ),
            child: PageView(
              controller: pageController,
              children: [

                //introduction page
                Stack(
                  children: [

                  Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(bottom: SizedConfig.heightAdjust*1,
                          right: SizedConfig.widthAdjust*3),
                      child: InkWell(
                        child:
                        reusableText1('Skip', 0, 0, 0 , 'Itim-Regular',
                            SizedConfig.txtAdjust * 2.8 , Colors.grey),

                        onTap: () {
                          pageController.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.ease
                          );
                        },
                      )
                  ),

                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(right: SizedConfig.widthAdjust*3),
                      child: Image.asset('assets/images/info_introduction.png')
                  ),


                    Align(
                      alignment: Alignment.centerLeft,
                      child: reusableText1('Introduction', SizedConfig.heightAdjust*35,
                          SizedConfig.widthAdjust*4, 0 , 'Itim-Regular',
                          SizedConfig.txtAdjust * 3.7 , const Color(0xffF6FCFC)),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: reusableText1('The Lightonus App, Which helps'
                          '\nPeople to Submit their Complaint'
                          '\nregarding Street Light, apply to '
                          '\nthe New Connection for Street\nLight.',
                          SizedConfig.heightAdjust*57,SizedConfig.widthAdjust*7,
                          0 , 'Itim-Regular', SizedConfig.txtAdjust * 2.4 ,
                          const Color(0xffe5b5c9)),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: reusableText1('People can also Track their'
                          '\nComplaint and application '
                          '\napply for New Connection.',
                          SizedConfig.heightAdjust*85,SizedConfig.widthAdjust*7,
                          0 , 'Itim-Regular', SizedConfig.txtAdjust * 2.4 ,
                          const Color(0xffe5b5c9)),
                    ),
                  ],
          ),

                //complaint page
                Stack(
                  children: [

                    Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(bottom: SizedConfig.heightAdjust*1,
                            right: SizedConfig.widthAdjust*3),
                        child: InkWell(
                          child: reusableText1('Skip', 0, 0, 0 , 'Itim-Regular',
                              SizedConfig.txtAdjust * 2.8 , Colors.grey),
                          onTap: () {
                           pageController.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease
                            );
                          },
                        )
                    ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(right: SizedConfig.widthAdjust*11),
                        child: Image.asset('assets/images/info_complaint.png',
                          height: 300,width: 300,)
                    ),

                    reusableText1('Complaint',
                        SizedConfig.heightAdjust*25,SizedConfig.widthAdjust*17,
                        0 , 'Itim-Regular', SizedConfig.txtAdjust * 3.7 ,
                        const Color(0xfffee9e1)),

                    reusableText1('using Lightonus App, General Public can Submit their'
                        ' Complaint regarding Street lights.',
                        SizedConfig.heightAdjust*31,SizedConfig.widthAdjust*22,
                        0 , 'Itim-Regular', SizedConfig.txtAdjust * 2.4 ,
                        const Color(0xffb09e99)),

                  ],
          ),

                //new connection page
                Stack(
                  children: [

                    Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(bottom: SizedConfig.heightAdjust*1,
                            right: SizedConfig.widthAdjust*3),
                        child: InkWell(
                          child: reusableText1('Skip', 0, 0, 0 , 'Itim-Regular',
                              SizedConfig.txtAdjust * 2.8 , Colors.grey),
                          onTap: () {
                            pageController.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease
                            );
                          },
                        )
                    ),

                    Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(right: SizedConfig.widthAdjust*11),
                        child: Image.asset('assets/images/info_new_connection.png',
                          height: 300,width: 300,)
                    ),

                    reusableText1('New Connection',
                        SizedConfig.heightAdjust*25,SizedConfig.widthAdjust*16,
                        0 , 'Itim-Regular', SizedConfig.txtAdjust * 3.7 ,
                        const Color(0xffBEE4F8)),

                    reusableText1('using Lightonus App, General Public Apply application for New Connection.',
                        SizedConfig.heightAdjust*31,SizedConfig.widthAdjust*19,
                        0 , 'Itim-Regular', SizedConfig.txtAdjust * 2.4 ,
                        const Color(0xffFFCAE3)),

                  ],
          ),

                //track page
                Stack(
                  children: [

                    Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(bottom: SizedConfig.heightAdjust*1,
                            right: SizedConfig.widthAdjust*3),
                        child: InkWell(
                          child: reusableText1('Next', 0, 0, 0 , 'Itim-Regular',
                              SizedConfig.txtAdjust * 2.8 , Colors.grey),
                          onTap: () => Get.off(Home_Page()),
                        )
                    ),

                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(right: SizedConfig.widthAdjust*0),
                        child: Image.asset('assets/images/info_track.jpg',
                          height: 300,width: 300,)
                    ),

                    reusableText1('Tracking',
                        SizedConfig.heightAdjust*25,SizedConfig.widthAdjust*16,
                        0 , 'Itim-Regular', SizedConfig.txtAdjust * 3.7 ,
                        const Color(0xffD3E7F3)),

                    reusableText1('using Lightonus App, General Public can\n'
                        'Track your Complaint and application\n'
                        'apply for New Connection.',
                        SizedConfig.heightAdjust*31,SizedConfig.widthAdjust*22,
                        0 , 'Itim-Regular', SizedConfig.txtAdjust * 2.4 ,
                        const Color(0xffB2D8ED)),
                  ],
          )

              ],
            ),
          ),
        )
    );
  }
}