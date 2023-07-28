import 'package:flutter/material.dart';
import 'package:lightonus/reusable_widget/reusable_widget.dart';
import 'package:lightonus/sized_config/sized_config.dart';

class Notice extends StatelessWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [

              reusableText1('Notice', SizedConfig.heightAdjust * 6.2,
                  0, SizedConfig.heightAdjust * 25 , "Ubuntu-Bold",
                  SizedConfig.txtAdjust * 7.2, Colors.black),


              Padding(
                padding: EdgeInsets.fromLTRB(
                    SizedConfig.heightAdjust*3,
                    SizedConfig.heightAdjust*6,
                    SizedConfig.heightAdjust*3,
                    SizedConfig.heightAdjust*3,
                ),
                child: Container(
                  width: SizedConfig.heightAdjust*55,
                  height: SizedConfig.heightAdjust*20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffC56C86),
                  ),
                  child: Column(
                    children: [

                      reusableText1('Date : 06-05-2023', SizedConfig.heightAdjust * 2.0,
                          SizedConfig.heightAdjust * 28,0 , "Ubuntu-Bold",
                          SizedConfig.txtAdjust * 1.8, Colors.white),

                      reusableText1('Welcome', SizedConfig.heightAdjust * 2.9,
                          0, SizedConfig.heightAdjust * 28 , "Ubuntu-Bold",
                          SizedConfig.txtAdjust * 3.4, Colors.white),

                      reusableText1('- This is auto generated message', SizedConfig.heightAdjust * 2.0,
                          0, SizedConfig.heightAdjust * 6 , "Ubuntu-Bold",
                          SizedConfig.txtAdjust * 2.0, Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          )
        )
    );
  }
}
