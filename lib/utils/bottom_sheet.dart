import 'package:moyen_express/model/product_detail/product_detail_model.dart';
import 'package:moyen_express/resources/exports/index.dart';
import '../view_model/helpers/global_helper/currency_conversion.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final int id;
  final dynamic onTap;
  const CustomBottomSheetWidget({super.key, this.onTap, required this.id});

  @override
  Widget build(BuildContext context) {
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    final ProductDetailsController controller =
        Get.put(ProductDetailsController());
    final LocationsController locationsController =
        Get.put(LocationsController());

    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: CustomFutureBuilder<ProductData?>(
        future: controller.getProductInfo(id),
        hasDataBuilder: (context, snapshot) {
          return _buildContent(context, snapshot.data, locationsController,
              controller, conversionController);
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      ProductData? product,
      LocationsController locationsController,
      ProductDetailsController detailsController,
      CurrencyConversionController conversionController) {
    double getTaxedPrice() {
      double unitPriceUSD;

      // Convert the unit price to USD if needed
      if (product?.product?.currency == "USD") {
        unitPriceUSD = product?.product?.unitPrice?.toDouble() ?? 0.0;
      } else {
        final unitPriceString =
            product?.product?.unitPrice?.toString() ?? '0.0';
        final convertedValue = conversionController
            .convertCurrencyAmtWithType(
                amount: unitPriceString,
                toUsd: false,
                currencyType: product?.product?.currency)
            .value;

// but i am giving it here

        unitPriceUSD = double.tryParse(convertedValue) ?? 0.0;
      }

      double taxedPrice = unitPriceUSD;

      // Loop through all taxes and calculate them dynamically
      product?.product?.taxes?.forEach((taxInfo) {
        double taxAmount;
        if (conversionController.currentCurrency.value == "USD" &&
            product?.product?.currency == "USD") {
          taxAmount = taxInfo?.tax?.toDouble() ?? 0;
        } else {
          final taxString = taxInfo?.tax?.toString() ?? '0.0';
          final convertedvalue = conversionController
              .convertCurrencyAmtWithType(
                  amount: taxString,
                  currencyType: product?.product?.currency ?? 'XOF')
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
            currencyType: product?.product?.currency ?? 'XOF');

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
                currencyType: product?.product?.currency ?? 'XOF')
            .value;

        return double.tryParse(convertedValue) ?? 0.0;
      }

      return discountedPrice;
    }

    final bool colorRequired =
        product?.product.colors != null && product!.product.colors!.isNotEmpty;
    final bool sizeRequired = product?.product.choiceOptions != null &&
        product!.product.choiceOptions!.isNotEmpty &&
        product.product.choiceOptions!
            .any((option) => option.values.isNotEmpty);

    if (colorRequired || sizeRequired) {
      if (colorRequired && locationsController.colorValue.value.isEmpty) {
        locationsController.colorValue.value =
            product.product.colors![0].hexCode!;
      }
      if (sizeRequired && locationsController.sizeValue.value.isEmpty) {
        locationsController.sizeValue.value =
            product.product.choiceOptions![0].values.first;
      }
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    height: 150.0,
                    width: 150.0,
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
                      product?.product.galleryImages?[0],
                      borderRadius: 8.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(product?.product.name.toString() ?? "",
                        style: context.bodyMedium.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: "${Strings.PRICE.tr}:",
                              style: context.bodyMedium.copyWith(
                                  fontSize: 18, color: AppColors.greyClr),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "${getDiscount()} ${conversionController.currentCurrency.value}",
                                  style: context.bodyMedium
                                      .copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                                TextSpan(
                                  text: ' /PC ',
                                  style: context.bodyMedium.copyWith(
                                      fontSize: 18, color: AppColors.greyClr),
                                ),
                              ]),
                        ),
                        Row(
                          children: [
                            Text(
                              Strings.STOCK,
                              style: context.bodyMedium.copyWith(
                                  fontSize: 18, color: AppColors.greyClr),
                            ),
                            const SpaceW4(),
                            Text(
                              " ${product?.product.stock ?? 0} ${Strings.PIECES}",
                              style: context.bodyMedium.copyWith(fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: Divider(
                    thickness: 0.7,
                    color: AppColors.greyClr,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        product?.product.choiceOptions == null ||
                                product!.product.choiceOptions!.isEmpty ||
                                product.product.choiceOptions!
                                    .any((option) => option.values.isEmpty)
                            ? const SpaceH2()
                            : Text(
                                "Size: ",
                                style: context.bodyMedium.copyWith(
                                    fontSize: 18, color: AppColors.greyClr),
                              ),
                        product?.product.choiceOptions == null ||
                                product!.product.choiceOptions!.isEmpty ||
                                product.product.choiceOptions!
                                    .any((option) => option.values.isEmpty)
                            ? const SpaceH2()
                            : SizedBox(
                                height: 50,
                                child: GetBuilder<ProductDetailsController>(
                                  id: "variance",
                                  builder: (controller) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: product
                                              .product.choiceOptions?.length ??
                                          0,
                                      itemBuilder: (context, optionIndex) {
                                        return Row(
                                          children: product
                                              .product
                                              .choiceOptions![optionIndex]
                                              .values
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            final valueIndex = entry.key;
                                            final value = entry.value;
                                            return GestureDetector(
                                              onTap: () {
                                                // Select the variance by option index and value index
                                                controller.selectVariance(
                                                    optionIndex, valueIndex);
                                                // Update locationController with selected size
                                                locationsController
                                                        .attributeId.value =
                                                    product
                                                        .product
                                                        .choiceOptions![
                                                            optionIndex]
                                                        .attributeId;
                                                locationsController.sizeValue
                                                    .value = value.toString();
                                                log.e(value.toString());
                                                log.w(locationsController
                                                    .sizeValue);
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0),
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 2,
                                                    color: controller
                                                                    .selectedVarianceOptionIndex
                                                                    .value ==
                                                                optionIndex &&
                                                            controller
                                                                    .selectedVarianceValueIndex
                                                                    .value ==
                                                                valueIndex
                                                        ? AppColors.primaryColor
                                                        : Colors.grey
                                                            .withOpacity(0.3),
                                                  ),
                                                ),
                                                child: Center(
                                                    child:
                                                        Text(value.toString())),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                const SpaceH8(),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      product?.product.colors == null ||
                              product!.product.colors!.isEmpty
                          ? const SpaceH2()
                          : Text(
                              "Color: ",
                              style: context.bodyMedium.copyWith(
                                  fontSize: 18, color: AppColors.greyClr),
                            ),
                      product?.product.colors == null ||
                              product!.product.colors!.isEmpty
                          ? const SpaceH2()
                          : SizedBox(
                              height: 50,
                              width: 350,
                              child: GetBuilder<ProductDetailsController>(
                                id: "Colors",
                                builder: (controller) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: product.product.colors!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          controller.selectColor(index);
                                          log.e(product
                                              .product.colors![index].hexCode);
                                          locationsController.colorValue.value =
                                              product.product.colors![index]
                                                  .hexCode!;

                                          log.w(locationsController.colorValue);
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: controller
                                                            .selectedColorIndex
                                                            .value ==
                                                        index
                                                    ? AppColors.primaryColor
                                                    : Colors.transparent,
                                              ),
                                              color: Color(int.parse(product
                                                  .product
                                                  .colors![index]
                                                  .hexCode
                                                  .toString()
                                                  .replaceAll('#', '0xFF'))),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomButton.solid(
            margin: const EdgeInsets.all(16.0),
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
            text: Strings.ADD_TO_CART.tr,
            onTap: onTap,
            radius: Sizes.RADIUS_6,
            constraints: const BoxConstraints(minHeight: 55),
          ),
        ],
      ),
    );
  }
}
