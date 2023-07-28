import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lightonus/firebase_options.dart';
import 'package:lightonus/network_connectivity_check/controller/network_controller.dart';
import 'package:lightonus/splash_screen/splash_screen.dart';

import 'login_register_controller/login_register_controller.dart';
import 'network_connectivity_check/model/network_model.dart';
import 'network_connectivity_check/no_connected_img/no_connected_img.dart';
import 'sized_config/sized_config.dart';
import 'snackbars/snackbars.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() => LoginRegisterController());


  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'high importance',
      channelName: 'basic notification',
      channelDescription: 'notification desc',
      importance: NotificationImportance.Max,
      channelShowBadge: true,
      onlyAlertOnce: true,
      playSound: true,
      criticalAlerts: true,
    )
  ],debug: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final snackbar = SnackBarss();
  final NetworkController _networkController = Get.put(NetworkController());
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizedConfig().init(constraints,orientation);
            return GetMaterialApp(
              initialBinding: NetworkModel(),
              navigatorKey: navigatorKey,
              defaultTransition: Transition.zoom,
              debugShowCheckedModeBanner: false,
                home: GetBuilder<NetworkController>(builder: (builder) {
                      if(_networkController.connectionStatus==0){
                        return const NoConnectionImg();
                      }
                      else{
                        return const SplashScreen();
                      }
                })
                );
          },
        );
      },
    );
  }
}
