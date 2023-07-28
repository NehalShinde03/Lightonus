import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/sized_config/sized_config.dart';
import 'package:lightonus/tracking/track_complaint/controller/complaint_track_controller.dart';

import '../complaint_screen/controller/complaint_controller.dart';


final complaintTrackController = Get.put(ComplaintTrackController());
final complaintController = Get.put(ComplaintController());

Widget reusableLoginText1(bool loginOrSignin){
  return Padding(
    padding: EdgeInsets.only(
        top: loginOrSignin ? SizedConfig.heightAdjust*9.2 : SizedConfig.heightAdjust*1.4,
        right: loginOrSignin ? 100 : 90
    ),
    child: Text(
        loginOrSignin ? 'Welcome Back!' : 'Signin to Continue...',
        style: TextStyle(
            fontFamily: "Ubuntu-Bold",
            fontSize: loginOrSignin ?  SizedConfig.txtAdjust*4.4 : SizedConfig.txtAdjust*2.5,
            color: loginOrSignin ? Colors.black : Colors.grey
        )
    ),
  );
}

//for complaint  //ok
Widget reusableText1(String txt, double topPadding, double leftPadding,
    double rightPadding, String fontFamilys, double fontSized, Color color){
  return Padding(
    padding: EdgeInsets.only(
        top: topPadding,
        left: leftPadding,
        right:rightPadding
    ),
    child: Text(
        txt,
        style: TextStyle(
            fontFamily: fontFamilys,
            fontSize: fontSized,
            color: color
        )
    ),
  );
}

// ok
Container reusableTextField1(String text, double width,double topPadding, double leftPadding,
    IconData icon, TextEditingController controller, TextInputType textInputType,
    int maxLength, int maxLines, enable,double fontSized1, String fontFamilies1, Color color1,
    double fontSized2, String fontFamilies2, Color color2, InputBorder inputBorder){

  return  Container(
    width: width,
    padding: EdgeInsets.only(
        left: leftPadding,
        top:topPadding
    ),
    child: TextField(
      controller: controller,
      keyboardType: textInputType,
      maxLines: maxLines,
      enabled: enable,
      maxLength: maxLength,
      style: TextStyle(
          fontSize: fontSized1,
          fontFamily: fontFamilies1,
          color: color1
      ),
      decoration: InputDecoration(
        counterText: '',
        border: inputBorder,
        prefixIcon: Icon(
          icon,
          color: Colors.black45,
        ),
        labelText: text,
        labelStyle: TextStyle(
            fontSize: fontSized2,
            fontFamily: fontFamilies1,
            color: color2
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(width: 1.0, color: Color(0xff34e1ce)),
          borderRadius: const BorderRadius.all(Radius.circular(30)).
          copyWith(bottomRight: const Radius.circular(0)),
        ),
      ),
    ),
  );
}

//ok
Container reusableButton(String txt, Function onTap){
  return Container(
    height: 40,
    width: 90,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.pressed)){
            return  const Color(0xff34e1cd);
          }
          else{
            return Colors.white;
          }
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color:  Color(0xff34e1cd),width: 2, strokeAlign: 1.8))
  )
      ),
      child: Text(
        txt,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}

//ok
Widget reusableCard(Color color, String complaintID, var complaintDate,
    var complaintTime, String complaintStatus, Function onTap){
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.only(
        top: SizedConfig.heightAdjust*1,
        left: SizedConfig.heightAdjust*1,
        right: SizedConfig.heightAdjust*1,
      ),
      width: SizedConfig.widthAdjust*10,
      height: SizedConfig.heightAdjust*23,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
            side: const BorderSide(color: Colors.white)
        ),
        elevation: 20.0,
        child: TextButton (
          onPressed: (){
            onTap();
          },
          child: Row(
            children: [

              Image.asset(
                'assets/images/strees.png',
                color: Colors.white,
                scale: 2,
                alignment: Alignment.centerLeft,
              ),

              Container(
                width: SizedConfig.heightAdjust*34,
                margin: EdgeInsets.only(
                  top: SizedConfig.heightAdjust*4.2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text('Complaint ID : $complaintID',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Itim-Regular",
                            fontSize: SizedConfig.txtAdjust*2.5,
                            fontWeight: FontWeight.w100
                        )),

                    Text('Complaint Date :  $complaintDate',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Itim-Regular",
                            fontSize: SizedConfig.txtAdjust*2.5,
                            fontWeight: FontWeight.w100
                        )),

                    Text('Complaint Time : $complaintTime',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Itim-Regular",
                            fontSize: SizedConfig.txtAdjust*2.5,
                            fontWeight: FontWeight.w100
                        )),

                    Container(
                      margin: EdgeInsets.only(
                          top: SizedConfig.heightAdjust*3,
                          left: SizedConfig.heightAdjust*12
                      ),
                      child: Text('Status : $complaintStatus',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Itim-Regular",
                              fontSize: SizedConfig.txtAdjust*2.5,
                              fontWeight: FontWeight.w100
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

//ok
Icon reusableGalleryIcon(IconData icon,Color c){
  return Icon(icon, color: c, size: 15);
}

//ok
Icon reusableCameraIcon(IconData icon,Color c){
  return Icon(icon, color: c, size: 15);
}

Widget reusableCards(double topPosition, double leftPosition,double width,
    String img,String cardText, Color color, Color colors, double fontTopPadding,
    double fontLeftPadding, BoxFit imgFit, Function onTap){
  return Positioned(
    top: topPosition,
    left: leftPosition,
    child: Row(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            width: width,
            height: SizedConfig.heightAdjust * 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(img),
                fit: imgFit,
              ),
              border: Border(
                right: BorderSide(color: colors),
                left: BorderSide(color: colors),
                top: BorderSide(color: colors),
                bottom: BorderSide(color: colors),
              ),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xF89A9797).withOpacity(0.9),
                    blurRadius: 7,
                    offset: const Offset(7.0, 10.0),
                    spreadRadius: 3),
              ],
            ),
            child: TextButton(
              onPressed: () => onTap(),
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.only(
                    left: SizedConfig.widthAdjust * fontLeftPadding,
                    top: SizedConfig.widthAdjust * fontTopPadding,
                  ),
                  child: Text(cardText,
                      style: TextStyle(
                          color: color,
                          fontSize: SizedConfig.txtAdjust * 3.3,
                          fontFamily: 'Itim-Regular'),
                      textAlign: TextAlign.end)),
            ),
          ),
        ),
      ],
    ),
  );
}

//ok
Widget reusableReportCard(String complaintId, String complaintStatus, String complaintDate,
    String complaintDesc, Function onTap){
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.only(
        top: SizedConfig.heightAdjust*1,
        left: SizedConfig.heightAdjust*1,
        right: SizedConfig.heightAdjust*1,
      ),
      width: double.infinity,
      height: SizedConfig.heightAdjust*17,
      child: Card(
        color: const Color(0xffC56C86),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
            side: const BorderSide(color: Colors.white)
        ),
        elevation: 20.0,
        child: TextButton (
          onPressed: (){
            onTap();
          },
          child: Column(
            children: [

              SizedBox(height: SizedConfig.heightAdjust*2),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Complaint ID : $complaintId',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Itim-Regular",
                        fontSize: SizedConfig.txtAdjust*2.5,
                        fontWeight: FontWeight.w100
                    )),
              ),

              const SizedBox(height: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Complaint Date :  $complaintDate',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Itim-Regular",
                        fontSize: SizedConfig.txtAdjust*2.5,
                        fontWeight: FontWeight.w100
                    )),
              ),

              SizedBox(height: SizedConfig.heightAdjust*2),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('Status : $complaintStatus',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Itim-Regular",
                        fontSize: SizedConfig.txtAdjust*2.5,
                        fontWeight: FontWeight.w100
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}