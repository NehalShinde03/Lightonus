import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:lightonus/tracking/track_newconnection/view/newconn_track_view.dart';

class NotificationService{

  static Future<void> initializeNotification() async{
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async{
      if(!isAllowed){
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'high importance group',
        title: "Lightonus",
        body: "Complaint-ID : 01 Successfully Completed...",
        wakeUpScreen: true,
        fullScreenIntent: true,
        criticalAlert: true,
      ),
    );

    AwesomeNotifications().actionStream.listen((event) {
      Get.to(const NewConnTrack());
    });
  }
}

// class NotificationService {
//
//   static Future<void> initializeNotification() async {
//     await AwesomeNotifications().initialize(
//         null,
//         [
//           NotificationChannel(
//               channelGroupKey: 'high importance group',
//               channelKey: 'high importance group',
//               channelName: 'Basic notification',
//               channelDescription: 'notification description test',
//               defaultColor: Colors.purple,
//               ledColor: Colors.black,
//               importance: NotificationImportance.Max,
//               channelShowBadge: true,
//               onlyAlertOnce: true,
//               playSound: true,
//               criticalAlerts: true
//           )
//         ],
//         channelGroups: [
//           NotificationChannelGroup(
//               channelGroupName: 'ground',
//               channelGroupkey: 'high importance channel group'
//           )
//         ],
//         debug: true
//     );
//
//     await AwesomeNotifications().isNotificationAllowed().then(
//             (isAllowed) async {
//           if (!isAllowed) {
//             await AwesomeNotifications().requestPermissionToSendNotifications();
//           }
//         }
//     );
//   }
//
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('disp');
//   }
//
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     debugPrint('dismiss');
//   }
//
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('creste');
//   }
//
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     print('receiiveds1');
//     debugPrint('receivedddd');
//     final payload = receivedAction.payload ?? {};
//     if (payload['navigate'] == 'true') {
//       MyApp.navigatorKey.currentState?.push(
//           Get.to(const NewConnTrack()) as Route<Object?>
//       );
//     }
//     print('receiiveds2');
//   }
//
//
//   static Future<void> showNotification({
//     required final String title,
//     required final String body,
//     final String? summary,
//     final Map<String, String>? payload,
//     final NotificationLayout notificationLayout = NotificationLayout.Default,
//     final NotificationCategory? category,
//     final String? bigPicture,
//     final List<NotificationActionButton>? actionButton,
//     final bool schedule = false,
//     var interval
//   }) async {
//     assert(!schedule || (schedule && interval == null));
//
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: -1,
//             channelKey: 'high importance group',
//             title: title,
//             body: body,
//             notificationLayout: notificationLayout,
//             summary: summary,
//             category: category,
//             payload: payload,
//             bigPicture: bigPicture
//         ),
//         actionButtons: actionButton,
//         schedule: schedule
//             ? NotificationInterval(
//                     interval: interval,
//                     timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//                     preciseAlarm: true
//     )
//         :null
//     );
//   }
// }