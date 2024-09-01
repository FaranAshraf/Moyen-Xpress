import 'package:path_provider/path_provider.dart';

import '../model/order_done_model/order_done_model.dart';
import '../model/payment/payment_model.dart';
import '../resources/exports/index.dart';
import 'package:http/http.dart' as http;

class PaymentRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static final PaymentMethodController _payController =
      Get.put(PaymentMethodController());
  static calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  static createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          'Authorization': 'Bearer ${FlutterConfig.get('STRIPE_SECRET')}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      log.w('payment Intent Body: ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      log.e('err changing user: ${err.toString()}');
    }
  }

  static dynamic id;

  static Future<void> paymentSuccess() async {
    try {
      // Ensure id is not null before making the API call
      if (id == null) {
        // Handle the case where id is null
        // You can log an error or show a message to the user
        return;
      }

      final response = await apiService.postUpdatedAPI(Urls.PAYMENT_SUCCESS, {
        "combined_order_id": id.toString(),
        "payment_type": 'cart_payment',
      });
      if (response is bool) return;
      CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);
      if (kDebugMode) {
        print("Message: $response");
      }
      // Reset id after successful payment
      id = null;
    } catch (e) {
      log.e(e);
    }
  }

  static dynamic orderId;
  static Future<void> placeOrderStore() async {
    try {
      final response = await apiService.postPaymentApi1(Urls.PLACE_ORDER, {
        "payment_type": 'stripe',
        "is_escrow": _payController.isEscrowChecked.value
      });
      if (response is bool) return;
      if (kDebugMode) {
        print("place Order: ${response.toString()}");
      }
      orderId = response; // Assign orderId after successfully placing the order
      log.e("place Order:: ${response.toString()}");

      // Call paymentSuccess after updating orderId
      await paymentSuccess();
      // log.e(response);
    } catch (e) {
      log.e(e);
    }
  }

  static Future<OrderDone?> getDoneConfirmation({required dynamic id}) async {
    try {
      final response = await apiService.getApi("/api/appV1/order-confirmation",
          quaryParameters: {"id": id.toString()});
      // if (kDebugMode) {
      // print('API Response: $response');
      // }
      // log.e(response);
      return OrderDone.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  static Future<PaymentSuccess?> getPayment() async {
    try {
      final response = await apiService.getApi(Urls.PAYMENT_SERVICES);

      if (response is Map<String, dynamic>) {
        log.e(response);
        return PaymentSuccess.fromJson(response);
      } else {
        if (kDebugMode) {
          print('Unexpected response type: ${response.runtimeType}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching API response: $e');
      }
      return null;
    }
  }

  static int combineId = 0;
  static NetworkApiServices networkApiServices = NetworkApiServices();

// Method to perform a wire transfer
  static Future<void> wireTransfer({
    required String paymentMethod,
    required String imageName,
    required File? ssAttachment,
  }) async {
    try {
      // Reset combineId to zero at the start of each method call
      combineId = 0;
      log.f("Test1 $combineId");

      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      String filePath = '$tempPath.png';
      File signatureFile = File(filePath);
      await signatureFile.writeAsBytes(await ssAttachment!.readAsBytes());

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://moyenxpress.com/api/checkout'),
      )
        ..headers.addAll(NetworkApiServices.generateHeaders())
        ..fields['payment_option'] = paymentMethod
        ..files.add(
          await http.MultipartFile.fromPath(
            imageName,
            signatureFile.path,
          ),
        );

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(responseBody);
        if (kDebugMode) {
          print("response: ${responseData['message']}");
        }
        combineId = responseData['combined_order_id'];
        log.f("wireTransfer response ID: $combineId");
        CustomSnackBar.showSnackBar(
          message: responseData['message'],
          snackBarStyle: SnackBarStyle.success,
        );
      } else {
        String errorMessage = 'Failed to add signature';
        if (responseBody.isNotEmpty) {
          errorMessage = responseBody;
        }
        CustomSnackBar.showSnackBar(
          message: errorMessage,
          snackBarStyle: SnackBarStyle.success,
        );
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(
        message: e.toString(),
        snackBarStyle: SnackBarStyle.warning,
      );
    }
    log.f("Test2 $combineId");
  }

// Method to perform wallet API transaction
  static Future<void> walletApi({
    required String paymentOption,
  }) async {
    try {
      final response = await apiService.postPaymentApi(
        '/api/checkout',
        {
          "payment_option": paymentOption,
        },
      );

      // Handle different response scenarios
      if (response == false) {
        CustomSnackBar.showSnackBar(
          message: 'Payment failed or an error occurred.',
          snackBarStyle: SnackBarStyle.warning,
        );
        log.e("wallet: $combineId");
        return;
      }

      // Ensure response is of the correct type
      if (response is num) {
        combineId = response.toInt(); // Update combineId if it's a number
        log.e("Combined Order ID: $combineId");
        CustomSnackBar.showSnackBar(
          message: "Your order has been placed successfully",
          snackBarStyle: SnackBarStyle.success,
        );
      } else {
        CustomSnackBar.showSnackBar(
          message: 'Unexpected response type.',
          snackBarStyle: SnackBarStyle.warning,
        );
      }
    } catch (e) {
      log.e("Error: $e");
      CustomSnackBar.showSnackBar(
        message: "An error occurred",
        snackBarStyle: SnackBarStyle.warning,
      );
    }
  }

  static Future<void> paypalApi({
    required String paymentOption,
    required String orderID,
  }) async {
    try {
      final response = await apiService.postPaymentApi(
        '/api/checkout',
        {
          "payment_option": paymentOption,
          "orderID": orderID,
        },
      );

      // Handle different response scenarios
      if (response == false) {
        CustomSnackBar.showSnackBar(
          message: 'Payment failed or an error occurred.',
          snackBarStyle: SnackBarStyle.warning,
        );
        log.e("wallet: $combineId");
        return;
      }

      // Ensure response is of the correct type
      if (response is num) {
        combineId = response.toInt(); // Update combineId if it's a number
        log.e("Combined Order ID: $combineId");
        CustomSnackBar.showSnackBar(
          message: "Your order has been placed successfully",
          snackBarStyle: SnackBarStyle.success,
        );
      } else {
        CustomSnackBar.showSnackBar(
          message: 'Unexpected response type.',
          snackBarStyle: SnackBarStyle.warning,
        );
      }
    } catch (e) {
      log.e("Error: $e");
      CustomSnackBar.showSnackBar(
        message: "An error occurred",
        snackBarStyle: SnackBarStyle.warning,
      );
    }
  }
}
