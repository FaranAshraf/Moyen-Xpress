import '../../../model/product_detail/product_detail_model.dart';
import '../../../resources/exports/index.dart';
import '../../../view_model/helpers/global_helper/currency_conversion.dart';

class AddToCartContent extends StatelessWidget {
  final ProductData? product;
  final String? title;
  const AddToCartContent({Key? key, required this.product,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());

double getTaxedPrice() {
  double unitPriceUSD;

  // Convert the unit price to USD if needed
  if (product?.product?.currency == "USD") {
    unitPriceUSD = product?.product?.unitPrice?.toDouble() ?? 0.0;
  } else {
    final unitPriceString = product?.product?.unitPrice?.toString() ?? '0.0';
    final convertedValue = conversionController
        .convertCurrencyAmtWithType(amount: unitPriceString, toUsd: false, currencyType: product?.product?.currency)
        .value;

// but i am giving it here
  
    unitPriceUSD = double.tryParse(convertedValue) ?? 0.0;
 
  }

  double taxedPrice = unitPriceUSD;

  // Loop through all taxes and calculate them dynamically
  product?.product?.taxes?.forEach((taxInfo) {
    double taxAmount;
    if (conversionController.currentCurrency.value == "USD" && product?.product?.currency == "USD"){
     taxAmount = taxInfo?.tax?.toDouble() ?? 0;
    }
    else {
      final taxString = taxInfo?.tax?.toString() ?? '0.0';
      final convertedvalue = conversionController.convertCurrencyAmtWithType(amount: taxString, currencyType: product?.product?.currency ?? 'XOF' ).value;
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
    final convertedValue = conversionController
        .convertCurrencyAmtWithType(amount: taxedPriceString, toUsd: false, currencyType: product?.product?.currency ?? 'XOF')
        ;

    // print('Converted Taxed Price in ${conversionController.currentCurrency.value}: $convertedValue');
    taxedPrice = double.tryParse(convertedValue.value) ?? 0.0;
    return taxedPrice;
  }

  return taxedPrice;

}

  double getDiscount() {
  double unitPriceUSD = getTaxedPrice();
  double discountedPrice = 0.0;

  // Ensure discount is a valid integer value
  final discount = product?.product?.discount?.toInt() ?? 0;

  // Ensure the discount calculation method is correctly defined and uses USD values
  final discountType = product?.product?.discount_type?.toString();
  final discountCurrency = product?.product?.discount_currency?.toString();
  
  if (discountType == 'amount' && discount != 0 && discountCurrency == 'USD') {
    discountedPrice = unitPriceUSD - discount;
  } else if (discountType == "percent" && discount != 0 && discountCurrency == 'USD') {
    discountedPrice = unitPriceUSD - ((unitPriceUSD * discount) / 100);
  }
  else {
    discountedPrice = unitPriceUSD;
  }

 if (conversionController.currentCurrency.value != "USD") {
    final discountedPriceString = discountedPrice.toString();
    final convertedValue = conversionController
        .convertCurrencyAmtWithType(amount: discountedPriceString, toUsd: false, currencyType: product?.product?.currency ?? 'XOF')
        .value;


    return double.tryParse(convertedValue) ?? 0.0;
  }


return discountedPrice;

  
}


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.task_alt, size: 50.0),
            const SpaceH20(),
            Text(title!.tr,
                style: context.headlineSmall),
            const SpaceH20(),
            ImageService.image(
              product?.product.galleryImages?[product!.product.selectedImageIndex] ?? "",
              borderRadius: 8.0,
              imageSize: 250.0,
              imageWidth: double.maxFinite,
            ).constrainedBox(maxWidth: 300, maxHeight: 300),
            const SpaceH10(),
            Text(product?.product.name ?? "-", style: context.headlineSmall),
            const SpaceH10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product?.product.currency == "USD"
                                    ? "${getDiscount().toString()} USD"
                                    : " ${conversionController.convertCurrencyAmt(amount: product?.product.unitPrice.toString()).value} ${conversionController.currentCurrency.value}",
                                    style: context.headlineMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).flexible(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(" / ${Strings.PIECES.tr}:"),
                ),
              ],
            ),
            const SpaceH10(),
            Row(
              children: [
                CustomButton.solid(
                  backgroundColor: AppColors.cartBtn,
                  textColor: AppColors.white,
                  text: Strings.BACK_TO_SHOPPING.tr,
                  onTap: () => Get.close(2),
                  radius: Sizes.RADIUS_6,
                ).expanded(),
                const SpaceW10(),
                CustomButton.solid(
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  text: Strings.MY_CART.tr,
                  onTap: () {
                    Get.close(1);
                    Get.toNamed(Routes.CART);
                  },
                  radius: Sizes.RADIUS_6,
                ).expanded(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
