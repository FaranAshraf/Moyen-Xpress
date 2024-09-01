import '../../../resources/exports/index.dart';
import '../../../view_model/helpers/global_helper/currency_conversion.dart';

class ProductBidBottomSheet extends GetView<ProductDetailsController> {
  final String image;
  final num minimumBid;
  final String id;

  const ProductBidBottomSheet({
    Key? key,
    required this.image,
    required this.minimumBid,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            mainAxisSize: MainAxisSize.min,
            children: [
              const SpaceH20(),
              ImageService.image(Assets.AUCTION, imageColor: AppColors.black),
              const SpaceH20(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "${Strings.BID_FOR_PRODUCT.tr} ( ${Strings.MIN_BID_AMOUNT.tr} : ${conversionController.convertCurrencyAmt(amount: minimumBid.toString()).value} ${conversionController.currentCurrency.value})",
                  style: context.titleLarge,
                  textAlign: TextAlign.center,
                ),
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
                key: controller.bidFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    controller: controller.bidAmountCtrl,
                    isRequired: true,
                    height: Sizes.HEIGHT_20,
                    labelText: Strings.BID_AMOUNT.tr,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton.solid(
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  text: Strings.SUBMIT.tr,
                  onTap: () => controller.onBidSubmit(id),
                  radius: Sizes.RADIUS_12,
                  constraints: const BoxConstraints(minHeight: 55),
                ),
              ),
              const SpaceH20(),
            ],
          ),
        ),
      ),
    );
  }
}
