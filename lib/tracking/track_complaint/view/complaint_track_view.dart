import 'package:flutter/material.dart';
import 'package:lightonus/sized_config/sized_config.dart';
import 'package:lightonus/tracking/track_complaint/view/all_complaint.dart';
import 'package:lightonus/tracking/track_complaint/view/complete_complaint.dart';
import 'package:lightonus/tracking/track_complaint/view/inprogress_complaint.dart';

import '../../../reusable_widget/reusable_widget.dart';

class ComplaintTrack extends StatelessWidget {

//  final tabController = Get.put(ComplaintTrackController());
//  int indx=0;


  TabBar get  _tabbar => const TabBar(
    tabs: [
      Tab(text: 'All'),
      Tab(text: 'In Progress'),
      Tab(text: 'Complete'),
    ],
    //controller: tabController.tabBarController,
    indicator: BoxDecoration(
      color: Color(0xffdacece),
      borderRadius:  BorderRadius.only(
        topRight: Radius.circular(40),
        bottomLeft: Radius.circular(30),
      ),
    ),
    indicatorColor: Color(0xffc93a35),
    labelColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            title:reusableText1('Complaint Status', 0,0,0 , "Ubuntu-Bold",
                SizedConfig.txtAdjust * 3.1, Colors.black87),
            backgroundColor: Colors.white,//const Color(0xff383838),
            bottom: PreferredSize(
              preferredSize: _tabbar.preferredSize,
              child: Material(
                color: Colors.white,//const Color(0xff383838),
                child: _tabbar,
              ),
            )
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              AllComplaint(),
              InProgressComplaint(),
              CompleteComplaint(),
            ],
          ),
        ),
      ),
    );
  }
}
