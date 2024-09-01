import 'package:moyen_express/model/ship_with_moyen/ship_with_moyen_model.dart';

import '../resources/exports/index.dart';

class ShipWithMoyenRepository {
  static BaseApiServices apiService = NetworkApiServices();

// Adjusting the repository function to return a list of ShippingProducts
  static Future<List<ShippingProducts>?> getShippingProducts() async {
    try {
      final response = await apiService.getApi(Urls.SHIP_PRODUCTS);
      if (kDebugMode) {
        log.e('API Response: $response');
      }
      if (response != null && response is List) {
        return response.map((json) => ShippingProducts.fromJson(json)).toList();
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return null;
    }
  }

  static Future<List<ShippingProducts>?> getDataThroughShipping(
      {required int id}) async {
    try {
      final response =
          await apiService.getApi("/api/appV1/shipping_product_details/$id");
      if (kDebugMode) {
        log.e('Data Response: $response');
      }
      if (response != null && response is List) {
        return response.map((json) => ShippingProducts.fromJson(json)).toList();
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return null;
    }
  }

  

 static Future<void> shipWithMoyenForm({
  required String shipType,
  required String itemType,
  required String shipVia,
  required String fromName,
  required String fromEmail,
  required String fromPhone,
  required String fromCountry,
  required String fromState,
  required String fromCity,
  required String fromPostalCode,
  required String fromBusinessEmail,
  required String fromBusinessPhone,
  required String fromAddress_1,
  required String fromAddress_2,
  required String toName,
  required String toEmail,
  required String toPhone,
  required String toCountry,
  required String toState,
  required String toCity,
  required String toPostalCode,
  required String toBusinessEmail,
  required String toBusinessPhone,
  required String toAddress_1,
  required String toAddress_2,
  required String description,
  required String valueOfItems,
  required String shipmentDate,
  required List<String> productName,
  required List<String> weight,
  required List<String> length,
  required List<String> width,
  required List<String> height,
  required List<String> quantity,
}) async {
  final response = await apiService.postUpdatedAPI(Urls.SHIP_WITH_MOYEN, {
    // from
    "item_type": itemType,
    "ship_type": shipType,
    "ship_via": shipVia,
    "from_name": fromName,
    "from_email": fromEmail,
    "from_phone": fromPhone,
    "from_country": fromCountry,
    "from_state": fromState,
    "from_city": fromCity,
    "from_postal_code": fromPostalCode,
    "from_bussiness_email": fromBusinessEmail,
    "from_bussiness_phone": fromBusinessPhone,
    "from_address_1": fromAddress_1,
    "from_address_2": fromAddress_2,
    // to
    "to_name": toName,
    "to_email": toEmail,
    "to_phone": toPhone,
    "to_country": toCountry,
    "to_state": toState,
    "to_city": toCity,
    "to_postal_code": toPostalCode,
    "to_bussiness_email": toBusinessEmail,
    "to_bussiness_phone": toBusinessPhone,
    "to_address_1": toAddress_1,
    "to_address_2": toAddress_2,
    "product_name": productName,
    "weight": weight,
    "length": length,
    "width": width,
    "height": height,
    "quantity": quantity,
    "description": description,
    "value_of_items": valueOfItems,
    "shipment_date": shipmentDate,
  });

  if (response is bool) return;

  CustomSnackBar.showSnackBar(
      message: response, snackBarStyle: SnackBarStyle.success);
}
}
