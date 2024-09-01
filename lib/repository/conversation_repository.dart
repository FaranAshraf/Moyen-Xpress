import '../resources/exports/index.dart';

class ConversationRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<void> conversationSeller({
    required String productId,
    required String title,
    required String message,
  }) async {
    final response = await apiService
        .postUpdatedAPI(Urls.CONVERSATION_SELLER, {}, quaryParameters: {
      "receiver_id": productId,
      "title": title,
      "message": message,
    });
    log.e(response);
    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }
}
