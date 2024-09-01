import 'package:moyen_express/repository/purchase_repository.dart';
import 'package:moyen_express/view_model/controllers/purchase_history_detail/purchase_history_detail_controller.dart';
import 'package:moyen_express/view_model/helpers/global_helper/currency_conversion.dart';

import '../../model/purchase_history/purchase_history_detail_model.dart';
import '../../resources/exports/index.dart';

class PurchasingDetail extends GetView<PurchaseHistoryDetailController> {
  const PurchasingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());

    return Scaffold(
      appBar: CustomAppBar(title: Strings.PURCHASE_HISTORY.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
                height: 600,
                width: double.maxFinite,
                color: AppColors.white,
                child: CustomFutureBuilder(
                  customLoader: const ShippingDetailShimmer(),
                  future: PurchaseRepository.getPurchaseDetail(id: controller.id),
                  hasDataBuilder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null) {
                      return const Center(child: Text("No data available"));
                    }

                    // ignore: unused_local_variable
                    final order = data.order;
                    final orderItems = data.orderItems;

                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderItems?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = orderItems?[index];
                            if (item == null) return Container(); // Avoid null item access

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ImageService.image(
                                    item.thumbnailImg ?? '',
                                    imageWidth: 100,
                                    imageSize: 100,
                                  ),
                                  const SpaceW8(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.productName ?? '',
                                        style: context.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(Strings.PURCHASE_ID.tr, style: context.bodyMedium),
                                          Text(
                                            controller.purchaseId.toString(),
                                            style: context.bodyMedium.copyWith(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(Strings.PURCHASE_DATE.tr, style: context.bodyMedium),
                                          Text(
                                            controller.dateTime.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: context.bodyMedium.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(Strings.QUANTITY.tr, style: context.bodyMedium),
                                          Text(
                                            item.quantity.toString(),
                                            style: context.bodyMedium.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
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
                        ),
                        shipOrderDetail(data, context, conversionController),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(Strings.REFUND_DESC.tr, style: context.bodyMedium),
            ),
          ),
          CustomButton(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            text: Strings.REFUND.tr,
            textColor: AppColors.white,
            backgroundColor: AppColors.primaryColor,
            radius: 5,
            onTap: () => Get.toNamed(Routes.REFUND_REQUEST),
          ),
        ],
      ),
    );
  }

  Widget shipOrderDetail(
    PurchaseHistoryDetail data,
    BuildContext context,
    CurrencyConversionController conversionController,
  ) {
    final order = data.order;
    if (order == null) return Container(); // Handle null order

    double subtotal = order.subtotal?.toDouble() ?? 0;
    double shipping = order.shipping?.toDouble() ?? 0;
    double tax = order.tax?.toDouble() ?? 0;
    double total = subtotal + shipping + tax;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Divider(
            thickness: 0.8,
            color: AppColors.black.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Strings.SELLER.tr, style: context.bodyMedium),
                  Text(
                    order.sellerName ?? '',
                    style: context.bodyMedium.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Strings.PAYMENT_STATUS.tr, style: context.bodyMedium),
                  Text(
                    order.paymentStatus ?? '',
                    style: context.bodyMedium.copyWith(
                      color: AppColors.reorder,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Strings.DELIVERY_STATUS.tr, style: context.bodyMedium),
                  Text(
                    order.deliveryStatus ?? '',
                    style: context.bodyMedium.copyWith(
                      color: AppColors.reorder,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Strings.PAYMENT_METHOD.tr, style: context.bodyMedium),
                  Text(
                    order.paymentMethod ?? '',
                    style: context.bodyMedium.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Strings.SHIPPING_ADDRESS.tr, style: context.bodyMedium),
                  SizedBox(
                    width: 170.0,
                    child: Text(
                      "${order.shippingAddress}, ${order.postalCode}, ${order.city}, ${order.country}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Strings.EMAIL_ADDRESS.tr, style: context.bodyMedium),
                  Text(
                    order.email ?? '',
                    style: context.bodyMedium.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Divider(
            thickness: 0.8,
            color: AppColors.black.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.QUANTITY.tr,
                    style: context.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SizedBox(
                      width: 0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          final quantity = data.orderItems?[index].quantity ?? 0;
                          return Text(
                            quantity.toString(),
                            style: context.bodyMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.SUB_TOTAL.tr,
                    style: context.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${conversionController.convertCurrencyAmt(amount: subtotal.toString()).value} ${conversionController.currentCurrency.value}",
                    style: context.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.SHIPPING.tr,
                    style: context.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${conversionController.convertCurrencyAmt(amount: shipping.toString()).value} ${conversionController.currentCurrency.value}",
                    style: context.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.TAX.tr,
                    style: context.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${conversionController.convertCurrencyAmt(amount: tax.toString()).value} ${conversionController.currentCurrency.value}",
                    style: context.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SpaceH12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.TOTAL_AMOUNT.tr,
                    style: context.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${conversionController.convertCurrencyAmt(amount: total.toString()).value} ${conversionController.currentCurrency.value}",
                    style: context.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
