import '../model/send_refund_request/send_refund_request_model.dart';
import '../model/send_replace_request/send_replace_request_model.dart';
import '../resources/exports/index.dart';

class SendRefundRequestRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<List<SendRequestModel>?> sendRefundRequest() async {
    final response = await apiService.getApi(Urls.REFUND_REQUEST);
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      log.e("Response : $response");
      return response.map((item) => SendRequestModel.fromJson(item)).toList();
    } else {
      return null;
    }
  }

  static Future<void> updateDropOffStatus({
    required int id,
    required String status,
  }) async {
    final response =
        await apiService.postApi('/api/appV1/updatedropoffstatus/$id', {
      "status": status,
    });
    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }

  static Future<List<SendReplaceRequestModel>?> sendReplaceRequest() async {
    final response = await apiService.getApi('/api/appV1/sentreplacerequest');
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      log.e("Response : $response");
      return response.map((item) => SendReplaceRequestModel.fromJson(item)).toList();
    } else {
      return null;
    }
  }
}
