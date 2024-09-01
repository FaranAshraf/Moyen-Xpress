import 'package:moyen_express/repository/myorders_repository.dart';
import 'package:moyen_express/view_model/helpers/global_helper/currency_conversion.dart';

import '../../model/my_orders/quote_order_detail_model.dart';
import '../../resources/exports/index.dart';
import '../../view_model/controllers/quote_detail/quote_detail_controller.dart';

class QuoteDetailView extends GetView<QuoteDetailController> {
  const QuoteDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final QuoteDetailController controller = Get.put(QuoteDetailController());
    return Scaffold(
        appBar: CustomAppBar(title: Strings.QUOTE_ORDER_DETAIL.tr),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
              width: double.maxFinite,
              color: AppColors.white,
              child: CustomFutureBuilder(
                customLoader: const ShippingDetailShimmer(),
                future: MyOrderRepository.getQuoteHistoryDetail(
                    id: controller.id.toInt()),
                hasDataBuilder: (context, snapshot) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) =>
                        shipOrderDetail(snapshot, context, index)),
              )),
        ));
  }
}

Column shipOrderDetail(AsyncSnapshot<List<QuoteOrderDetail>?> snapshot,
    BuildContext context, index) {
  final CurrencyConversionController conversionController =
      Get.put(CurrencyConversionController());
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd / HH:mm:ss');
  final subTotal = snapshot.data?[index].totalQuotePrice;
  final shippingCharges = snapshot.data?[index].deliveryCharges;
  final totalPrice = subTotal! + shippingCharges!;
  return Column(
    children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Strings.QUOTE_DETAIL.tr,
                    style: context.bodyLarge
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.PRODUCT.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].quoteName ?? "",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.QUANTITY.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "1",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.PRICE.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${conversionController.convertCurrencyAmt(amount: snapshot.data?[index].perUnitPrice.toString()).value} ${conversionController.currentCurrency.value}",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Divider(
                    thickness: 0.8,
                    color: AppColors.black.withOpacity(0.5),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Strings.QUOTE_SUMMARY.tr,
                    style: context.bodyLarge
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.ORDER_ID.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      (snapshot.data?[index].id.toString() ?? ""),
                      style: context.bodyMedium
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.CUSTOMER_NAME.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].userName ?? "",
                      style: context.bodyMedium
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.CUSTOMER_EMAIL.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].userEmail ?? "",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.SELLER_NAME,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].sellerName ?? "",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.SHIPPING_ADDRESS.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].deliveryAddress ?? "",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.ORDER_DATE.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      dateFormat.format(snapshot.data![index].createdAt!),
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.ORDER_STATUS.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].deliveryStatus ?? "",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.PAYMENT_STATUS.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].paymentType ?? "",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SpaceH14(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Divider(
                    thickness: 0.8,
                    color: AppColors.black.withOpacity(0.5),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Strings.QUOTE_AMOUNT.tr,
                    style: context.bodyLarge
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.SUB_TOTAL.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${conversionController.convertCurrencyAmt(amount: snapshot.data?[index].totalQuotePrice.toString()).value} ${conversionController.currentCurrency.value}",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.SHIPPING.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${conversionController.convertCurrencyAmt(amount: snapshot.data?[index].deliveryCharges.toString()).value} ${conversionController.currentCurrency.value}",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SpaceH20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.TOTAL_AMOUNT.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      " ${conversionController.convertCurrencyAmt(amount: totalPrice.toString()).value} ${conversionController.currentCurrency.value}",
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SpaceH20(),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
