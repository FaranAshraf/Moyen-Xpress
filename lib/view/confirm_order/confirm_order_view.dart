import 'package:moyen_express/repository/payment_repository.dart';
import 'package:moyen_express/view_model/controllers/confirm_order/confirm_order_controller.dart';
import 'package:moyen_express/view_model/helpers/global_helper/currency_conversion.dart';
import '../../model/order_done_model/order_done_model.dart';
import '../../resources/exports/index.dart';

class ConfirmOrderView extends GetView<ConfirmOrderController> {
  const ConfirmOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd / HH:mm:ss');
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    // ignore: unused_local_variable
    final ConfirmOrderController controller = Get.put(ConfirmOrderController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<ConfirmOrderController>(
            init: ConfirmOrderController(),
            id: "timer",
            builder: (controller) {
              return FutureBuilder<OrderDone?>(
                  future: PaymentRepository.getDoneConfirmation(
                      id: PaymentRepository.orderId.toString()),
                  builder: (context, snapshot) {
                    log.e("Dekhlo ${PaymentRepository.orderId}");
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SpaceH30(),
                          SizedBox(
                            width: 200.0,
                            child: Lottie.asset(Assets.SUCCESS),
                          ),
                          Text(
                            Strings.ORDER_CONFIRMED.tr,
                            style: Get.textTheme.headlineLarge?.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black.withOpacity(0.45),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "${Strings.ORDER_SUMMARY.tr} ${snapshot.data?.userEmail ?? ''}",
                              style: Get.textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black.withOpacity(0.45),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SpaceH10(),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(10.0),
                            color: AppColors.white,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    Strings.SUMMARY_ORDER.tr,
                                    style: context.bodyLarge.copyWith(
                                        color: AppColors.black.withOpacity(0.6),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                _buildInfoRow(
                                  Strings.ORDER_DATE.tr,
                                  controller.orderData.value?.orderDate != null
                                      ? dateFormat
                                          .format(snapshot.data!.orderDate!)
                                      : '',
                                  context,
                                ),
                                _buildInfoRow("${Strings.NAME.tr}:",
                                    snapshot.data?.userName ?? "", context),
                                _buildInfoRow("${Strings.EMAIL.tr}:",
                                    snapshot.data?.userEmail ?? "", context),
                                _buildInfoRow(
                                    Strings.ORDER_STATUS.tr,
                                    snapshot.data?.deliveryStatus ?? "",
                                    context),
                                _buildInfoRow("${Strings.PAYMENT_STATUS.tr}:",
                                    "Stripe", context),
                                _buildInfoRow(
                                    "${Strings.PICKUP_ADDRESS.tr}:",
                                    snapshot.data?.shippingAddress ?? "",
                                    context,
                                    isAddress: true),
                              ],
                            ),
                          ),
                          const SpaceH4(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${Strings.ORDER_CODE.tr}:",
                                style: context.bodyMedium.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SpaceW4(),
                              Text(
                                snapshot.data?.orderCode ?? "",
                                style: context.bodyMedium.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data?.orderItems?.length ?? 0,
                            itemBuilder: (context, index) {
                              num total = (snapshot
                                          .data?.orderItems?[index].price ??
                                      0) +
                                  (snapshot.data?.orderItems?[index]
                                          .shippingCost ??
                                      0) +
                                  (snapshot.data?.orderItems?[index].tax ?? 0);

                              return Container(
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(10.0),
                                color: AppColors.white,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        Strings.ORDER_DETAIL.tr,
                                        style: context.bodyLarge.copyWith(
                                            color: AppColors.black
                                                .withOpacity(0.6),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    _buildInfoRow(
                                        "${Strings.PRODUCT.tr}:",
                                        snapshot.data?.orderItems?[index]
                                                .productName ??
                                            "",
                                        context),
                                    _buildInfoRow(
                                        "${Strings.VARIATION.tr}:",
                                        snapshot.data?.orderItems?[index]
                                                    .variation?.isEmpty ??
                                                true
                                            ? "-"
                                            : snapshot.data?.orderItems?[index]
                                                    .variation ??
                                                "",
                                        context),
                                    _buildInfoRow(
                                        "${Strings.QUANTITY.tr}:",
                                        snapshot.data?.orderItems?[index]
                                                .quantity
                                                .toString() ??
                                            "",
                                        context),
                                    _buildInfoRow(
                                        "${Strings.DELIVERY_TYPE.tr}:",
                                        snapshot.data?.orderItems?[index]
                                                    .deliveryType?.isEmpty ??
                                                true
                                            ? "Free Pickup"
                                            : snapshot.data?.orderItems?[index]
                                                    .deliveryType ??
                                                "",
                                        context),
                                    _buildInfoRow(
                                        "${Strings.PRICE.tr}:",
                                        "${conversionController.convertCurrencyAmt(amount: snapshot.data?.orderItems?[index].price.toString()).value} ${conversionController.currentCurrency.value}",
                                        context),
                                    _buildInfoRow(
                                        "${Strings.SUB_TOTAL.tr}:",
                                        "${conversionController.convertCurrencyAmt(amount: snapshot.data?.orderItems?[index].price.toString()).value} ${conversionController.currentCurrency.value}",
                                        context),
                                    _buildInfoRow(
                                        "${Strings.SHIPPING.tr}:",
                                        "${conversionController.convertCurrencyAmt(amount: snapshot.data?.orderItems?[index].shippingCost.toString()).value} ${conversionController.currentCurrency.value}",
                                        context),
                                    _buildInfoRow(
                                        "${Strings.TAX.tr}:",
                                        "${conversionController.convertCurrencyAmt(amount: snapshot.data?.orderItems?[index].tax.toString()).value} ${conversionController.currentCurrency.value}",
                                        context),
                                    _buildInfoRow(
                                        "${Strings.TOTAL.tr}:",
                                        "${conversionController.convertCurrencyAmt(amount: total.toString()).value} ${conversionController.currentCurrency.value}",
                                        context),
                                  ],
                                ),
                              );
                            },
                          ),
                          CustomButton.solid(
                            margin: const EdgeInsets.all(10.0),
                            text: "Continue Shopping",
                            radius: 5.0,
                            textColor: AppColors.white,
                            onTap: () => Get.toNamed(Routes.DASHBOARD),
                          )
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context,
      {bool isAddress = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.bodyMedium.copyWith(
            fontSize: 14,
            color: AppColors.black.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        isAddress
            ? SizedBox(
                width: 195,
                child: Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : Text(
                value,
                style: context.bodyMedium.copyWith(
                  fontSize: 14,
                  color: AppColors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
      ],
    );
  }
}
