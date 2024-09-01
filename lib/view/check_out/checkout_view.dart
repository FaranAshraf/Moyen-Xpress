import 'package:moyen_express/model/view_cart/view_cart_model.dart';
import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

import '../../view_model/helpers/global_helper/currency_conversion.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentMethodController payController =
        Get.put(PaymentMethodController());
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return Scaffold(
        appBar: CustomAppBar(title: Strings.CHECK_OUT.tr),
        body: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            padding: const EdgeInsets.all(10.0),
            width: double.maxFinite,
            height: double.maxFinite,
            child: GetBuilder<CartController>(
              builder: (controller) {
                return CustomFutureBuilder(
                  future: CartRepository.getCartProducts(),
                  hasDataBuilder: (_, snapshot) {
                    double freePickupTotal = 0.0;
                    double shipWithMoyenTotal = 0.0;
                    // Assuming snapshot.data is a list of product items
                    var products = snapshot.data ?? [];

                    // Create a map to store the products by ownerId and name
                    Map<String, List<CartItem>> productMap = {};

                    for (var item in products) {
                      String key = '${item.ownerId}-${item.product?.name}';

                      if (!productMap.containsKey(key)) {
                        productMap[key] = [];
                      }

                      productMap[key]!.add(item);
                    }

                    for (var key in productMap.keys) {
                      var productList = productMap[key]!;

                      if (productList.length > 1) {
                        if (kDebugMode) {
                          print('OwnerId and Name: $key');
                        }
                        for (var product in productList) {
                          if (kDebugMode) {
                            print('  Variation: ${product.variation}');
                          }
                        }
                      }
                    }
                    var product = snapshot.data ?? [];

                    Map<String, double> shippingCostMap = {};

                    Set<String> processedKeys = {};

                    for (var item in product) {
                      String key = '${item.ownerId}-${item.product?.name}';

                      if (processedKeys.contains(key)) {
                        continue;
                      }

                      // Initialize the shipping cost if this key is not yet processed
                      if (!shippingCostMap.containsKey(key)) {
                        // Add the shipping cost for the first encountered variation
                        shippingCostMap[key] = item.shippingCost ?? 0.0;
                      }

                      // Add the key to the processed set to indicate variations are present
                      processedKeys.add(key);
                    }

// Loop through the shipping cost map to calculate totals
                    for (var entry in shippingCostMap.entries) {
                      String key = entry.key;
                      double cost = entry.value;

                      // Find a product with this key to determine the shipping type
                      var product = products.firstWhere(
                        (p) => '${p.ownerId}-${p.product?.name}' == key,
                      );

                      // ignore: unnecessary_null_comparison
                      if (product != null) {
                        if (product.shippingType == 'free_pickup') {
                          freePickupTotal += cost;
                        } else if (product.shippingType == 'ship_with_moyen') {
                          shipWithMoyenTotal += cost;
                        }
                      }
                    }

// Calculate the total shipping cost
                    String shipCost = (shipWithMoyenTotal + freePickupTotal)
                        .toStringAsFixed(2);

// Print the total shipping costs
                    if (kDebugMode) {
                      print(
                          'Total shipping cost for free_pickup: \$$freePickupTotal');
                      print(
                          'Total shipping cost for ship_with_moyen: \$$shipWithMoyenTotal');
                    }
                    // Iterate over each CartItem to sum up the shipping costs
                    // for (var item in snapshot.data ?? []) {
                    //   if (item.shippingType == 'free_pickup') {
                    //     freePickupTotal += item.shippingCost ?? 0.0;
                    //   } else if (item.shippingType == 'ship_with_moyen') {
                    //     shipWithMoyenTotal += item.shippingCost ?? 0.0;
                    //   }
                    // }
                    // num shipCost = shipWithMoyenTotal + freePickupTotal;
                    // // Print the total shipping costs
                    // if (kDebugMode) {
                    //   print(
                    //       'Total shipping cost for free_pickup: \$$freePickupTotal');
                    //   print(
                    //       'Total shipping cost for ship_with_moyen: \$$shipWithMoyenTotal');
                    // }

                    if (snapshot.hasData) {
                      List<CartItem> cartItems =
                          snapshot.data as List<CartItem>;
                      double totalTax = calculateTotalTax(cartItems);
                      List<CartItem>? successContents = snapshot.data;
                      Set<String?> uniqueProducts = {};
                      successContents?.forEach((entry) {
                        uniqueProducts.add(entry.product!.name);
                      });
                      int totalProducts = successContents!.length;

                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.SUMMARY.tr,
                                            style: context.bodyLarge.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: Text(
                                            "$totalProducts Items",
                                            style: context.bodyMedium.copyWith(
                                                color: AppColors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(
                                    height: 1.5,
                                    thickness: 1,
                                    color: AppColors.greyClr,
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.PRODUCTS.tr,
                                            style: context.bodyLarge.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                        Text(Strings.TOTAL.tr,
                                            style: context.bodyLarge.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(
                                    height: 1.5,
                                    thickness: 1,
                                    color: AppColors.greyClr,
                                  ),
                                  const SizedBox(height: 4),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cartItems.length,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 170,
                                                    child: Text(
                                                        cartItems[index]
                                                                .product
                                                                ?.name ??
                                                            "",
                                                        maxLines: 2,
                                                        style: context
                                                            .bodyMedium
                                                            .copyWith(
                                                                fontSize: 18)),
                                                  ),
                                                ),
                                                Text(
                                                    "x ${cartItems[index].quantity.toString()}",
                                                    style: context.bodyMedium
                                                        .copyWith(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 140.0,
                                                child: Text(
                                                    "${getDiscount(cartItems, index) * (cartItems[index].quantity ?? 0)} ${conversionController.currentCurrency.value}",
                                                    maxLines: 1,
                                                    textAlign: TextAlign.end,
                                                    style: context.bodyMedium
                                                        .copyWith(
                                                            fontSize: 18)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Divider(
                                          height: 1.5,
                                          thickness: 1,
                                          color: AppColors.greyClr,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SpaceH10(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.SUB_TOTAL.tr,
                                            style: context.bodyMedium.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                          "${calculateSubtotal(cartItems).toString()} ${conversionController.currentCurrency.value}",
                                          style: context.bodyMedium.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SpaceH10(),
                                  const Divider(
                                    height: 1.5,
                                    thickness: 1,
                                    color: AppColors.greyClr,
                                  ),
                                  const SpaceH8(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.TECHNICIAN_VIEW);
                                    },
                                    child: Center(
                                      child: Text(Strings.SERVICE_WITH_MOYEN.tr,
                                          style: context.bodyMedium.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryColor)),
                                    ),
                                  ),
                                  const SpaceH8(),
                                  const Divider(
                                    height: 1.5,
                                    thickness: 1,
                                    color: AppColors.greyClr,
                                  ),
                                  const SpaceH8(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.SERVICE_NAME.tr,
                                            style: context.bodyLarge.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                        Text(Strings.TOTAL.tr,
                                            style: context.bodyLarge.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  const SpaceH8(),
                                  const Divider(
                                    height: 1.5,
                                    thickness: 1,
                                    color: AppColors.greyClr,
                                  ),
                                  const SpaceH30(),
                                  const Divider(
                                    height: 1.5,
                                    thickness: 1,
                                    color: AppColors.greyClr,
                                  ),
                                  const SpaceH8(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.TAX.tr,
                                            style: context.bodyMedium.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        Text(
                                          "${totalTax.toStringAsFixed(2).toString()} ${conversionController.currentCurrency.value}",
                                          style: context.bodyMedium.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SpaceH8(),
                                  const Divider(
                                    height: 1.5,
                                    thickness: 1,
                                    color: AppColors.greyClr,
                                  ),
                                  const SpaceH8(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Strings.TOTAL_SHIPPING.tr,
                                          style: context.bodyMedium.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${shipCost.toString()} ${conversionController.currentCurrency.value}",
                                          style: context.bodyMedium.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SpaceH8(),
                                  const Divider(
                                    height: 1.5,
                                    thickness: 1,
                                    color: AppColors.greyClr,
                                  ),
                                  const SpaceH8(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Strings.TOTAL.tr,
                                            style: context.bodyMedium.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        Text(
                                          "${calculateTotal(cartItems, shipWithMoyenTotal).toStringAsFixed(2)} ${conversionController.currentCurrency.value}",
                                          style: context.bodyMedium.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SpaceH12(),
                                ],
                              ),
                            ),
                          ),
                          CustomButton.solid(
                              text: "Complete Order",
                              radius: 5.0,
                              textColor: AppColors.white,
                              onTap: () {
                                payController.totalPrice = calculateTotal(
                                    cartItems, shipWithMoyenTotal);
                                Get.toNamed(Routes.PAYMENT_METHOD);
                              }),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              },
            )));
  }

  double getTaxedPrice(List<CartItem> cartItems, int index) {
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    double unitPriceUSD;

    // Convert the unit price to USD if needed
    if (cartItems[index]?.product?.currency == "USD") {
      unitPriceUSD = cartItems[index]?.product?.unit_price?.toDouble() ?? 0.0;
    } else {
      final unitPriceString =
          cartItems[index]?.product?.unit_price?.toString() ?? '0.0';
      final convertedValue = conversionController
          .convertCurrencyAmtWithType(
              amount: unitPriceString,
              toUsd: false,
              currencyType: cartItems[index]?.product?.currency)
          .value;

// but i am giving it here

      unitPriceUSD = double.tryParse(convertedValue) ?? 0.0;
    }

    double taxedPrice = unitPriceUSD;

    // Loop through all taxes and calculate them dynamically
    cartItems[index]?.taxes?.forEach((taxInfo) {
      double taxAmount;
      if (conversionController.currentCurrency.value == "USD" &&
          cartItems[index]?.product?.currency == "USD") {
        taxAmount = taxInfo?.tax?.toDouble() ?? 0;
      } else {
        final taxString = taxInfo?.tax?.toString() ?? '0.0';
        final convertedvalue = conversionController
            .convertCurrencyAmtWithType(
                amount: taxString,
                currencyType: cartItems[index]?.product?.currency ?? 'XOF')
            .value;
        taxAmount = double.tryParse(convertedvalue) ?? 0.0;
      }
      final taxType = taxInfo?.taxType?.toString();

      if (taxType == 'percent' && taxAmount != 0) {
        taxAmount = (taxAmount * unitPriceUSD) / 100;
      }

      taxedPrice += taxAmount;
    });

    if (conversionController.currentCurrency.value != "USD") {
      final taxedPriceString = taxedPrice.toString();
      final convertedValue = conversionController.convertCurrencyAmtWithType(
          amount: taxedPriceString,
          toUsd: false,
          currencyType: cartItems[index]?.product?.currency ?? 'XOF');

      // print('Converted Taxed Price in ${conversionController.currentCurrency.value}: $convertedValue');
      taxedPrice = double.tryParse(convertedValue.value) ?? 0.0;
      return taxedPrice;
    }

    return taxedPrice;
  }

  double getDiscount(List<CartItem> cartItems, int index) {
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    double unitPriceUSD = getTaxedPrice(cartItems, index);
    double discountedPrice = 0.0;

    // Ensure discount is a valid integer value
    final discount = cartItems[index]?.product?.discount?.toInt() ?? 0;

    // Ensure the discount calculation method is correctly defined and uses USD values
    final discountType = cartItems[index]?.product?.discount_type?.toString();
    final discountCurrency =
        cartItems[index]?.product?.discount_currency?.toString();

    if (discountType == 'amount' &&
        discount != 0 &&
        discountCurrency == 'USD') {
      discountedPrice = unitPriceUSD - discount;
    } else if (discountType == "percent" &&
        discount != 0 &&
        discountCurrency == 'USD') {
      discountedPrice = unitPriceUSD - ((unitPriceUSD * discount) / 100);
    } else {
      discountedPrice = unitPriceUSD;
    }

    if (conversionController.currentCurrency.value != "USD") {
      final discountedPriceString = discountedPrice.toString();
      final convertedValue = conversionController
          .convertCurrencyAmtWithType(
              amount: discountedPriceString,
              toUsd: false,
              currencyType: cartItems[index]?.product?.currency ?? 'XOF')
          .value;

      return double.tryParse(convertedValue) ?? 0.0;
    }

    return discountedPrice;
  }

  double calculateSubtotal(List<CartItem> cartItems) {
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    double subtotal = 0.0;

    for (int i = 0; i < cartItems.length; i++) {
      var item = cartItems[i];
      // Get the discounted price for the current item
      double unitPrice = getDiscount(cartItems, i);

      subtotal += unitPrice * (item.quantity ?? 0);
    }

    return subtotal;
  }

  int calculateTotalProducts(List<CartItem> cartItems) {
    int totalProducts = 0;
    for (var item in cartItems) {
      totalProducts += item.quantity ?? 0;
    }
    return totalProducts;
  }

  double calculateTotalTax(List<CartItem> cartItems) {
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    double totalTax = 0.0;
    for (var item in cartItems) {
      item.product?.currency == "USD"
          ? totalTax += (item.tax ?? 0) * (item.quantity ?? 0)
          : conversionController.convertCurrencyAmt(
              amount: (totalTax += (item.tax ?? 0) * (item.quantity ?? 0))
                  .toString());
    }
    return totalTax;
  }

  double calculateShippingCost(List<CartItem> cartItems) {
    // Create a map to store the last shipping cost for each owner_id
    Map<String, double> ownerShippingCosts = {};

    // Iterate through cartItems to find the last shipping cost for each owner_id
    for (var item in cartItems) {
      if (item.shippingCost != null && item.ownerId != null) {
        ownerShippingCosts[item.ownerId.toString()] = item.shippingCost!;
      }
    }

    // Calculate total shipping cost using the last shipping cost for each owner_id
    double totalShippingCost = 0.0;
    ownerShippingCosts.forEach((ownerId, cost) {
      totalShippingCost += cost;
    });

    return totalShippingCost;
  }

  double calculateTotal(List<CartItem> cartItems, value) {
    double totalCost = 0.0;

    totalCost +=
        calculateSubtotal(cartItems) + calculateTotalTax(cartItems) + value;

    return totalCost;
  }
}
