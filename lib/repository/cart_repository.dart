import 'package:moyen_express/model/test_model/test_model.dart';
import 'package:moyen_express/model/view_cart/view_cart_model.dart';
import 'package:moyen_express/resources/exports/index.dart';

class CartRepository {
  static LocationsController controller = Get.put(LocationsController());
  static BaseApiServices apiService = NetworkApiServices();
  static String responseApi = "";
  static Future<void> cartAPi({
    required productId,
    required quantity,
    required String color,
    required String size,
    required productType,
  }) async {
    try {
      final response = await apiService.postUpdatedAPI(Urls.ADD_TO_CART, {
        "id": productId,
        "product_type": productType,
        "quantity": quantity,
        "color": color,
        "attribute_id_${controller.attributeId}": size
      });
      log.e("color value after hit: $color");
      log.e("Size value after Hit: $size");
      print('===================add to cart :::: ${response}');
      if (response == 'Item Added To Cart Successfully') {
      CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);}
      else{
        CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.failure);
      }
//  if (response is bool) return;
//  print('bool response ===== ${response}');
// CustomSnackBar.showSnackBar (message: response, snackBarStyle: SnackBarStyle.success);
      responseApi = response;
      
      if (kDebugMode) {
        print(response);
      }
      controller.sizeValue.value = "";
      controller.colorValue.value = "";
      log.w(controller.colorValue.value);
      log.w(controller.sizeValue.value);
    } catch (e) {
      log.e(e);
    }
  }

 static Future<List<CartItem>?> getCartProducts() async {
  final response = await apiService.getApi(Urls.VIEW_CART);

  if (response == null) {
    print('Received a null response.');
    return [];
  }

  if (response is List) {
    try {
      // Attempt to parse the list into CartItem objects
      return response.map((item) => CartItem.fromJson(item)).toList();
    } catch (e) {
      print('Error parsing cart products: $e');
      // Return an empty list on error
      return [];
    }
  } else if (response is Map<String, dynamic>) {
    // Handle case where the response is wrapped in an object
    if (response.containsKey('cartItems') && response['cartItems'] is List) {
      try {
        return (response['cartItems'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();
      } catch (e) {
        print('Error parsing cart items from map: $e');
        return [];
      }
    } else {
      print('Unexpected Map format: $response');
      return [];
    }
  } else {
    print('Unexpected response format or error in fetching cart products: $response');
    return [];
  }
}

  static Future<void> cartQuantity({
    required productId,
    required quantity,
  }) async {
    try {
      final response = await apiService.postUpdatedAPI(Urls.CART_QUANTITY, {
        "id": productId,
        "quantity": quantity,
      });
      if (response is bool) return;
      CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      log.e(e);
    }
  }

  static Future<void> deleteCartProduct({
    required productId,
  }) async {
    try {
      final response =
          await apiService.postUpdatedAPI(Urls.DELETE_CART_PRODUCT, {
        "id": productId,
      });
      if (response is bool) return;
      CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(
          message: e.toString(), snackBarStyle: SnackBarStyle.warning);
      log.e(e);
    }
  }

  static Future<List<DeliveryContent>> deliveryInfoCart({
    required addressId,
  }) async {
    final response = await apiService.postApi("/api/testapi", {
      "address_id": addressId,
     
    });

    if (response == null) {
      throw Exception("Null response received from API");
    }

     if (response is bool) {
    // Handle the boolean response accordingly
    if (response) {
      // Handle the case where the response is true
      log.d("Received a boolean response: true");
      return [];
    } else {
      // Handle the case where the response is false
      log.d("Received a boolean response: false");
      return [];
    }}

    log.d(response);
    if (kDebugMode) {
      print(response);
      log.e(response);
    }

    if (response is List<dynamic>) {
      // List to store parsed delivery response models
      List<DeliveryContent> deliveryResponses = [];

      // Parse each item in the list separately
      for (var item in response) {
        if (item is Map<String, dynamic>) {
          deliveryResponses.add(DeliveryContent.fromJson(item));
        } else {
          // Handle unexpected item format
          throw Exception("Unexpected item format in response list");
        }
      }

      return deliveryResponses;
    } else if (response is Map<String, dynamic>) {
      // If response is a map, parse it as DeliveryResponseModel
      return [DeliveryContent.fromJson(response)];
    } else {
      // Handle unexpected response format
     
      log.e("Unexpected response format: ${response.runtimeType}");
      throw Exception("Unexpected response format");
      
    }
  }

  static Future<void> sendQuotes({
    required cartIds,
  }) async {
    try {
      final response = await apiService.postUpdatedAPI(Urls.SEND_QUOTES, {
        "cart_ids": cartIds,
      });
      if (response is bool) return;
      CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(
          message: e.toString(), snackBarStyle: SnackBarStyle.warning);
      log.e(e);
    }
  }

  static Future<void> updateAndDeleteCart({
    required productId,
  }) async {
    try {
      final response =
          await apiService.postUpdatedAPI(Urls.DELETE_CART_PRODUCT, {
        "id": productId,
      });
      if (response is bool) return;

      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      log.e(e);
    }
  }

  static num? shipCost = 0;
  static Future<int?> getShippingCost() async {
    final response = await apiService.getApi(Urls.SHIPPING_COST);

    if (response is bool) {
      if (kDebugMode) {
        print(response);
      }
    }
    log.d(response);
    shipCost = response;
    return response;
  }

//   static Future<void> storeDeliveryInfo(
//       {required sellerIds, required pickupIds}) async {
//     final response = await apiService.postApi(Urls.STORE_CART_INFO, {
//       "user_products": sellerIds,
//       for (var id in sellerIds)
//         for (var ids in pickupIds) "shipping_type_$id": "$ids",
//     });
//     if (response is bool) return;
//     log.e("test response $response");
//     for (var ids in pickupIds)

//       // ignore: curly_braces_in_flow_control_structures
//       log.e("test response $ids");
//     //  CustomSnackBar.showSnackBar(
//     //   message: response, snackBarStyle: SnackBarStyle.success);
//   }
// }

 static Future<void> storeDeliveryInfo({
  required List<int?> sellerIds,
  required  pickupIds,
  required Map<int, int?> sellerShipWithMoyen, // Map to hold sellerId and its ship_with_moyen ID
}) async {
  // Ensure sellerIds and pickupIds have the same length
  assert(sellerIds.length == pickupIds.length, 
      'sellerIds and pickupIds must have the same length');

  // Construct the basic payload
  final Map<String, dynamic> payload = {
    "user_products": sellerIds,
    for (int i = 0; i < sellerIds.length; i++)
      "shipping_type_${sellerIds[i]}": pickupIds[i],
  };

  // Add shipping_config fields to the payload
  for (var sellerId in sellerIds) {
    final shipWithMoyenId = sellerShipWithMoyen[sellerId];
    if (shipWithMoyenId != null) {
      payload["shipping_config_$sellerId"] = shipWithMoyenId;
    }
  }

  // Print the payload
  log.e("Payload: ${jsonEncode(payload)}");

  try {
    // Make the API request
    final response = await apiService.postApi(Urls.STORE_CART_INFO, payload);

    if (response is bool) return;

    log.e("API response: $response");
  } catch (e) {
    log.e("Error occurred: $e");
  }

  for (var ids in pickupIds) {
    log.e("Pickup ID: $ids");
  }

  // CustomSnackBar.showSnackBar(
  //   message: response, snackBarStyle: SnackBarStyle.success);
}

}
