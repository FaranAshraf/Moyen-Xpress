import '../../resources/exports/index.dart';

class OrderOverview extends GetView<PaymentMethodController> {
  const OrderOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SpaceH16(),
        Text(Strings.ORDER_OVERVIEW.tr, style: context.titleLarge),
        const SpaceH48(),
        Container(
          height: 240.0,
          width: Get.width,
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              _buildCheckCircle(),
              Text(
                Strings.THANK_YOU.tr,
                style: context.headlineSmall.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SpaceH10(),
              Text(
                Strings.THE_ORDER.tr,
                style: context.labelMedium.copyWith(
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ).constrainedBox(maxWidth: 250),
              const SpaceH20(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          controller.orderData.totalAmount
                              .toPrice(withSymbol: true),
                          style: context.labelLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          Strings.TOTAL_AMOUNT.tr,
                          style: context.labelSmall.copyWith(
                            color: AppColors.greyShade4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          controller.orderData.noOfItems?.toString() ?? "-",
                          style: context.labelLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          Strings.ITEMS_ORDER.tr,
                          style: context.labelSmall.copyWith(
                            color: AppColors.greyShade4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          controller.orderData.deliveryDate
                                  ?.format(pattern: "dd-MM-yyyy") ??
                              "-",
                          style: context.labelLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          Strings.EST_DELIVERY.tr,
                          style: context.labelSmall.copyWith(
                            color: AppColors.greyShade4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CustomButton.solid(
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.white,
          text: Strings.CONTINUE_SHOPPING.tr,
          onTap: controller.onContinueShopping,
          radius: Sizes.RADIUS_6,
        ),
      ],
    );
  }

  ConstrainedBox _buildCheckCircle() {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -50.0,
          left: 0,
          right: 0,
          child: Container(
            height: 100.0,
            width: 100.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Container(
              margin: const EdgeInsets.all(7.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.white,
                size: 50.0,
              ),
            ),
          ),
        ),
      ],
    ).constrainedBox(maxHeight: 80.0, maxWidth: 120.0);
  }
}
