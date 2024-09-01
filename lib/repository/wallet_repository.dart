import 'package:moyen_express/model/wallet/wallet_model.dart';
import 'package:moyen_express/model/withdraw_request/withdraw_request_model.dart';

import '../model/cash_back_history/cashback_history_model.dart';
import '../resources/exports/index.dart';

class WalletRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<WalletModel?> getWalletPrice() async {
    final response = await apiService.getApi(Urls.WALLET);
    if (kDebugMode) {
      print('Response Type: ${response.runtimeType}');
    }
    if (kDebugMode) {
      print('Response: $response');
    }

    if (response is Map<String, dynamic>) {
      if (kDebugMode) {
        print('Debug Response: $response');
      }
      log.e("Response: $response");

      try {
        final walletModel = WalletModel.fromJson(response);
        if (kDebugMode) {
          print('Parsed WalletModel: ${walletModel.walletBalance}');
        }
        return walletModel;
      } catch (e) {
        log.e("Error parsing response: $e");
        if (kDebugMode) {
          print('Error parsing response: $e');
        }
        return null;
      }
    } else {
      if (kDebugMode) {
        print('Response is not a Map<String, dynamic>');
      }
      return null;
    }
  }

  static Future<void> walletRecharge({
    required int userId,
    required String amount,
    required String paymentMethod,
    required String withDrawStatus,
  }) async {
    final response = await apiService.postApi(Urls.WALLET_RECHARGE, {
      "user_id": userId,
      "amount": amount,
      "payment_method": paymentMethod,
      "widthraws_status": withDrawStatus,
    });
    log.e(response);
    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }

  static Future<WalletSuccessContents?> getWithdrawRequest() async {
    final response = await apiService.getApi(Urls.WALLET_WITHDRAW);
    if (kDebugMode) {
      print('Response Type: ${response.runtimeType}');
    }
    if (kDebugMode) {
      print('Response: $response');
    }

    if (response is Map<String, dynamic>) {
      if (kDebugMode) {
        print('Debug Response: $response');
      }
      log.e("Response: $response");

      try {
        final walletModel = WalletSuccessContents.fromJson(response);
        if (kDebugMode) {
          print('Parsed WalletModel: ${walletModel.walletBalance}');
        }
        return walletModel;
      } catch (e) {
        log.e("Error parsing response: $e");
        if (kDebugMode) {
          print('Error parsing response: $e');
        }
        return null;
      }
    } else {
      if (kDebugMode) {
        print('Response is not a Map<String, dynamic>');
      }
      return null;
    }
  }

  static Future<List<CashBackModel>?> getCashBacks() async {
    final response = await apiService.getApi(Urls.CASHBACK_HISTORY);

    if (response is List<dynamic>) {
      return response.map((item) => CashBackModel.fromJson(item)).toList();
    } else {
      if (kDebugMode) {
        print("Unexpected response format: $response");
      }
      return null;
    }
  }

  static Future<void> postWithDraw({
  required String amount,
  required String withDrawType,
  required String stripeId,
  required String message,
  required String payPalId,
  required String bankName,
  required String bankAccName,
  required String bankAccNumber,
  required String bankRoutingNumber,
}) async {
  Map<String, dynamic> requestData = {
    "amount": amount,
    "withdraw_type": withDrawType,
    "message": message,
  };

  switch (withDrawType) {
    case "Stripe":
      requestData["stripe_id"] = stripeId;
      break;
    case "Paypal":
      requestData["paypal_id"] = payPalId;
      break;
    case "Bank Transfer":
      requestData["bank_name"] = bankName;
      requestData["bank_account_name"] = bankAccName;
      requestData["bank_account_number"] = bankAccNumber;
      requestData["bank_routing_number"] = bankRoutingNumber;
      break;
  }

  final response = await apiService.postUpdatedAPI(Urls.WITHDRAW_POST, requestData);
  log.e(response.toString());
  if (response is bool) return;
  log.e(response.toString());
  CustomSnackBar.showSnackBar(
    message: response.toString(),
    snackBarStyle: SnackBarStyle.success,
  );
}
}
