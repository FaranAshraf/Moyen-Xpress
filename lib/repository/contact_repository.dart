import '../resources/exports/index.dart';

class ContactRepository {
  static BaseApiServices apiService = NetworkApiServices();
    static Future<void> contactUs({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    final response = await apiService.postUpdatedAPI(Urls.CONTACT_US, {
      "name": name,
      "email": email,
      "phone": phone,
      "message": message,
    });
    if (response is bool) return;
     CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);
  }




    static Future<void> oneRequestMultipleQuote({
    required String productName,
    required String description,
    required String quantity,
    required String place,
    required String message,
  }) async {
    final response = await apiService.postUpdatedAPI(Urls.SHIP_MOYEN, {
      "product_name": productName,
      "description": description,
      "quantity": quantity,
      "quantity_type": place,
      "delivery_address": message,
    });
    if (response is bool) return;
     CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);
  }
}