import '../resources/exports/index.dart';

class NotificationRepository {
  static BaseApiServices apiService = NetworkApiServices();
   static Future<List<NotificationsModel>?> getNotifications() async {
    final response = await apiService.getApi(Urls.NOTIFICATIONS);

    if (response is List) {
      if (kDebugMode) {
        // print(response);
        log.e(response);
      }
        log.e(response);

      return response.map((item) => NotificationsModel.fromJson(item)).toList();
    } else {
      return null;
    }
  }
}