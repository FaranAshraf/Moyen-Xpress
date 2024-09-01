import 'package:moyen_express/repository/notification_repository.dart';

import '../../../dummy/notification_data.dart';
import '../../../resources/exports/index.dart';

class NotificationsController extends GetxController {
  List<NotificationsModel> notifications = [];

  Future<List<NotificationsModel>> getNotifications() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return NotificationsModel.listFromJson(notificationData);
    });
  }

  dynamic getIcon(int type) {
    switch (type) {
      case 0:
        return EneftyIcons.notification_bing_outline;
      case 1:
        return Assets.AUCTION;
      case 2:
        return Assets.REFUND_REQUEST;
      case 3:
        return Assets.SHIP_QUOTE1;
      case 4:
        return Assets.IN_TRANSIT;
      case 5:
        return Icons.message;
      case 6:
        return EneftyIcons.notification_2_bold;
      case 7:
        return Icons.reply_sharp;
      case 8:
        return Icons.list;
      default:
        return EneftyIcons.notification_bing_outline;
    }
  }

  Future<void> getNotification() async {
    await NotificationRepository.getNotifications();
  }

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }
}
