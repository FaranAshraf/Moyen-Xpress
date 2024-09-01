import 'package:moyen_express/model/purchase_history/purchase_history_detail_model.dart';

import '../model/purchase_history/purchase_history_model.dart';
import '../resources/exports/index.dart';

class PurchaseRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<List<OrderHistory>?> getPurchaseHistory() async {
    final response = await apiService.getApi(Urls.PURCHASE_HISTORY);
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      log.e("Response: $response");
      return response.map((item) => OrderHistory.fromJson(item)).toList();
    } else {
      return null;
    }
  }


   static Future<PurchaseHistoryDetail?> getPurchaseDetail({required dynamic id}) async {
  final response = await apiService.getApi("/api/appV1/purchase_history_detail/$id");
  if (response != null) {
    if (kDebugMode) {
      print(response);
    }
    log.e("Response: $response");
    return PurchaseHistoryDetail.fromJson(response);
  } else {
    return null;
  }
}

}
