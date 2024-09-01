import 'package:moyen_express/model/wishlist/wishlist_model.dart';

import '../resources/exports/index.dart';

class WishlistRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<void> addToWishList({
    required String productId,
  }) async {
    try {
      final response = await apiService.postUpdatedAPI(Urls.ADD_TO_WISHLIST, {
        "id": productId,
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

  static Future<List<WishItem>?> getWishListProduct() async {
    final response = await apiService.getApi(Urls.VIEW_WISHLIST);

    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      log.e(response);
      return response.map((item) => WishItem.fromJson(item)).toList();
    } else {
      return null;
    }
  }

  static Future<void> deleteWishlistProduct({
    required productId,
  }) async {
    try {
      final response =
          await apiService.postUpdatedAPI(Urls.DELETE_WISHLIST_ITEM, {
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
}
