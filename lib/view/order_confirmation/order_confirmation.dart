import 'package:moyen_express/model/test_model/test_model.dart';
import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';
import '../../view_model/helpers/global_helper/currency_conversion.dart';

class OrderConfirmation extends GetView<CartController> {
  const OrderConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationsController locationsController =
        Get.put(LocationsController());
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());

    return Scaffold(
      appBar: CustomAppBar(
        title: Strings.ORDER_CONFIRMATION.tr,
      ),
      body: GetBuilder<CartController>(
        id: "Remove",
        builder: (controller) {
          return FutureBuilder<List<DeliveryContent>>(
            future: CartRepository.deliveryInfoCart(
                addressId: controller.selectedId.value == 0
                    ? locationsController.selectedLocationId
                    : controller.selectedId.value),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data!;
                controller.initializeShipWithMoyen(data);

                // Group products by shop name
                Map<String, List<Product>> productsByShop = {};
                for (var deliveryContent in data) {
                  for (var product in deliveryContent.products ?? []) {
                    if (!productsByShop.containsKey(product.shopName)) {
                      productsByShop[product.shopName!] = [];
                    }
                    productsByShop[product.shopName]!.add(product);
                  }
                }

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _orderMethod(
                                productsByShop, data, conversionController),
                            servicesMethod(data),
                          ],
                        ),
                      ),
                    ),
                    CustomButton.solid(
                      margin: const EdgeInsets.all(10.0),
                      backgroundColor: AppColors.primaryColor,
                      textColor: AppColors.white,
                      text: Strings.NEXT.tr,
                      onTapAsync: () async {
                        final sellerShipWithMoyen =
                            controller.initializeWithMoyen(data);
                        final sellerExpressDelivery =
                            controller.initializeExpress(data);
                        List<int?> cartIdsToRemove = [];
                        List<int?> cartIdsToKeep = [];
                        bool hasSendQuoteOne = false;
                        bool hasCheckoutOne = false;

                        // Check the conditions for sendQuote and checkout
                        for (var deliveryContent in data) {
                          for (var product in deliveryContent.products ?? []) {
                            if (product.checkout == 1) {
                              hasCheckoutOne = true;
                            }
                            if (product.checkout == 0) {
                              cartIdsToRemove
                                  .addAll(deliveryContent.cartIds ?? []);
                            }
                            if (product.deliveryMethods?.sendQuote == 1) {
                              hasSendQuoteOne = true;
                            }
                          }
                        }

                        // Show a message if the quote is to be sent but no checkout items exist
                        if (hasSendQuoteOne && !hasCheckoutOne) {
                          Get.snackbar(
                            'Info!',
                            'Delivery Not Available',
                            snackStyle: SnackStyle.FLOATING,
                            backgroundColor: AppColors.error,
                            snackPosition: SnackPosition.TOP,
                            colorText: AppColors.white,
                            barBlur: 0,
                            overlayBlur: 0,
                            titleText: Text(
                              "Info!",
                              style: Get.context!.headlineSmall.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            messageText: Text(
                              'Delivery Not Available',
                              style: Get.context!.bodyLarge
                                  .copyWith(color: AppColors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                          return; // Exit the function early if delivery is not available
                        }

                        // Process cart items based on checkout status
                        for (var deliveryContent in data) {
                          for (var product in deliveryContent.products ?? []) {
                            if (product.checkout == 0) {
                              cartIdsToRemove
                                  .addAll(deliveryContent.cartIds ?? []);
                            } else if (product.checkout == 1) {
                              cartIdsToKeep
                                  .addAll(deliveryContent.cartIds ?? []);
                            }
                          }
                        }

                        // Remove items from cart if needed
                        for (int? cartId in cartIdsToRemove) {
                          await controller.updateAndDeleteProduct(cartId);
                          controller.update();
                        }

                        if (kDebugMode) {
                          print('Cart IDs to keep: $cartIdsToKeep');
                        }
                        log.f("ship $sellerShipWithMoyen");
                        log.f("express $sellerExpressDelivery");
                        log.f("seller Ids ${controller.sellerIds}");
                        log.f("seller Ids ${controller.selectedIds}");

                        // Determine delivery info to store
                        // Map<int, int>? deliveryInfoToSend;
                        // if (sellerExpressDelivery!.isNotEmpty) {
                        //   // Use express delivery info if available
                        //   deliveryInfoToSend = sellerExpressDelivery;
                        //   log.f(deliveryInfoToSend);
                        // } else if (sellerShipWithMoyen!.isNotEmpty) {
                        //   // Otherwise, use ship with moyen info
                        //   deliveryInfoToSend = sellerShipWithMoyen;
                        //   log.f(deliveryInfoToSend);
                        // } else {
                        //   // Default to an empty map if no delivery info is available
                        //   deliveryInfoToSend = {};
                        // }

                        // Send the appropriate delivery info
                        await CartRepository.storeDeliveryInfo(
                          sellerIds: controller.sellerIds,
                          pickupIds: controller.defaultIds,
                          sellerShipWithMoyen: sellerShipWithMoyen??{},
                        );
                        // await CartRepository.storeDeliveryInfo(
                        //   sellerIds: controller.sellerIds,
                        //   pickupIds: controller.selectedIds,
                        //   sellerShipWithMoyen: sellerExpressDelivery??{},
                        // );
                        Get.toNamed(Routes.CHECKOUT_VIEW);
                      },
                      radius: Sizes.RADIUS_6,
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          );
        },
      ),
    );
  }

  Widget _orderMethod(
    Map<String, List<Product>> productsByShop,
    List<DeliveryContent> successContents,
    CurrencyConversionController conversionController,
  ) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productsByShop.length,
      itemBuilder: (context, index) {
        String shopName = productsByShop.keys.toList()[index];
        List<Product> products = productsByShop[shopName]!;

        // Find the matching delivery content for the shop
        var deliveryContent = successContents.firstWhere(
          (content) =>
              content.products?.any((p) => p.shopName == shopName) ?? false,
          orElse: () => DeliveryContent(products: []),
        );

        // Initialize the selected pickup address if necessary
        if (controller.selectedPickupAddresses[shopName] == null &&
            deliveryContent.products != null &&
            deliveryContent.products!.isNotEmpty &&
            deliveryContent.products![0].deliveryMethods?.pickupAddress !=
                null &&
            deliveryContent
                .products![0].deliveryMethods!.pickupAddress!.isNotEmpty) {
          controller.selectedPickupAddresses[shopName] = deliveryContent
                  .products![0].deliveryMethods?.pickupAddress!.first.id ??
              0;
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: Text(
                      "$shopName Products",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: context.bodyLarge
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  products.any((product) => product.checkout == 1)
                      ? Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: true,
                            activeTrackColor: AppColors.active,
                            onChanged: (value) {
                              // Check if index is within bounds
                              if (index < successContents.length) {
                                controller.selectedOrderId.value =
                                    successContents[index].cartIds?.first ?? 0;
                              }
                            },
                          ),
                        )
                      : Transform.scale(
                          scale: 0.9,
                          child: Switch(
                            inactiveThumbColor: AppColors.white,
                            inactiveTrackColor: AppColors.greyClr,
                            value: false,
                            onChanged: (value) {
                              // Handle switch change
                            },
                          ),
                        ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, productIndex) {
                  if (productIndex >= products.length) {
                    return const SizedBox.shrink();
                  }
                  Product product = products[productIndex];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: AppColors.iconGrey,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.shadow,
                                    offset: const Offset(0.0, 4.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: ImageService.image(
                                product.thumbnail ?? "",
                                borderRadius: 8.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            SizedBox(
                              width: 200,
                              child: Text(
                                product.name!,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: context.bodyLarge.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 4.0),
              Text(
                "Choose Delivery Type:",
                style: context.bodyLarge
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              deliveryContent.products != null &&
                      deliveryContent.products!.isNotEmpty &&
                      deliveryContent.products![0].deliveryMethods?.sendQuote ==
                          1
                  ? CustomButton.solid(
                      text: Strings.SEND_QUOTE.tr,
                      radius: 5,
                      margin: const EdgeInsets.all(12.0),
                      textColor: AppColors.white,
                      onTapAsync: () async {
                        CartRepository.sendQuotes(
                            cartIds: deliveryContent.cartIds?.first.toString());
                      },
                    )
                  : const SizedBox(),
              // Assuming this is part of your _orderMethod widget
              deliveryContent.products != null &&
                      deliveryContent.products!.isNotEmpty &&
                      deliveryContent
                              .products![0].deliveryMethods?.pickupAddress !=
                          null &&
                      deliveryContent.products![0].deliveryMethods!
                          .pickupAddress!.isNotEmpty &&
                      deliveryContent.products![0].deliveryMethods?.sendQuote ==
                          0
                  ? Column(
                      children: deliveryContent
                          .products![0].deliveryMethods!.pickupAddress!
                          .asMap()
                          .entries
                          .map((entry) {
                        final PickupAddress address = entry.value;
                        return GestureDetector(
                          onTap: () {
                            controller.selectDeliveryType(
                                deliveryContent.products?[index].sellerId
                                        .toString() ??
                                    "",
                                address.id ?? 0,
                                deliveryContent.products![index]
                                    .deliveryMethods!.pickupAddress![index].id!
                                    .toInt(),
                                address.type ?? "");
                            controller.toggleSelectedPickupAddress(
                                shopName, address.id ?? 0);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            margin: const EdgeInsets.only(bottom: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Free Pickup: ",
                                      style: context.bodyLarge.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    GetBuilder<CartController>(
                                      id: "_index",
                                      builder: (_) {
                                        return controller
                                                        .selectedPickupAddresses[
                                                    shopName] ==
                                                address.id
                                            ? const Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.green,
                                                size: 30.0,
                                              )
                                            : const SizedBox();
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pickup Address: ',
                                      style: context.bodyLarge.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 260,
                                      child: Text(
                                        address.address ??
                                            'No address provided',
                                        maxLines: 3,
                                        textAlign: TextAlign.end,
                                        style: context.bodyLarge.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : const SizedBox(),

              // Toggle ship_with_moyen
              deliveryContent.products != null &&
                      deliveryContent.products!.isNotEmpty &&
                      deliveryContent
                              .products![0].deliveryMethods?.shipWithMoyen !=
                          null
                  ? GestureDetector(
                      onTap: () {
                        controller.selectDeliveryType(
                            deliveryContent.products?[0].sellerId.toString() ??
                                "",
                            deliveryContent.products![0].deliveryMethods
                                    ?.shipWithMoyen?.id ??
                                0,
                            deliveryContent.products![0].deliveryMethods!
                                .shipWithMoyen!.id!
                                .toInt(),
                            deliveryContent.products![0].deliveryMethods
                                    ?.shipWithMoyen?.type ??
                                "");
                        controller.toggleShipMoyen(
                            shopName,
                            deliveryContent.products![0].deliveryMethods
                                    ?.shipWithMoyen?.id ??
                                0);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                deliveryContent.products![0].deliveryMethods
                                            ?.shipWithMoyen !=
                                        null
                                    ? Text(
                                        "Ship With Moyen",
                                        style: context.bodyLarge.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : const SizedBox(),
                                GetBuilder<CartController>(
                                  id: "update_index", // Correct ID for updating shipWithMoyen UI
                                  builder: (_) {
                                    return controller.selectedShipMoyenByShop[
                                                shopName] ==
                                            deliveryContent
                                                .products![0]
                                                .deliveryMethods
                                                ?.shipWithMoyen
                                                ?.id
                                        ? const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: 30.0,
                                          )
                                        : const SizedBox();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  "Shipping Charges: ",
                                  style: context.bodyLarge.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  deliveryContent.products?[0].deliveryMethods
                                              ?.shipWithMoyen?.currency ==
                                          "USD"
                                      ? " ${deliveryContent.products![0].deliveryMethods?.shipWithMoyen?.charges}"
                                      : " ${conversionController.convertCurrencyAmt(amount: deliveryContent.products?[0].deliveryMethods?.shipWithMoyen?.charges.toString())} ${conversionController.currentCurrency.value}",
                                  style: context.bodyLarge.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Estimate Delivery Days: ${deliveryContent.products![0].deliveryMethods?.shipWithMoyen?.estDays ?? ''}",
                              style: context.bodyLarge.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),

              const SizedBox(height: 12.0),

// Toggle express_delivery
              deliveryContent.products != null &&
                      deliveryContent.products!.isNotEmpty &&
                      deliveryContent
                              .products![0].deliveryMethods?.expressDelivery !=
                          null
                  ? GestureDetector(
                      onTap: () {
                        controller.selectDeliveryType(
                            deliveryContent.products?[0].sellerId.toString() ??
                                "",
                            deliveryContent.products![0].deliveryMethods
                                    ?.expressDelivery?.id ??
                                0,
                            deliveryContent.products![0].deliveryMethods!
                                .expressDelivery!.id!
                                .toInt(),
                            deliveryContent.products![0].deliveryMethods
                                    ?.expressDelivery?.type ??
                                "");
                        controller.toggleExpressDelivery(
                            shopName,
                            deliveryContent.products![0].deliveryMethods
                                    ?.expressDelivery?.id ??
                                0);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                deliveryContent.products![0].deliveryMethods
                                            ?.expressDelivery !=
                                        null
                                    ? Text(
                                        "Express Delivery",
                                        style: context.bodyLarge.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : const SizedBox(),
                                GetBuilder<CartController>(
                                  id: "update_", // Correct ID for updating expressDelivery UI
                                  builder: (_) {
                                    return controller.selectedExpressByShop[
                                                shopName] ==
                                            deliveryContent
                                                .products![0]
                                                .deliveryMethods
                                                ?.expressDelivery
                                                ?.id
                                        ? const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: 30.0,
                                          )
                                        : const SizedBox();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  "Shipping Charges: ",
                                  style: context.bodyLarge.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  deliveryContent.products?[0].deliveryMethods
                                              ?.expressDelivery?.currency ==
                                          "USD"
                                      ? " ${deliveryContent.products![0].deliveryMethods?.expressDelivery?.charges}"
                                      : " ${conversionController.convertCurrencyAmt(amount: deliveryContent.products?[0].deliveryMethods?.expressDelivery?.charges.toString())} ${conversionController.currentCurrency.value}",
                                  style: context.bodyLarge.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Estimate Delivery Days: ${deliveryContent.products![0].deliveryMethods?.expressDelivery?.estDays ?? ''}",
                              style: context.bodyLarge.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  Widget servicesMethod(
    List<DeliveryContent> data,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, deliveryContentIndex) {
        final deliveryContent = data[deliveryContentIndex];
        if (deliveryContent.services != null &&
            deliveryContent.services!.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: deliveryContent.services!.length,
            itemBuilder: (context, serviceIndex) {
              final service = deliveryContent.services?[serviceIndex];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        service?.shopName ?? "",
                        style: context.bodyLarge.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: AppColors.iconGrey,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.shadow,
                                    offset: const Offset(0.0, 4.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: ImageService.image(
                                service?.thumbnail,
                                borderRadius: 8.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              service?.name ?? "",
                              style: context.bodyLarge.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Select Booking Date',
                              style: context.bodyMedium,
                            ),
                            const SizedBox(height: 5.0),
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  // Handle the selected date
                                  if (kDebugMode) {
                                    print(
                                        "Selected Date: ${pickedDate.toLocal()}");
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'mm/dd/yyyy',
                                      style: context.bodyMedium,
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Icon(Icons.calendar_today,
                                        size: 16.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
