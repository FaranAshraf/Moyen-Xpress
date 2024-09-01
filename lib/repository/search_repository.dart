import 'package:moyen_express/model/search/search_model.dart';

import '../resources/exports/index.dart';

class SearchRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<List<ProductSearch>?> getSearchProduct(
      {String? searchProduct}) async {
    final response = await apiService.getApi(
      Urls.SEARCH_PRODUCT,
      quaryParameters: {"keyword": searchProduct},
    );
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => ProductSearch.fromJson(item)).toList();
    } else {
      return null;
    }
  }

  static Future<SearchProducts?> productSearch({String? searchProduct}) async {
    try {
      final response = await apiService.getApi(
        Urls.SEARCH_PRODUCT_UPDATE,
        quaryParameters: {"search": searchProduct},
      );

      if (response is Map<String, dynamic>) {
        if (kDebugMode) {
          print(response);
        }
        log.f(response);
        return SearchProducts.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return null;
    }
  }
}
