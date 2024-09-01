import 'package:moyen_express/model/sub_category_product/sub_category_product_model.dart';
import 'package:moyen_express/resources/exports/index.dart';

class SubRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<List<Product>?> getSubProducts(
      {required childProductId}) async {
    final response =
        await apiService.getApi("/api/v2/products/category/$childProductId");

    if (response is List) {
      if (kDebugMode) {
        print(response);
      }

      return response.map((item) => Product.fromJson(item)).toList();
    } else {
      return null;
    }
  }

  static Future<double?> getResult({required String currency,required double price}) async {
    try {
      final response =
          await apiService.testApi("/api/convert", quaryParameters: {
        "code": currency,
        "amount": price,
      });

      // Check if the response is not null
      if (response != null) {
        return response; // Return the rate directly
      } else {
        // Handle null response
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
