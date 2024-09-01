

import 'package:moyen_express/model/view_cart/view_cart_model.dart';

import '../repository/cart_repository.dart';
import '../resources/exports/index.dart';

class SummarySheet extends StatelessWidget {
  const SummarySheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentMethodController payController =
        Get.put(PaymentMethodController());
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: const EdgeInsets.all(10.0),
      width: double.maxFinite,
      child: GetBuilder<CartController>(
        builder: (controller) {
          return CustomFutureBuilder(
            future: CartRepository.getCartProducts(),
            hasDataBuilder: (_, snapshot) {
              if (snapshot.hasData) {
                List<CartItem> cartItems = snapshot.data as List<CartItem>;
                double totalTax = calculateTotalTax(cartItems);
                List<CartItem>? successContents = snapshot.data;
                Set<String?> uniqueProducts = {};
                successContents?.forEach((entry) {
                  uniqueProducts.add(entry.product!.name);
                });
                int totalProducts = uniqueProducts.length;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          width: 80,
                          height: 5,
                          decoration: BoxDecoration(
                              color: AppColors.greyClr,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.SUMMARY.tr,
                                style: context.bodyLarge.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5.0, bottom: 5.0),
                              child: Text(
                                "$totalProducts Items",
                                style: context.bodyMedium
                                    .copyWith(color: AppColors.white),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.PRODUCTS.tr,
                                style: context.bodyLarge.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            Text(Strings.TOTAL.tr,
                                style: context.bodyLarge.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          cartItems[index].product?.name ?? "",
                                          style: context.bodyMedium
                                              .copyWith(fontSize: 18)),
                                    ),
                                    Text(
                                        "x ${cartItems[index].quantity.toString()}",
                                        style: context.bodyMedium.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      ((cartItems[index].price ?? 0) *
                                              (cartItems[index].quantity ?? 0))
                                          .toPrice(withSymbol: true),
                                      style: context.bodyMedium
                                          .copyWith(fontSize: 18)),
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
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.SUB_TOTAL.tr,
                                style: context.bodyMedium.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            Text(
                              calculateSubtotal(cartItems)
                                  .toPrice(withSymbol: true),
                              style: context.bodyMedium.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600),
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
                      Center(
                        child: Text(Strings.SERVICE_WITH_MOYEN.tr,
                            style: context.bodyMedium.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor)),
                      ),
                      const SpaceH8(),
                      const Divider(
                        height: 1.5,
                        thickness: 1,
                        color: AppColors.greyClr,
                      ),
                      const SpaceH8(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.SERVICE_NAME.tr,
                                style: context.bodyLarge.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            Text(Strings.TOTAL.tr,
                                style: context.bodyLarge.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.TAX.tr,
                                style: context.bodyMedium.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text(
                              totalTax
                                  .toStringAsFixed(2)
                                  .toPrice(withSymbol: true),
                              style: context.bodyMedium.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w500),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.TOTAL_SHIPPING.tr,
                                style:
                                    context.bodyMedium.copyWith(fontSize: 18)),
                            Text(
                              calculateShippingCost(cartItems)
                                  .toPrice(withSymbol: true),
                              style: context.bodyMedium.copyWith(fontSize: 18),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.TOTAL.tr,
                                style: context.bodyMedium.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text(
                              calculateTotal(cartItems)
                                  .toPrice(withSymbol: true),
                              style: context.bodyMedium.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SpaceH12(),
                      CustomButton.solid(
                          text: "Complete Order",
                          radius: 5.0,
                          textColor: AppColors.white,
                          onTap: () {
                          payController.totalPrice =calculateTotal(cartItems);
                            Get.close(-1);
                          }),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }

  double calculateSubtotal(List<CartItem> cartItems) {
    double subtotal = 0.0;
    for (var item in cartItems) {
      subtotal += (item.price ?? 0) * (item.quantity ?? 0);
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
    double totalTax = 0.0;
    for (var item in cartItems) {
      totalTax += (item.tax ?? 0) * (item.quantity ?? 0);
    }
    return totalTax;
  }

  double calculateShippingCost(List<CartItem> cartItems) {
    double shippingCost = 0.0;
    for (var item in cartItems) {
      shippingCost += (item.shippingCost ?? 0);
    }
    return shippingCost;
  }

  double calculateTotal(List<CartItem> cartItems) {
    double totalCost = 0.0;

    totalCost += calculateSubtotal(cartItems) +
        calculateTotalTax(cartItems) +
        calculateShippingCost(cartItems);

    return totalCost;
  }
}
