import 'package:flutter/material.dart';

import '../../sized_config/sized_config.dart';


class NoConnectionImg extends StatelessWidget {
  const NoConnectionImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            width: SizedConfig.widthAdjust*20,
            height: SizedConfig.heightAdjust*2,
            child: Center(
              child: Image.asset('assets/images/google_imgs.png',scale: SizedConfig.imgAdjust*1.1),
            ),
          ),
        )
    );
  }
}
