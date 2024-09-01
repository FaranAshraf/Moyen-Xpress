import '../../../resources/exports/index.dart';
import '../../../view_model/helpers/global_helper/currency_conversion.dart';

class ProductAutoBidBottomSheet extends GetView<ProductDetailsController> {
  final String image;
   final num minimumBid;
   final String id;
  const ProductAutoBidBottomSheet({
    Key? key,
    required this.image,
    required this.minimumBid,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     // ignore: unused_local_variable
     final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(14.0),
        topRight: Radius.circular(14.0),
      ),
      child: Container(
        width: double.maxFinite,
        color: AppColors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SpaceH20(),
              ImageService.image(Assets.AUCTION, imageColor: AppColors.black),
              const SpaceH20(),
              Text(
                "${Strings.BID_FOR_PRODUCT.tr} ( ${Strings.MIN_BID_AMOUNT.tr} : ${conversionController.convertCurrencyAmt(amount: minimumBid.toString()).value} ${conversionController.currentCurrency.value} )",
                style: context.titleLarge,
              ),
              const SpaceH20(),
              ImageService.image(
                image,
                imageSize: 250.0,
                imageWidth: 250,
                borderRadius: 8.0,
              ),
              const SpaceH10(),
              Form(
                key: controller.autoBidFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        enabled: true,
                        controller: controller.startBidAmountCtrl,
                        isRequired: true,
                        height: Sizes.HEIGHT_20,
                        labelText: Strings.START_BID_AMOUNT.tr,
                        labelColor: AppColors.black,
                        textColor: AppColors.black,
                        cursorColor: AppColors.black,
                        errorColor: AppColors.black,
                        enableBorderColor: AppColors.black,
                        focusBorderColor: AppColors.primaryColor,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        controller: controller.incrementPerBidCtrl,
                        isRequired: true,
                        height: Sizes.HEIGHT_20,
                        labelText: Strings.INCREMENT_PER_BID.tr,
                        labelColor: AppColors.black,
                        textColor: AppColors.black,
                        cursorColor: AppColors.black,
                        errorColor: AppColors.black,
                        enableBorderColor: AppColors.black,
                        focusBorderColor: AppColors.primaryColor,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        controller: controller.maxBidAmountCtrl,
                        isRequired: true,
                        height: Sizes.HEIGHT_20,
                        labelText: Strings.MAXIMUM_BID_AMOUNT.tr,
                        labelColor: AppColors.black,
                        textColor: AppColors.black,
                        cursorColor: AppColors.black,
                        errorColor: AppColors.black,
                        enableBorderColor: AppColors.black,
                        focusBorderColor: AppColors.primaryColor,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton.solid(
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
                text: Strings.SUBMIT.tr,
                margin: const EdgeInsets.all(8.0),
                onTap: () => controller.onAutoBidSubmit(id),
                radius: Sizes.RADIUS_12,
                constraints: const BoxConstraints(minHeight: 55),
              ),
              const SpaceH40(),
            ],
          ),
        ),
      ),
    );
  }
}
