import '../resources/exports/index.dart';

class AuctionRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<void> placeBid({
    required String productId,
    required String amount,
  }) async {
    final response = await apiService.postUpdatedAPI(Urls.PLACE_BID, {
      "product_id": productId,
      "amount": amount,
    });
    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }

  static Future<void> placeAutoBid({
    required String productId,
    required String increasePerBid,
    required String maxBidAmount,
    required String amount,
  }) async {
    final response = await apiService.postUpdatedAPI(Urls.PLACE_AUTO_BID, {
      "product_id": productId,
      "increase_per_bid": increasePerBid,
      "max_bid_amount": maxBidAmount,
      "amount": amount,
    });
    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }
}
