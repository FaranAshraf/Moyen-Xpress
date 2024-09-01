import 'package:moyen_express/model/store/store_model.dart';

import '../resources/exports/index.dart';

class StoreRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<StoreDetail?> getStoreDetail({required int storeId }) async {
    final response = await apiService.getApi(
      "/api/appV1/store/details",
      quaryParameters: {"store_id":storeId}
    );

    if (response is bool) return null;
    // if (kDebugMode) {
    //   print(response);
    // }
    // log.d(response);
    return StoreDetail.fromJson(response);
  }
}
