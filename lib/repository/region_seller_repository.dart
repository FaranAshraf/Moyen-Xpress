import '../model/region_seller_model/region_seller_model.dart';
import '../resources/exports/index.dart';

class RegionSellerRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<List<RegionSeller?>> getRegionSeller() async {
    final response = await apiService.getApi(Urls.REGION_SELLER,quaryParameters: {
      "module_key":"country"
    });

    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => RegionSeller.fromJson(item)).toList();
    } else {
      return response;
    }
  }

    static Future<List<RegionSeller?>> getRegionSellerStore() async {
    final response = await apiService.getApi(Urls.REGION_SELLER_STORES,quaryParameters: {
      "module_key":"country"
    });

    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => RegionSeller.fromJson(item)).toList();
    } else {
      return response;
    }
  }
}
