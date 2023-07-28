import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lightonus/complaint_preview_page/view/complaint_preview.dart';
import 'package:lightonus/complaint_screen/controller/complaint_controller.dart';
import 'package:lightonus/gmap/controller/gmap_controller.dart';
import 'package:lightonus/home_page/home_page.dart';
import 'package:lightonus/otp_page/controoler/otp_controller.dart';
import 'package:lightonus/reusable_widget/reusable_widget.dart';
import 'package:multiselect/multiselect.dart';
import '../../sized_config/sized_config.dart';
import '../../snackbars/snackbars.dart';

class ComplaintPage extends StatelessWidget {

  var complaintController = Get.put(ComplaintController());
  final phoneController = Get.put(OTPController());
  var gmap = Get.put(GmapController());
  final snackbar = SnackBarss();
  final  _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //for selectLocationType
    return SafeArea(
        child: Scaffold(
      body: GetBuilder<ComplaintController>(
        builder: (_){
          return SingleChildScrollView(
            child: Form(
                key: _globalKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //disp Complaint msg
                    reusableText1('Complaint', SizedConfig.heightAdjust * 8.2,
                        SizedConfig.heightAdjust * 2, 0 , "Ubuntu-Bold",
                        SizedConfig.txtAdjust * 7.4, Colors.black),

                    //disp fill details msg
                    reusableText1('Fill Details', SizedConfig.heightAdjust * 13.9,
                        SizedConfig.heightAdjust * 4.9, SizedConfig.heightAdjust * 25 , "Ubuntu-Bold",
                        SizedConfig.txtAdjust * 2.8 , Colors.black),

                    //disp Please fill complaint details msg
                    reusableText1('Please fill complaint details.', SizedConfig.heightAdjust * 1.7,
                        SizedConfig.heightAdjust * 4.9, SizedConfig.heightAdjust * 24.5 , "Ubuntu-Bold",
                        SizedConfig.txtAdjust * 1.8, Colors.black45),

                    //disp Note : you can select at most 2 complaint. msg
                    reusableText1('Note : you can select at most 2 complaint.', SizedConfig.heightAdjust * 4,
                        SizedConfig.heightAdjust * 14, 0, "",
                        SizedConfig.txtAdjust * 1.7, const Color(0xfff69c6c)),


                    //Select Complaint Types
                    Container(
                        width: SizedConfig.widthAdjust * 65,
                        padding: EdgeInsets.only(left: SizedConfig.widthAdjust * 2),
                        margin: EdgeInsets.all(SizedConfig.heightAdjust * 2),
                        child: DropDownMultiSelect(
                          options: complaintController.complainTypes,
                          whenEmpty: 'Select Complaint Types',
                          onChanged: (complaint) {
                            complaintController.selectedComplaintsTypes.value = complaint as List<String>;
                            complaintController.sc.value.selectedComplaints = '';
                            for (var element in complaintController
                                .selectedComplaintsTypes.value) {
                              complaintController.sc.value.selectedComplaints =
                              element;

                            }
                          },
                          selectedValues:
                          complaintController.selectedComplaintsTypes.value,  //select complaint store in selectedValues
                          hintStyle: const TextStyle(
                            color: Colors.black45,
                            fontFamily: 'Itim-Regular'
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1.0, color: Color(0xff34e1ce)),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(30))
                                  .copyWith(
                                  bottomRight: const Radius.circular(0)),
                            ),
                          ),
                        )
                    ),

                    //max complaint reached
                    reusableText1(complaintController.sc.value.maxComplaint, 0,
                        SizedConfig.heightAdjust * 22, 0, "",
                        SizedConfig.txtAdjust * 1.5, const Color(0xffff0000)),


                    //Enter Name
                    reusableTextField1( 'Enter Name', SizedConfig.widthAdjust * 95,
                      SizedConfig.widthAdjust * 5, SizedConfig.widthAdjust * 5.5,
                        Icons.person, complaintController.nameController, TextInputType.text,
                        40, 1, true, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', const Color(0xff5e5e5e),
                        SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                    ),

                    //enter phone number
                    reusableTextField1( 'Enter Phone Number', SizedConfig.widthAdjust * 95,
                        SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                        Icons.phone, complaintController.phoneNumberController, TextInputType.number,
                        10, 1, true, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', const Color(0xff5e5e5e),
                        SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                    ),

                    //enter pole number
                    reusableTextField1( 'Enter Pole Number', SizedConfig.widthAdjust * 95,
                        SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                        Icons.account_tree, complaintController.poleNumberController, TextInputType.text,
                        5, 1, true,SizedConfig.txtAdjust * 2.6, 'Itim-Regular', const Color(0xff5e5e5e),
                        SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                    ),

                    //Select Location Type
                    reusableText1('Select Location Type : ', SizedConfig.heightAdjust * 4,
                        SizedConfig.heightAdjust * 5, 0, "",
                        SizedConfig.txtAdjust * 2.3, Colors.black),

                    //current or manual
                    Container(
                      margin: const EdgeInsets.only(left: 45),
                      padding: EdgeInsets.only(top: SizedConfig.heightAdjust * 1),
                      child: Row(
                        children: [
                          addRadioBun(0, 'Current Location'),
                          addRadioBun(1, 'Manual Location'),
                        ],
                      ),
                    ),

                    //enter address
                    Container(
                      width: SizedConfig.widthAdjust * 95,
                      padding: EdgeInsets.only(
                          left: SizedConfig.widthAdjust * 5.5,
                          top: SizedConfig.heightAdjust*2),
                      child: complaintController.sc.value.isLocationSelected
                          ? reusableTextField1( 'Enter Address', 0,0,0,
                          Icons.location_on, complaintController.addressController, TextInputType.text,
                          251, 3, true,SizedConfig.txtAdjust * 2.5, 'Itim-Regular', const Color(0xff5e5e5e),
                          SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                      )
                          : null,
                    ),

                    //Enter Complaint Description
                    reusableTextField1( 'Enter Complaint Description', SizedConfig.widthAdjust * 95,
                        SizedConfig.widthAdjust * 7, SizedConfig.widthAdjust * 5.5,
                        Icons.description, complaintController.descriptionController, TextInputType.text,
                        50, 3, true, SizedConfig.txtAdjust * 2.6, 'Itim-Regular', const Color(0xff5e5e5e),
                        SizedConfig.txtAdjust * 2.3, 'Itim-Regular', Colors.black45, InputBorder.none
                    ),

                    //complaint img
                    Row(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: SizedConfig.heightAdjust*8.2,
                              top: SizedConfig.heightAdjust*5),
                          child: Container(
                              width: SizedConfig.widthAdjust*40.3,
                              height: SizedConfig.heightAdjust*38,
                              decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: Colors.grey),
                                    right: BorderSide(color: Colors.grey),
                                    top: BorderSide(color: Colors.grey),
                                    bottom: BorderSide(color: Colors.grey),
                                  )
                              ),
                              child: complaintController.imgPicker==null
                                  ?  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.camera_alt_outlined,color: Colors.grey,size: 100),
                                  Text(
                                      'Take Image / Capture Image',
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu-Bold',
                                          fontSize: SizedConfig.txtAdjust*1.5,
                                          color: Colors.grey
                                      ))
                                ],
                              )
                                  : Image.file(complaintController.sc.value.selectedImage,fit: BoxFit.fill)
                          ),
                        ),

                        SizedBox(width: SizedConfig.widthAdjust*8),
                        Column(
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    )
                                ),
                                onPressed: () {
                                  complaintController.galleryImg=true;
                                  complaintController.getImage(ImageSource.gallery);
                                },
                                child: const Text('Gallery',style: TextStyle(color: Colors.white))
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    )
                                ),
                                onPressed: () {
                                  complaintController.cameraImg=true;
                                  complaintController.getImage(ImageSource.camera);
                                  // .whenComplete(() {
                                  //   complaintController.uploadImage(
                                  //     complaintController.sc.value.selectedImage
                                  //   );
                                  // });
                                },
                                child: const Text('Camera',style: TextStyle(color: Colors.white))
                            ),

                            Container(
                              width: SizedConfig.heightAdjust*15,
                              height: SizedConfig.heightAdjust*4.5,
                              margin: EdgeInsets.only(top: SizedConfig.heightAdjust*8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  complaintController.imgList.length==1 || complaintController.imgList.length==2
                                      ? Obx(() => reusableGalleryIcon(Icons.circle,Color(complaintController.sc.value.colrs)))
                                      : reusableGalleryIcon(Icons.circle,const Color(0xdbc4bfbf)),
                                  Text(
                                      ' First Image',
                                      style: TextStyle(
                                          fontSize: SizedConfig.txtAdjust*2,
                                          fontFamily: 'Ubuntu-Regular',
                                          color: Colors.grey
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              width: SizedConfig.heightAdjust*17,
                              height: SizedConfig.heightAdjust*4.5,
                              padding: EdgeInsets.only(left: SizedConfig.heightAdjust*1,top: SizedConfig.heightAdjust*1),
                              child: Row(
                                children: [
                                  complaintController.imgList.length==2
                                      ? Obx(() => reusableCameraIcon(Icons.circle,Color(complaintController.sc.value.colrs)))
                                      : reusableCameraIcon(Icons.circle,const Color(0xdbc4bfbf)),
                                  Text(
                                      ' Second Image',
                                      style: TextStyle(
                                          fontSize: SizedConfig.txtAdjust*2,
                                          fontFamily: 'Ubuntu-Regular',
                                          color: Colors.grey
                                      ))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: SizedConfig.heightAdjust*6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        reusableButton('Cancel',(){
                          complaintController.selectedComplaintsTypes.value.length=0;
                          complaintController.nameController.text='';
                          complaintController.phoneNumberController.text='';
                          complaintController.poleNumberController.text='';
                          complaintController.addressController.text='';
                          complaintController.descriptionController.text='';
                          complaintController.imgList.clear();
                          phoneController.otpControl.value.start=0;
                          Get.to(Home_Page());
                        }),

                        reusableButton('Next',(){
                          complaintController.complaintReachedStatus();
                          if(complaintController.selectedComplaintsTypes.value.length == complaintController.imgList.length){
                            for(int i=0 ; i<(complaintController.imgList.length) ; i++) {
                              complaintController.uploadImage(
                                  complaintController.imgList[i],i
                              );
                            }
                          }
                          else{
                            snackbar.snackBar('Incorrect', 'Check Image or Complaint Selection', 1);
                          }
                          complaintController.verifyDetails();
                        }),
                      ],
                    )
                  ],
                )
            ),
          );
        },
      )
    ));
  }

  Row addRadioBun(int index, String title) {
    return Row(
      children: [
       Radio(
            value: complaintController.selectLocation[index],
            groupValue: complaintController.sc.value.selectLocationType,
            onChanged: (value) {
              index==0
                  ? complaintController.addressController.text=gmap.address.value
                  : complaintController.addressController.text='';
              complaintController.chooseLocation(value);
              complaintController.sc.value.isLocationSelected = true;
            },
          ),
        Text(
          title,
          style: const TextStyle(color: Color(0xff5e5e5e)),
        ),
      ],
    );
  }
}