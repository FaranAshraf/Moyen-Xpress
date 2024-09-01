// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:moyen_express/model/view_cart/view_cart_model.dart';
// import 'package:moyen_express/model/wallet/wallet_model.dart';
// import 'package:moyen_express/repository/payment_repository.dart';
// // import 'package:moyen_express/utils/summary_sheet.dart';

// import '../../../dummy/order_overview_data.dart';
// import '../../../model/payment/payment_model.dart';
// import '../../../repository/wallet_repository.dart';
// import '../../../resources/exports/index.dart';
// import '../../helpers/global_helper/currency_conversion.dart';

// class PaymentMethodController extends GetxController {
//   late TextEditingController additionalInfoCtrl;
//   int selectedIndex = -1;
//   double totalPrice = 0.0;

//   OrderOverViewModel orderData = OrderOverViewModel();

//   void toggleSelectedIndex(int index) {
//     selectedIndex = index;
//     update(["update_selected_index"]);
//   }

//   // Future<void> makePayment(BuildContext context) async {
//   //   try {
//   //     int totalPriceInt = totalPrice.toInt();
//   //     log.d(totalPriceInt);
//   //     paymentIntent = await PaymentRepository.createPaymentIntent(
//   //         totalPriceInt.toString(), 'USD');
//   //     await Stripe.instance
//   //         .initPaymentSheet(
//   //             paymentSheetParameters: SetupPaymentSheetParameters(
//   //                 paymentIntentClientSecret: paymentIntent!['client_secret'],
//   //                 style: ThemeMode.dark,
//   //                 merchantDisplayName: 'MOYENXPRESS'))
//   //         .then((value) {});
//   //     // ignore: use_build_context_synchronously
//   //     displayPaymentSheet(context);
//   //   } catch (e, s) {
//   //     log.e('exception:$e$s');
//   //   }
//   // }
// Future<void> makePayment(BuildContext context) async {
//   try {
//     int totalPriceInt = totalPrice.toInt();
//     log.d(totalPriceInt);

//     // Show loading indicator
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return const Center(child: CircularProgressIndicator());
//       },
//     );

//     // Create payment intent and initialize payment sheet
//     paymentIntent = await PaymentRepository.createPaymentIntent(
//         totalPriceInt.toString(), 'USD');
//     await Stripe.instance
//         .initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//                 paymentIntentClientSecret: paymentIntent!['client_secret'],
//                 style: ThemeMode.dark,
//                 merchantDisplayName: 'MOYENXPRESS'))
//         .then((value) {});

//     // Hide loading indicator
//     Navigator.pop(context); // Dismiss the loading dialog

//     // Display payment sheet
//     displayPaymentSheet(context);
//   } catch (e, s) {
//     Navigator.pop(context); // Dismiss the loading dialog
//     log.e('exception:$e$s');
//   }
// }

//   calculateShippingCost(List<CartItem> cartItems) {
//     // Create a map to store the last shipping cost for each owner_id
//     Map ownerShippingCosts = {};

//     // Iterate through cartItems to find the last shipping cost for each owner_id
//     for (var item in cartItems) {
//       if (item.shippingCost != null && item.ownerId != null) {
//         ownerShippingCosts[item.ownerId.toString()] = item.shippingCost!;
//       }
//     }

//     // Calculate total shipping cost using the last shipping cost for each owner_id
//     RxDouble totalShippingCost = 0.0.obs;
//     ownerShippingCosts.forEach((ownerId, cost) {
//       totalShippingCost.value += cost;
//     });

//     return totalShippingCost.value;
//   }

//   Map<String, dynamic>? paymentIntent;
//   // displayPaymentSheet(BuildContext context) async {
//   //   try {
//   //     await Stripe.instance.presentPaymentSheet().then((value) {
//   //       PaymentRepository.placeOrderStore();
//   //       // PaymentRepository.placeOrderStore1();
//   //       Future<void> paymentSuccess() async {
//   //         await PaymentRepository.paymentSuccess();
//   //         await Get.toNamed(Routes.CONFIRM_ID,
//   //             arguments: {"id": PaymentRepository.combineId});
//   //       }

//   //       paymentSuccess();
//   //       paymentIntent = null;
//   //     }).onError((error, stackTrace) {
//   //       log.e('Error is:--> $error $stackTrace');
//   //     });
//   //   } on StripeException catch (e) {
//   //     if (kDebugMode) {
//   //       log.e("Error is:--> $e");
//   //     }
//   //     // ignore: use_build_context_synchronously
//   //     showDialog(
//   //         context: context,
//   //         builder: (_) => const AlertDialog(
//   //               content: Text("Cancelled"),
//   //             ));
//   //   } catch (e) {
//   //     if (kDebugMode) {
//   //       print(e);
//   //     }
//   //   }
//   // }
// displayPaymentSheet(BuildContext context) async {
//   try {
//     await Stripe.instance.presentPaymentSheet().then((value) {
//       PaymentRepository.placeOrderStore();
//       Future<void> paymentSuccess() async {
//         await PaymentRepository.paymentSuccess();
//         await Get.toNamed(Routes.CONFIRM_ID, arguments: {"id": PaymentRepository.combineId});
//       }

//       paymentSuccess();
//       paymentIntent = null;
//     }).onError((error, stackTrace) {
//       log.e('Error is:--> $error $stackTrace');
//     });
//   } on StripeException catch (e) {
//     if (kDebugMode) {
//       log.e("Error is:--> $e");
//     }
//     Navigator.pop(context); // Dismiss the loading dialog

//     showDialog(
//       context: context,
//       builder: (_) => const AlertDialog(
//         content: Text("Cancelled"),
//       ),
//     );
//   } catch (e) {
//     if (kDebugMode) {
//       print(e);
//     }
//     Navigator.pop(context); // Dismiss the loading dialog
//   }
// }

//   PaymentSuccess? testValue;
//   String walletPrice = "";
//   Future<void> getPaymentValue() async {
//     try {
//       testValue = await PaymentRepository.getPayment();

//       walletPrice = testValue!.balance.toString();
//       update(); // Update the UI only when necessary
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching payment details: $e');
//       }
//     }
//   }

//   final CurrencyConversionController conversionController =
//       Get.put(CurrencyConversionController());
//   WalletModel? _walletModel;
//   Future<WalletModel?> getPaymentAmount() async {
//     _walletModel = await WalletRepository.getWalletPrice();
//     log.e("Wallet Check kr $_walletModel");
//     log.e(_walletModel?.walletBalance);
//     return _walletModel;
//   }

//   List<PaymentMethodModel> methods = [];
//   void initializePaymentMethods(BuildContext context) {
//     methods = [
//       PaymentMethodModel(
//         id: 0,
//         icon: Assets.CARD_PAYMENT,
//         title: "Card Payment",
//         color: AppColors.stripe,
//         onTap: () {
//           makePayment(context);
//           toggleSelectedIndex(0);
//         },
//       ),
//       PaymentMethodModel(
//           id: 1,
//           icon: Assets.WALLET,
//           title:
//               "Pay By Wallet (${conversionController.convertCurrencyAmt(amount: _walletModel?.walletBalance).value} ${conversionController.currentCurrency.value})",
//           color: AppColors.stripe,
//           onTap: () {
//             showDialog(
//                 context: Get.context!,
//                 builder: (ctx) => AlertDialog(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20)),
//                       contentPadding: const EdgeInsets.all(15.0),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const SpaceH10(),
//                           Text(
//                             'Are you Sure to Pay With Wallet',
//                             textAlign: TextAlign.center,
//                             style: context.bodyLarge.copyWith(
//                                 fontSize: 21, fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(height: 16),
//                           CustomButton.solid(
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 10.0, vertical: 10.0),
//                             backgroundColor: AppColors.primaryColor,
//                             textColor: AppColors.white,
//                             text: Strings.PLACE_ORDER.tr,
//                             onTapAsync: () async {
//                               Get.close(-1);
//                               await PaymentRepository.walletApi(
//                                   paymentOption: "wallet_payment");
//                               Get.toNamed(Routes.CONFIRM_ID,);
//                             },
//                             radius: Sizes.RADIUS_6,
//                           ),
//                           const SizedBox(height: 16),
//                         ],
//                       ),
//                     ));
//             toggleSelectedIndex(1);
//           }),
//       PaymentMethodModel(
//         id: 2,
//         icon: Assets.PAY_PAL,
//         title: "PayPal",
//         color: AppColors.stripe,
//         onTap: () {
//           toggleSelectedIndex(2);

//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (BuildContext context) => PaypalCheckoutView(
//               sandboxMode: true,
//               clientId:
//                   "AVUsS8pctMfajUf2LYGxyh8379hthfnHI54CYztMjpbhUDmuCoB6Tyvj55k-vkxz2nMOu5wYW2BZ5bDm",
//               secretKey:
//                   "EOX3b9AEAC2ZTZbH0qQXkJ9pxErPaHTzhLzsgufACuuU3-gGX4Jk7Ck38y14fm3i0wBEsdW359701xiG",
//               transactions: const [
//                 {
//                   "amount": {
//                     "total": '100',
//                     "currency": "USD",
//                     "details": {
//                       "subtotal": '100',
//                       "shipping": '0',
//                       "shipping_discount": 0
//                     }
//                   },
//                   "description": "The payment transaction description.",
//                   // "payment_options": {
//                   //   "allowed_payment_method":
//                   //       "INSTANT_FUNDING_SOURCE"
//                   // },
//                   "item_list": {
//                     "items": [
//                       {
//                         "name": "Apple",
//                         "quantity": 4,
//                         "price": '10',
//                         "currency": "USD"
//                       },
//                       {
//                         "name": "Pineapple",
//                         "quantity": 5,
//                         "price": '12',
//                         "currency": "USD"
//                       }
//                     ],

//                     // Optional
//                     //   "shipping_address": {
//                     //     "recipient_name": "Tharwat samy",
//                     //     "line1": "tharwat",
//                     //     "line2": "",
//                     //     "city": "tharwat",
//                     //     "country_code": "EG",
//                     //     "postal_code": "25025",
//                     //     "phone": "+00000000",
//                     //     "state": "ALex"
//                     //  },
//                   }
//                 }
//               ],
//               note: "Contact us for any questions on your order.",
//               onSuccess: (Map params) async {
//                 log.e("onSuccess: $params");
//                 Navigator.pop(context);
//               },
//               onError: (error) {
//                 log.e("onError: $error");
//                 Navigator.pop(context);
//               },
//               onCancel: () {
//                 if (kDebugMode) {
//                   print('cancelled:');
//                 }
//                 Navigator.pop(context);
//               },
//             ),
//           ));
//         },
//       ),
//       PaymentMethodModel(
//         id: 3,
//         icon: Assets.CASH_PAY,
//         title: "Cash Payment ",
//         color: AppColors.stripe,
//         onTap: () {
//           toggleSelectedIndex(3);

//           Get.toNamed(Routes.CASH_PAYMENT);
//         },
//       ),
//       PaymentMethodModel(
//         id: 4,
//         icon: Assets.MOBILE_PAY,
//         title: "Pay By Mobile",
//         color: AppColors.stripe,
//         onTap: () {
//           toggleSelectedIndex(4);

//           Get.toNamed(Routes.MOBILE_PAYMENT);
//         },
//       ),
//       PaymentMethodModel(
//         id: 5,
//         icon: Assets.WIRE_TRANSFER,
//         title: "Wire Transfer",
//         color: AppColors.stripe,
//         onTap: () {
//           toggleSelectedIndex(5);

//           Get.toNamed(Routes.WIRE_TRANSFER);
//         },
//       ),
//     ];
//   }

//   void onContinueShopping() {
//     while (Get.currentRoute != Routes.DASHBOARD) {
//       if (Get.currentRoute == Routes.DASHBOARD) return;
//       Get.close(1);
//     }
//     Get.toNamed(Routes.HOME, id: Strings.GET_NESTED_KEY_1);
//   }

//   Future<void> placeOrder() async {
//     final response = await Future.delayed(const Duration(seconds: 2), () {
//       return OrderOverViewModel.fromJson(orderOverviewData);
//     });

//     orderData = response;
//     CustomDialog.showDialog(
//       height: 420,
//       width: Get.width,
//       barrierDismissible: false,
//       content: const OrderOverview(),
//     );
//   }

//   RxBool isEscrow = false.obs;
//   RxInt isEscrowChecked = 0.obs;

//   @override
//   void onInit() async {
//     await getPaymentAmount();
//     initializePaymentMethods(Get.context!);
//     getPaymentValue();
//     log.e(walletPrice);
//     additionalInfoCtrl = TextEditingController();

//     super.onInit();
//     // Future.delayed(
//     //   const Duration(milliseconds: 5),
//     //   () => Get.bottomSheet(

//     //     const SummarySheet(),
//     //   ),
//     // );
//   }

//   @override
//   void dispose() {
//     additionalInfoCtrl.dispose();
//     super.dispose();
//   }
// }
// ignore_for_file: use_build_context_synchronously

import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:moyen_express/model/view_cart/view_cart_model.dart';
import 'package:moyen_express/model/wallet/wallet_model.dart';
import 'package:moyen_express/repository/payment_repository.dart';
import '../../../dummy/order_overview_data.dart';
import '../../../model/payment/payment_model.dart';
import '../../../repository/wallet_repository.dart';
import '../../../resources/exports/index.dart';
import '../../helpers/global_helper/currency_conversion.dart';

class PaymentMethodController extends GetxController {
  late TextEditingController additionalInfoCtrl;
  int selectedIndex = -1;
  double totalPrice = 0.0;

  OrderOverViewModel orderData = OrderOverViewModel();
  Map<String, dynamic>? paymentIntent;
  PaymentSuccess? testValue;
  String walletPrice = "";
  WalletModel? _walletModel;
  List<PaymentMethodModel> methods = [];
  final CurrencyConversionController conversionController =
      Get.put(CurrencyConversionController());
  @override
  void onInit() async {
    super.onInit();

    additionalInfoCtrl = TextEditingController();
    await getPaymentAmount();
    await getPaymentValue();
    initializePaymentMethods(Get.context!);

    log.e(walletPrice);
  }

  @override
  void dispose() {
    additionalInfoCtrl.dispose();
    super.dispose();
  }

  void toggleSelectedIndex(int index) {
    selectedIndex = index;
    update(["update_selected_index"]);
  }

  Future<void> makePayment(BuildContext context) async {
    try {
      int totalPriceInt = totalPrice.toInt();
      log.d(totalPriceInt);

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      // Create payment intent and initialize payment sheet
      paymentIntent = await PaymentRepository.createPaymentIntent(
          totalPriceInt.toString(), 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'MOYENXPRESS'))
          .then((value) {});

      // Hide loading indicator
      Navigator.pop(context);

      // Display payment sheet
      displayPaymentSheet(context);
    } catch (e, s) {
      Navigator.pop(context);
      log.e('exception:$e$s');
    }
  }

  Future<void> displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        PaymentRepository.placeOrderStore();
        Future<void> paymentSuccess() async {
          await PaymentRepository.paymentSuccess();
          await Get.toNamed(Routes.CONFIRM_ID,
              arguments: {"id": PaymentRepository.combineId});
        }

        paymentSuccess();
        paymentIntent = null;
      }).onError((error, stackTrace) {
        log.e('Error is:--> $error $stackTrace');
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        log.e("Error is:--> $e");
      }
      Navigator.pop(context); // Dismiss the loading dialog

      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Cancelled"),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Navigator.pop(context); // Dismiss the loading dialog
    }
  }

  double calculateShippingCost(List<CartItem> cartItems) {
    // Create a map to store the last shipping cost for each owner_id
    final Map<String, double> ownerShippingCosts = {};

    // Iterate through cartItems to find the last shipping cost for each owner_id
    for (var item in cartItems) {
      if (item.shippingCost != null && item.ownerId != null) {
        ownerShippingCosts[item.ownerId.toString()] = item.shippingCost!;
      }
    }

    // Calculate total shipping cost using the last shipping cost for each owner_id
    double totalShippingCost = 0.0;
    ownerShippingCosts.forEach((_, cost) {
      totalShippingCost += cost;
    });

    return totalShippingCost;
  }

  Future<void> getPaymentValue() async {
    try {
      testValue = await PaymentRepository.getPayment();
      walletPrice = testValue?.balance.toString() ?? '';
      update(); // Update the UI only when necessary
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching payment details: $e');
      }
    }
  }

  Future<WalletModel?> getPaymentAmount() async {
    _walletModel = await WalletRepository.getWalletPrice();
    log.e("Wallet Check kr $_walletModel");
    log.e(_walletModel?.walletBalance);
    return _walletModel;
  }

  String getFormattedWalletBalance() {
    // Check if the wallet model and conversion controller are available
    // ignore: unnecessary_null_comparison
    if (_walletModel == null || conversionController == null) {
      return 'N/A'; // Or any default value
    }

    // Check if the currency is USD
    if (_walletModel?.currency == "USD") {
      return _walletModel!.walletBalance!
          .toStringAsFixed(2); // Format as needed
    } else {
      // Convert to current currency and format
      RxString convertedAmount = conversionController.convertCurrencyAmt(
        amount: _walletModel?.walletBalance.toString(),
        toUsd: false,
      );
      return convertedAmount.value;
    }
  }

  String getTitle() {
    // Ensure the current currency is not null
    String currentCurrency =
        conversionController.currentCurrency.value;

    // Use the method to get the formatted balance
    String formattedBalance = getFormattedWalletBalance();

    // Return the formatted title
    return "Pay By Wallet ($formattedBalance $currentCurrency)";
  }

  void initializePaymentMethods(BuildContext context) {
    methods = [
      PaymentMethodModel(
        id: 0,
        icon: Assets.CARD_PAYMENT,
        title: "Card Payment",
        color: AppColors.stripe,
        onTap: () {
          makePayment(context);
          toggleSelectedIndex(0);
        },
      ),
      PaymentMethodModel(
        id: 1,
        icon: Assets.WALLET,
        title: getTitle(),
        color: AppColors.stripe,
        onTap: () {
          showDialog(
            context: Get.context!,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.all(15.0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SpaceH10(),
                  Text(
                    'Are you Sure to Pay With Wallet',
                    textAlign: TextAlign.center,
                    style: context.bodyLarge.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton.solid(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    backgroundColor: AppColors.primaryColor,
                    textColor: AppColors.white,
                    text: Strings.PLACE_ORDER.tr,
                    onTapAsync: () async {
                      Get.close(-1);
                      await PaymentRepository.walletApi(
                          paymentOption: "wallet_payment");
                      Get.toNamed(Routes.CONFIRM_ID);
                    },
                    radius: Sizes.RADIUS_6,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
          toggleSelectedIndex(1);
        },
      ),
      PaymentMethodModel(
        id: 2,
        icon: Assets.PAY_PAL,
        title: "PayPal",
        color: AppColors.stripe,
        onTap: () {
          toggleSelectedIndex(2);

          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => PaypalCheckoutView(
              sandboxMode: true,
              clientId: FlutterConfig.get('PAYPAL_CLIENT'),
              secretKey: FlutterConfig.get('PAYPAL_SECRET'),
              transactions:  [
                {
                  "amount": {
                    "total": totalPrice.toString(),
                    "currency": "USD",
                 
                  },
                  // "description": "The payment transaction description.",
                 
                }
              ],
              note: "Contact us for any questions on your order.",
              onSuccess: (Map<String, dynamic> params) async {
                log.e("onSuccess: $params");

                final String? orderID = params['orderID'] as String?;

                if (orderID != null) {
                  Navigator.pop(context);
                  await PaymentRepository.paypalApi(
                      paymentOption: "paypal", orderID: orderID);
                } else {
                  log.e("OrderID not found in the response");
                  CustomSnackBar.showSnackBar(
                    message: 'OrderID was not found in the payment response.',
                    snackBarStyle: SnackBarStyle.warning,
                  );
                }
              },
              onError: (error) {
                log.e("onError: $error");
                Navigator.pop(context);
              },
              onCancel: () {
                if (kDebugMode) {
                  print('cancelled:');
                }
                Navigator.pop(context);
              },
            ),
          ));
        },
      ),
      PaymentMethodModel(
        id: 3,
        icon: Assets.CASH_PAY,
        title: "Cash Payment",
        color: AppColors.stripe,
        onTap: () {
          toggleSelectedIndex(3);
          Get.toNamed(Routes.CASH_PAYMENT);
        },
      ),
      PaymentMethodModel(
        id: 4,
        icon: Assets.MOBILE_PAY,
        title: "Pay By Mobile",
        color: AppColors.stripe,
        onTap: () {
          toggleSelectedIndex(4);
          Get.toNamed(Routes.MOBILE_PAYMENT);
        },
      ),
      PaymentMethodModel(
        id: 5,
        icon: Assets.WIRE_TRANSFER,
        title: "Wire Transfer",
        color: AppColors.stripe,
        onTap: () {
          toggleSelectedIndex(5);
          Get.toNamed(Routes.WIRE_TRANSFER);
        },
      ),
    ];
  }

  void onContinueShopping() {
    while (Get.currentRoute != Routes.DASHBOARD) {
      if (Get.currentRoute == Routes.DASHBOARD) return;
      Get.close(1);
    }
    Get.toNamed(Routes.HOME, id: Strings.GET_NESTED_KEY_1);
  }

  Future<void> placeOrder() async {
    final response = await Future.delayed(const Duration(seconds: 2), () {
      return OrderOverViewModel.fromJson(orderOverviewData);
    });

    orderData = response;
    CustomDialog.showDialog(
      height: 420,
      width: Get.width,
      barrierDismissible: false,
      content: const OrderOverview(),
    );
  }

  RxBool isEscrow = false.obs;
  RxInt isEscrowChecked = 0.obs;
}
