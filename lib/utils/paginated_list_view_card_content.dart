import 'package:like_button/like_button.dart';
import 'package:moyen_express/view_model/helpers/global_helper/currency_conversion.dart';
import '../resources/exports/index.dart';

class PaginatedListViewCardContent extends StatelessWidget {
  final ListViewModel item;
  final OnCardTap? onCardTap;
  final Function(int)? onTap1;
  final Function(int)? onLeftButtonTap;
  final BoxFit? fit;
  final bool showRating;
  final bool showOnlyImage;
  final double? borderRadius;
  final bool showTopSellerOrBrands;
  final String? buttonTitle;
  final OnCardTap? onPrimaryButtonTap;
  final OnCardTap? onSecondaryButtonTap;
  final bool showOnlyRightBtn;

  const PaginatedListViewCardContent({
    Key? key,
    required this.item,
    this.onCardTap,
    this.fit,
    required this.showRating,
    this.showOnlyImage = false,
    this.borderRadius,
    this.showTopSellerOrBrands = false,
    this.buttonTitle,
    this.onPrimaryButtonTap,
    this.onSecondaryButtonTap,
    this.showOnlyRightBtn = false,
    this.onTap1,
    this.onLeftButtonTap,
  }) : super(key: key);

  String covertIntoKFormat(double amount) {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final StoreHomeController storeHomeController =
        Get.put(StoreHomeController());
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    final TechnicianController technicianController =
        Get.put(TechnicianController());
    // ignore: no_leading_underscores_for_local_identifiers
    final _prefs = GetStorage();
    bool isLiked = _prefs.read('isLiked_${item.id}') ?? false;

// Function to get the taxed price in USD
    double getTaxedPrice() {
      double unitPriceUSD;
      double taxedPrice;

      if (item?.currency == "USD") {
        unitPriceUSD = item?.price?.toDouble() ?? 0.0;
        taxedPrice = unitPriceUSD;
      } else {
        final unitPriceString = item?.price?.toString() ?? '0.0';
        final convertedValue = conversionController
            .convertCurrencyAmtWithType(
                amount: unitPriceString,
                toUsd: false,
                currencyType: item?.currency)
            .value;
        unitPriceUSD = double.tryParse(convertedValue) ?? 0.0;
        taxedPrice = unitPriceUSD;
      }

      item?.taxes?.forEach((taxInfo) {
        double? taxAmount;

        if (item?.currency == "USD") {
          taxAmount = taxInfo?.tax?.toDouble() ?? 0.0;
        } else {
          final taxString = taxInfo?.tax?.toString() ?? '0.0';
          final convertedTaxValue = conversionController
              .convertCurrencyAmtWithType(
                  amount: taxString, currencyType: item?.currency ?? 'XOF')
              .value;
          taxAmount = double.tryParse(convertedTaxValue) ?? 0.0;
        }

        final taxType = taxInfo?.taxType?.toString();
        if (taxType == 'percent' && taxAmount != 0) {
          taxAmount = (taxAmount * unitPriceUSD) / 100;
        }

        taxedPrice += taxAmount;
      });
      print('-------------- taxed price:::: ${taxedPrice}');
      return taxedPrice;
    }

    double getDiscount() {
      double unitPriceUSD = getTaxedPrice();
      double discountedPrice = 0.0;

      // Ensure discount is a valid integer value
      final discount = item?.discount?.toInt() ?? 0;

      // Ensure the discount calculation method is correctly defined and uses USD values
      final discountType = item?.discount_type?.toString();
      final discountCurrency = item?.discount_currency?.toString();

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
                currencyType: item?.currency ?? 'XOF')
            .value;

        return double.tryParse(convertedValue) ?? 0.0;
      }

      return discountedPrice;
    }

    return GestureDetector(
      onTap: () => onCardTap?.call(item.id ?? -1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              offset: const Offset(0.0, 4.0),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: showOnlyImage
              ? ImageService.image(item.image ?? "", borderRadius: borderRadius)
              : Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: showTopSellerOrBrands
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 142,
                          width: double.maxFinite,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: ImageService.image(
                                  item.image ?? "",
                                  borderRadius: 0.0,
                                  imageSize: double.maxFinite,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Divider(
                                  color: Colors.grey.shade100,
                                  indent: 0,
                                  endIndent: 0,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            item.title ?? "-",
                            style: context.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!showTopSellerOrBrands) ...[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    // getTaxedPrice().toString(),
                                    conversionController
                                                .currentCurrency.value ==
                                            'USD'
                                        ? "${getTaxedPrice().toString()} USD"
                                        : "${conversionController.convertCurrencyAmt(amount: getTaxedPrice().toString()).value} ${conversionController.currentCurrency.value}", // "\$${covertIntoKFormat(item.price ?? 0.0)}",
                                    style: context.labelMedium.copyWith(
                                      color: item.discount != null &&
                                              item.discount! > 0
                                          ? AppColors.disabled
                                          : AppColors.primaryColor,
                                      decoration: item.discount != null &&
                                              item.discount! > 0
                                          ? TextDecoration.lineThrough
                                          : null,
                                      decorationColor: item.discount != null &&
                                              item.discount! > 0
                                          ? AppColors.disabled
                                          : null,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SpaceW12(),
                                if (item.discount != 0) ...[
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      "${getDiscount().toString()} ${conversionController.currentCurrency.value}",
                                      style: context.labelMedium.copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                        if (item.rating != null && showRating) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: StarRating(
                              rating: item.rating ?? 0.0,
                              iconSize: 15,
                              alignment: showTopSellerOrBrands
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.start,
                            ),
                          ),
                        ],
                        showOnlyRightBtn
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: showOnlyRightBtn
                                    ? const SizedBox()
                                    : Row(
                                        children: [
                                          CustomButton.solid(
                                            backgroundColor: item.stock == 0
                                                ? AppColors.greyClr
                                                : AppColors.primaryColor,
                                            text: item.stock == 0
                                                ? Strings.OUT_OF_STOCK.tr
                                                : buttonTitle ??
                                                    Strings.ADD_TO_CART.tr,
                                            onTap: () => item.stock == 0
                                                ? null
                                                : onPrimaryButtonTap
                                                    ?.call(item.id ?? -1),
                                            radius: Sizes.RADIUS_4,
                                            textStyle:
                                                context.bodyMedium.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white,
                                            ),
                                            constraints: const BoxConstraints(
                                              minHeight: 25,
                                              maxHeight: 25,
                                            ),
                                          ).expanded(flex: 3),
                                          if (!showTopSellerOrBrands) ...[
                                            const SpaceW4(),
                                            LikeButton(
                                              isLiked: isLiked,
                                              likeBuilder: (bool isLiked) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.cartBtn,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Sizes.RADIUS_6)),
                                                  constraints:
                                                      const BoxConstraints(
                                                    minHeight: 25,
                                                    maxHeight: 25,
                                                  ),
                                                  child: Icon(
                                                    isLiked
                                                        ? Icons.favorite_border
                                                        : Icons.favorite_border,
                                                    color: AppColors
                                                        .white, // Change color here
                                                    size: 18,
                                                  ),
                                                );
                                              },
                                              onTap: (bool isLiked) async {
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 200));
                                                if (storeHomeController
                                                        .onDummyData.value ==
                                                    true) {
                                                  onTap1?.call(item.id ?? -1);
                                                } else {
                                                  onSecondaryButtonTap
                                                      ?.call(item.id ?? -1);
                                                }
                                                _prefs.write(
                                                    'isLiked_${item.id}',
                                                    !isLiked);
                                                return !isLiked;
                                              },
                                            )
                                          ]
                                        ],
                                      ),
                              ).flexible(),
                        const SpaceH12(),
                      ],
                    ),
                    if (!showTopSellerOrBrands) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (item.discount != null && getDiscount() > 0) ...[
                            _buildRatingTag(context)
                                .constrainedBox(maxWidth: 50),
                          ] else ...[
                            const SizedBox()
                          ],
                          if (item.stock == 0) ...[
                            _buildRatingTag(
                              context,
                              title: Strings.OUT_OF_STOCK.tr,
                              color: AppColors.error,
                            ).constrainedBox(maxWidth: 100),
                          ] else ...[
                            const SizedBox()
                          ],
                          if (item.tag == "wholesale") ...[
                            _buildRatingTag(
                              context,
                              title: Strings.WHOLESALE.tr,
                              color: const Color(0xff455a64),
                            ).constrainedBox(maxWidth: 100),
                          ],
                        ],
                      ),
                    ],
                    if (showOnlyRightBtn) ...[
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: SizedBox(
                          height: 30,
                          child: CustomButton.solid(
                            backgroundColor: AppColors.primaryColor,
                            onTap: () =>
                                onSecondaryButtonTap?.call(item.id ?? -1),
                            radius: Sizes.RADIUS_6,
                            child: technicianController.isTechProducts.value ==
                                    true
                                ? ImageService.image(Assets.ACCEPT_HEADER,
                                    scale: 1.7)
                                : ImageService.image(Assets.AUCTION),
                          ).constrainedBox(maxWidth: 40, maxHeight: 30),
                        ),
                      ),
                    ]
                  ],
                ),
        ),
      ),
    );
  }

  Align _buildRatingTag(BuildContext context, {String? title, Color? color}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        height: 23.0,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: color ?? AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              offset: const Offset(0.0, 3.0),
              blurRadius: 4.0,
            )
          ],
        ),
        child: Center(
          child: Text(
            title ??
                (item.discount_type == 'percent'
                    ? "${item.discount}%"
                    : "${item.discount}"),
            style: context.labelMedium.copyWith(color: AppColors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
