import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/feedBack/feedBack_Controller.dart';
import '../application_submitted/success.dart';
import '../reusable_widget/reusable_widget.dart';
import '../sized_config/sized_config.dart';
import '../snackbars/snackbars.dart';

class FeedBack extends StatelessWidget {

  var feedBackControl = Get.put(FeedBackController());
  final snackbar = SnackBarss();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: SizedConfig.heightAdjust * 54.6),
                      child: Image.asset(
                          'assets/images/nft.png',fit: BoxFit.fill,
                          alignment: Alignment.topCenter,cacheHeight: 200),
                    ),
                    Container(
                        width: SizedConfig.widthAdjust * 90,
                        height: SizedConfig.heightAdjust * 55,
                        decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xff34e1cd),
                                  Color(0xff57c9ec),
                                ]
                            ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(2.0,1.0)
                          )
                        ]
                      ),
                      child: Column(
                        children: [

                          reusableText1('Feedback', SizedConfig.heightAdjust * 4,
                              0, SizedConfig.heightAdjust * 14 , "Ubuntu-Bold",
                              SizedConfig.txtAdjust * 6.0, Colors.white),

                          reusableText1('Tell us about your experience :', SizedConfig.heightAdjust * 10,
                              0, SizedConfig.heightAdjust * 5 , "Ubuntu-Regular",
                              SizedConfig.txtAdjust * 2.5, Colors.white),

                          reusableTextField1( 'Your FeedBack...', SizedConfig.widthAdjust * 80,
                              SizedConfig.widthAdjust * 5, SizedConfig.widthAdjust * 1,
                              Icons.feedback, feedBackControl.feedBackController, TextInputType.text,
                              138, 5, true, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', Colors.black,
                              SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black54, InputBorder.none
                          ),

                        ],
                      ),
                    ),
                    Positioned(
                      top: SizedConfig.heightAdjust * 77,
                      child: Container(
                        width: SizedConfig.heightAdjust * 10,
                        height: SizedConfig.heightAdjust * 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xffe0e5e5),
                            width: 3
                          ),
                          boxShadow:[
                            BoxShadow(
                                color: const Color(0xF89A9797).withOpacity(0.9),
                                blurRadius:7,
                                offset: const Offset(5.0,5.0),
                                spreadRadius: 4
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: const EdgeInsets.only(right: 21,bottom: 21),
                            icon: Icon(Icons.telegram,size: SizedConfig.heightAdjust*9.3, color: Color(0xff34e1cd)),
                           onPressed: () {
                              if(feedBackControl.feedBackController.text.toString().isNotEmpty){
                                feedBackControl.assignData();
                                Get.off(Success(),arguments: 'FeedBack');
                              }else{
                                snackbar.snackBar('Lightonus','Do not allowed Empty FeedBack ',1);
                              }
                           },
                        ),
                      )
                    )
                  ],
                ),
              )
            ),
          ),
        )
    );
  }
}

