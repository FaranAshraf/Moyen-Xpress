// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moyen_express/model/product_detail/product_detail_model.dart';
import 'package:moyen_express/repository/cart_repository.dart';
import '../../repository/wishlist_repository.dart';
import '../../resources/exports/index.dart';
import '../../utils/bottom_sheet.dart';
import '../../view_model/helpers/global_helper/currency_conversion.dart';

// ignore: must_be_immutable
class ProductsDetails extends GetView<ProductDetailsController> {
  const ProductsDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationsController locationsController =
        Get.put(LocationsController());
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());


    return Obx(
      () => Container(
        color: AppColors.white,
        child: CustomFutureBuilder<ProductData?>(
          customLoader: ProductsDetailsShimmer(
            isAuctionProduct: controller.isAuctionProduct,
          ),
          future: controller.getProductInfo(controller.newValue.value.isEmpty
              ? controller.proId
              : controller.newValue.value.toInt()),
          hasDataBuilder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                    width: Sizes.WIDTH_24,
                    height: Sizes.HEIGHT_24,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.0, color: AppColors.primaryColor)),
              );
            } 
            
            else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
              // ignore: unrelated_type_equality_checks
            } else if (snapshot.data == [] ||
                GetUtils.isBlank(snapshot.data)!) {
              return _buildContent(context, snapshot.data, locationsController,
                  conversionController, locationsController);
            } else if (snapshot.hasData) {
              return _buildContent(context, snapshot.data, locationsController,
                  conversionController, locationsController);
            } else {
              return const Center(child: Text('No data available'));
            }
            // else {
            //  return _buildContent(context, snapshot.data, locationsController,
            //        conversionController, locationsController);
            // }
          },
        ),
      ),
    );
  }

  Scaffold _buildContent(
      BuildContext context,
      ProductData? product,
      LocationsController locationController,
      CurrencyConversionController conversionController,
     
      LocationsController locationsController) {


    final bool colorRequired =
        product?.product.colors != null && product!.product.colors!.isNotEmpty;
    final bool sizeRequired = product?.product.choiceOptions != null &&
        product!.product.choiceOptions!.isNotEmpty &&
        product.product.choiceOptions!
            .any((option) => option.values.isNotEmpty);

    if (colorRequired || sizeRequired) {
      if (colorRequired && locationController.colorValue.value.isEmpty) {
        locationController.colorValue.value =
            product.product.colors![0].hexCode!;
      }
      if (sizeRequired && locationController.sizeValue.value.isEmpty) {
        locationController.sizeValue.value =
            product.product.choiceOptions![0].values.first;
      }
    }

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


    



    return Scaffold(
      // backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: controller.isAuctionProduct
            ? Strings.AUCTION_PRODUCT_DETAILS.tr
            : Strings.PRODUCT_DETAILS.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250.0,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: AppColors.imageContainer,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.05),
                      offset: const Offset(0.0, 4.0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: _buildImages(product),
              ),
              const SpaceH10(),
              Center(
                child: Text(
                  product?.product.name ?? "",
                  style: context.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const SpaceH4(),
              if (!controller.isAuctionProduct) ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SpaceW4(),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_border_outlined,
                            color: AppColors.primaryColor,
                          ),
                          const SpaceW4(),
                          Text(controller.isAuctionProduct
                              ? ""
                              : "${product?.product.rating ?? 0}/5 ( ${5} )"),
                        ],
                      ),
                      const SpaceW8(),
                      Row(
                        children: [
                          Image.asset(
                            Assets.SHIPPING_ORDER,
                            scale: 2.1,
                            color: AppColors.primaryColor,
                          ),
                          const SpaceW4(),
                          Text(
                            controller.isAuctionProduct
                                ? "${product?.product.shippingDays ?? 0} ${Strings.DAYS.tr}"
                                : "${product?.product.shippingDays ?? 0} ${Strings.DAYS.tr}",
                            style: context.bodyMedium.copyWith(fontSize: 17),
                          ),
                        ],
                      ),
                      const SpaceW8(),
                      Row(
                        children: [
                          Text(
                            Strings.STOCK.tr,
                            style: context.bodyMedium.copyWith(fontSize: 17),
                          ),
                          const SpaceW4(),
                          Text(
                            "${product?.product.stock ?? 0} ${Strings.PIECES}",
                            style: context.bodyMedium.copyWith(fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.UNIT_PRICE.tr,
                            style: context.bodyLarge.copyWith(fontSize: 18),
                          ),
                          Text(
                           "${getTaxedPrice().toString()} ${conversionController.currentCurrency.value}",
                           style: context.bodyLarge.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                     
                 
                
                          product?.product.discount == 0
                          ? const SpaceH4()
                          : Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.DISCOUNT_PRICE.tr,
                                  style: context.bodyLarge
                                      .copyWith(fontSize: 18),
                                ),
                                Text(
                                  getDiscount().toString(),
                                  style: context.bodyLarge
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                const SpaceH4(),
                ((product?.product.choiceOptions == null ||
                            product!.product.choiceOptions!.isEmpty ||
                            product.product.choiceOptions!
                                .any((option) => option.values.isEmpty)) ||
                        product.product.colors == null ||
                        product.product.colors!.isEmpty)
                    ? const SpaceH2()
                    : Container(
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.VARIATIONS.tr,
                              style: context.bodyLarge.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  product.product.choiceOptions == null ||
                                          product.product.choiceOptions!
                                              .isEmpty ||
                                          product.product.choiceOptions!
                                              .any((option) =>
                                                  option.values.isEmpty)
                                      ? const SpaceH2()
                                      : Text(
                                          "${Strings.SIZE.tr}:",
                                          style: context.bodyMedium
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: AppColors.black),
                                        ),
                                  product.product.choiceOptions == null ||
                                          product.product.choiceOptions!
                                              .isEmpty ||
                                          product.product.choiceOptions!
                                              .any((option) =>
                                                  option.values.isEmpty)
                                      ? const SpaceH2()
                                      : SizedBox(
                                          height: 50,
                                          child: GetBuilder<
                                              ProductDetailsController>(
                                            id: "variance",
                                            builder: (controller) {
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: product
                                                        .product
                                                        .choiceOptions
                                                        ?.length ??
                                                    0,
                                                itemBuilder:
                                                    (context, optionIndex) {
                                                  return Row(
                                                    children: product
                                                        .product
                                                        .choiceOptions![
                                                            optionIndex]
                                                        .values
                                                        .asMap()
                                                        .entries
                                                        .map((entry) {
                                                      final valueIndex =
                                                          entry.key;
                                                      final value =
                                                          entry.value;
                                                      return GestureDetector(
                                                        onTap: () {
                                                          // Select the variance by option index and value index
                                                          controller
                                                              .selectVariance(
                                                                  optionIndex,
                                                                  valueIndex);
                                                          // Update locationController with selected size
                                                          locationController
                                                                  .attributeId
                                                                  .value =
                                                              product
                                                                  .product
                                                                  .choiceOptions![
                                                                      optionIndex]
                                                                  .attributeId;
                                                          locationController
                                                                  .sizeValue
                                                                  .value =
                                                              value
                                                                  .toString();
                                                          log.e(value
                                                              .toString());
                                                          log.w(locationController
                                                              .sizeValue);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left:
                                                                      10.0),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  15.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            border:
                                                                Border.all(
                                                              width: 2,
                                                              color: controller.selectedVarianceOptionIndex.value ==
                                                                          optionIndex &&
                                                                      controller.selectedVarianceValueIndex.value ==
                                                                          valueIndex
                                                                  ? AppColors
                                                                      .primaryColor
                                                                  : Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                            ),
                                                          ),
                                                          child: Center(
                                                              child: Text(value
                                                                  .toString())),
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
                            const SpaceH8(),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  product.product.colors == null ||
                                          product.product.colors!.isEmpty
                                      ? const SpaceH2()
                                      : Text(
                                          "Color: ",
                                          style: context.bodyMedium
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: AppColors.black),
                                        ),
                                  product.product.colors == null ||
                                          product.product.colors!.isEmpty
                                      ? const SpaceH2()
                                      : SizedBox(
                                          height: 50,
                                          width: 350,
                                          child: GetBuilder<
                                              ProductDetailsController>(
                                            id: "Colors",
                                            builder: (controller) {
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: product
                                                    .product.colors!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .selectColor(
                                                              index);
                                                      log.e(product
                                                          .product
                                                          .colors![index]
                                                          .hexCode);
                                                      locationController
                                                              .colorValue
                                                              .value =
                                                          product
                                                              .product
                                                              .colors![
                                                                  index]
                                                              .hexCode!;
                
                                                      log.w(
                                                          locationController
                                                              .colorValue);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: 10.0),
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          border:
                                                              Border.all(
                                                            width: 2,
                                                            color: controller
                                                                        .selectedColorIndex
                                                                        .value ==
                                                                    index
                                                                ? AppColors
                                                                    .primaryColor
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                          color: Color(int
                                                              .parse(product
                                                                  .product
                                                                  .colors![
                                                                      index]
                                                                  .hexCode
                                                                  .toString()
                                                                  .replaceAll(
                                                                      '#',
                                                                      '0xFF'))),
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
                const SpaceH8(),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(Strings.AUCTION_WILL_END.tr,
                          style: context.bodyMedium.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                    ),
                    const SpaceW8(),
                    CountDownTimer(
                      duration: controller.isAuctionProduct
                          ? product?.product.auctionEndDate
                          : null,
                      showSeeAll: false,
                    ),
                  ],
                ),
              ],
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.REFUNDABLE.tr,
                          style: context.bodyLarge.copyWith(fontSize: 18),
                        ),
                        Text(
                          product?.product.refundAble?.isOdd ?? false
                              ? Strings.AVAILABLE.tr
                              : Strings.NOT_AVAILABLE.tr,
                          style: context.bodyLarge.copyWith(
                              fontSize: 18, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SpaceH8(),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.SHARE.tr,
                        style: context.bodyLarge.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                          width: 400,
                          height: 50,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                shareUrl(
                                    Assets.OUTLOOK, product?.socialUrls.email),
                                shareUrl(Assets.MESSENGER,
                                    product?.socialUrls.messenger),
                                shareUrl(Assets.PINTEREST,
                                    product?.socialUrls.pinterest),
                                shareUrl(
                                    Assets.REDDIT, product?.socialUrls.reddit),
                                shareUrl(
                                    Assets.FB, product?.socialUrls.facebook),
                                shareUrl(Assets.VK, product?.socialUrls.vk),
                                shareUrl(Assets.WHATSAPP,
                                    product?.socialUrls.whatsapp),
                                shareUrl(
                                    Assets.KOO_APP, product?.socialUrls.koo),
                                shareUrl(Assets.X, product?.socialUrls.twitter),
                              ],
                            ),
                          ))
                    ]),
              ),
              const SpaceH8(),
              SellerDetails(
                seller: SellerData(),
                sellerImg: product?.product.shop?.logo ?? "",
                sellerName: product?.product.shop?.name ?? "-",
                rating: product?.product.shop?.rating ?? "-",
                id: product?.product.shop?.id ?? 0,
              ),
              const SpaceH8(),
              Container(
                height: 200,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ProductDetailsTabs(
                  tab: [
                    Tab(
                        text: controller.isAuctionProduct
                            ? Strings.PRODUCT_INFO.tr
                            : Strings.DESCRIPTION.tr),
                    Tab(
                        text: controller.isAuctionProduct
                            ? Strings.DESCRIPTION.tr
                            : Strings.NOTE.tr),
                    // Tab(text: Strings.REVIEWS_RATING.tr),
                    // if (!controller.isAuctionProduct) ...[
                    //   Tab(text: Strings.CUSTOMER_Q_A.tr),
                    // ]
                    if (controller.isAuctionProduct) ...[
                      Tab(text: Strings.DESCRIPTION.tr),
                    ],
                  ],
                  children: [
                    if (controller.isAuctionProduct) ...[
                      CustomFutureBuilder<AuctionProductInfoModel?>(
                        future: controller.getAuctionProductInfo(),
                        data: (info) =>
                            controller.info = info ?? AuctionProductInfoModel(),
                        hasDataBuilder: (_, __) {
                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                const SpaceH16(),
                                _buildInfoText(
                                    context,
                                    Strings.STARTING_BIDING.tr,
                                    "${conversionController.convertCurrencyAmtWithType(currencyType: product?.product?.currency ?? 'XOF' ,amount: product!.product.startingBid.toString()).value} ${conversionController.currentCurrency.value}",
                                    "/ ${product.product.unit}"),
                                _buildInfoText(
                                    context,
                                    Strings.MY_BIDDING_AMOUNT.tr,
                                    controller.info.productCondition ?? "",
                                    ""),
                                _buildInfoText(
                                    context,
                                    Strings.HIGHEST_BID.tr,
                                    "${conversionController.convertCurrencyAmtWithType(currencyType: product?.product?.currency ?? 'XOF' ,amount: product.product.highestBid.toString()).value} ${conversionController.currentCurrency.value}",
                                    ""),
                                Column(
                                  children: [
                                    if (product.product.productCondition !=
                                            null ||
                                        product.product.vehicleCondition !=
                                            null)
                                      _buildInfoText(
                                          context,
                                          product.product.vehicleCondition ==
                                                  null
                                              ? Strings.PRODUCT_CONDITION.tr
                                              : Strings.VEHICLE_CONDITION.tr,
                                          product.product.vehicleCondition ==
                                                  null
                                              ? product.product.productCondition
                                                  .toString()
                                              : product.product.vehicleCondition
                                                  .toString(),
                                          ""),
                                    // Other widgets can be added here
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                    HtmlText(
                      showReadMore: false,
                      jsonData: product?.product.description ?? "",
                    ),
                    HtmlText(
                      showReadMore: false,
                      jsonData: controller.isAuctionProduct
                          ? "No Reviews Found"
                          : product?.product.note?.isEmpty ?? true
                              ? "No Note Found"
                              : product?.product.note ?? "",
                    ),
                    // if (!controller.isAuctionProduct) ...[
                    //   product?.product.reviews?.isEmpty ?? true
                    //       ? const Padding(
                    //           padding: EdgeInsets.all(4.0),
                    //           child: Text("No Reviews Found"),
                    //         )
                    //       : SingleChildScrollView(
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 "Customer Reviews: ",
                    //                 style: context.bodyLarge.copyWith(
                    //                     fontSize: 22,
                    //                     fontWeight: FontWeight.w600,
                    //                     color: AppColors.primaryColor),
                    //               ),
                    //               ListView.builder(
                    //                   shrinkWrap: true,
                    //                   physics:
                    //                       const AlwaysScrollableScrollPhysics(),
                    //                   itemCount:
                    //                       product?.product.reviews!.length,
                    //                   itemBuilder: (context, index) {
                    //                     return Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.start,
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Padding(
                    //                           padding: const EdgeInsets.only(
                    //                               top: 5.0),
                    //                           child: Text(
                    //                             "${index + 1}. ",
                    //                             style: context.bodyMedium,
                    //                           ),
                    //                         ),
                    //                         const SpaceW4(),
                    //                         Padding(
                    //                           padding: const EdgeInsets.only(
                    //                               top: 4.0),
                    //                           child: SizedBox(
                    //                             width: 370,
                    //                             child: Text(
                    //                               product!.product
                    //                                   .reviews![index].comment
                    //                                   .toString(),
                    //                               overflow:
                    //                                   TextOverflow.ellipsis,
                    //                               maxLines: 4,
                    //                               style: context.bodyMedium,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     );
                    //                   })
                    //             ],
                    //           ),
                    //         ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.vertical,
                    //   child: Column(
                    //     children: [
                    //       ListView.builder(
                    //           shrinkWrap: true,
                    //           itemCount:
                    //               product?.product.questions?.length ?? 0,
                    //           itemBuilder: (context, index) {
                    //             final question =
                    //                 product?.product.questions?[index];
                    //             return Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               children: [
                    //                 const SpaceH4(),
                    //                 Row(
                    //                   children: [
                    //                     question?.user?.logo != null
                    //                         ? ImageService.image(
                    //                             question?.user?.logo,
                    //                             scale: 2.6)
                    //                         : ImageService.image(""),
                    //                     const SpaceW10(),
                    //                     Text(
                    //                       question?.user?.name?.toString() ??
                    //                           "No questions Found",
                    //                       style: context.bodyLarge.copyWith(
                    //                           fontSize: 20,
                    //                           fontWeight: FontWeight.w500),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Text(
                    //                   "Q: ${question?.question}",
                    //                   style: context.bodyLarge,
                    //                 ),
                    //                 Text(
                    //                   "A: ${question?.user?.name}",
                    //                   style: context.bodyLarge,
                    //                 ),
                    //               ],
                    //             );
                    //           }),
                    //       const SpaceH4(),

                    //       // ListView.builder(
                    //       //   shrinkWrap: true,
                    //       //   physics: const NeverScrollableScrollPhysics(),
                    //       //   itemCount: product?.questions?.length ?? 0,
                    //       //   itemBuilder: (context, index) {
                    //       //     final question = product?.questions?[index];
                    //       //     final answers = question?.answers ?? [];

                    //       //     if (answers.isEmpty) {
                    //       //       return Column(
                    //       //         crossAxisAlignment: CrossAxisAlignment.start,
                    //       //         children: [
                    //       //           Text(
                    //       //             "Q: ${question?.question ?? ""}",
                    //       //             style: context.bodyMedium,
                    //       //           ),
                    //       //           Text(
                    //       //             " No Answer",
                    //       //             style: context.bodyMedium,
                    //       //           ),
                    //       //         ],
                    //       //       );
                    //       //     }

                    //       //     final items = [question, ...answers];

                    //       //     return Column(
                    //       //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       //       children: items.map((item) {
                    //       //         if (item is Question) {
                    //       //           return Column(
                    //       //             children: [
                    //       //               Text(product?.questions?[index]?.askUser
                    //       //                       ?.askName ??
                    //       //                   "No name available"),
                    //       //               Text(
                    //       //                 "Q: ${item.question ?? ""}",
                    //       //                 style: context.bodyMedium,
                    //       //               ),
                    //       //             ],
                    //       //           );
                    //       //         } else if (item is Answer) {
                    //       //           return Text(
                    //       //             "A: ${item.answer ?? ""}",
                    //       //             style: context.bodyMedium,
                    //       //           );
                    //       //         } else {
                    //       //           return const SizedBox.shrink();
                    //       //         }
                    //       //       }).toList(),
                    //       //     );
                    //       //   },
                    //       // ),
                    //       // const SpaceH4(),
                    //       const SpaceH8(),
                    //       SizedBox(
                    //         width: 200,
                    //         child: CustomButton(
                    //           text: "Ask Questions",
                    //           radius: 5.0,
                    //           textColor: AppColors.white,
                    //           onTap: () {
                    //             CustomDialog.showDialog(
                    //                 width: 370,
                    //                 height: 300,
                    //                 content: Form(
                    //                   key: controller.askQuestionForm,
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.symmetric(
                    //                         horizontal: 10, vertical: 5),
                    //                     child: Column(
                    //                       children: [
                    //                         const SpaceH10(),
                    //                         Center(
                    //                             child: Text(
                    //                           "Ask Questions",
                    //                           style: context.bodyLarge
                    //                               .copyWith(
                    //                                   fontSize: 20,
                    //                                   fontWeight:
                    //                                       FontWeight.w500,
                    //                                   color: AppColors
                    //                                       .primaryColor),
                    //                         )),
                    //                         const SpaceH20(),
                    //                         CustomTextFormField(
                    //                           controller: controller
                    //                               .questionController,
                    //                           isRequired: true,
                    //                           height: Sizes.HEIGHT_16,
                    //                           labelText: Strings.QUESTION.tr,
                    //                           hintText: "Write A Question..",
                    //                           labelColor: AppColors.black,
                    //                           textColor: AppColors.black,
                    //                           cursorColor: AppColors.black,
                    //                           maxLines: 3,
                    //                           errorColor: AppColors.error,
                    //                           enableBorderColor:
                    //                               AppColors.black,
                    //                           focusBorderColor:
                    //                               AppColors.primaryColor,
                    //                           textInputAction:
                    //                               TextInputAction.next,
                    //                           keyboardType:
                    //                               TextInputType.emailAddress,
                    //                         ),
                    //                         const SpaceH20(),
                    //                         CustomButton.solid(
                    //                           showIconOnRight: true,
                    //                           text: "Send",
                    //                           backgroundColor:
                    //                               AppColors.primaryColor,
                    //                           textColor: AppColors.white,
                    //                           icon: const Icon(
                    //                             Icons.send,
                    //                             color: AppColors.white,
                    //                           ),
                    //                           radius: 5.0,
                    //                           onTapAsync: () async =>
                    //                               controller
                    //                                   .askQuestionProduct(),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ));
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // ]
                  ],
                ),
              ),
              const SpaceH8(),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.REVIEWS_RATING.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SpaceH2(),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.greyClr,
                    ),
                    const SpaceH2(),
                    Text(
                      Strings.CUSTOMER_REVIEWS.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        StarRating(
                          rating: product?.product.rating?.toDouble() ?? 0.0,
                          iconSize: 30.0,
                          alignment: MainAxisAlignment.start,
                        ),
                        Row(
                          children: [
                            Text(
                              product?.ratingReviews.averageRating ?? "",
                              style: context.bodyLarge.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              " Out of 5",
                              style: context.bodyLarge.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "${product?.ratingReviews.globalRatings} ${Strings.GLOBAL_RATINGS.tr}",
                      style: context.bodyLarge.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    _buildRatingRow(
                        5, product?.ratingReviews.ratingsByStar?.fiveStar),
                    const SpaceH4(),
                    _buildRatingRow(
                        4, product?.ratingReviews.ratingsByStar?.fourStar),
                    const SpaceH4(),
                    _buildRatingRow(
                        3, product?.ratingReviews.ratingsByStar?.threeStar),
                    const SpaceH4(),
                    _buildRatingRow(
                        2, product?.ratingReviews.ratingsByStar?.twoStar),
                    const SpaceH4(),
                    _buildRatingRow(
                        1, product?.ratingReviews.ratingsByStar?.oneStar),
                  ],
                ),
              ),
              const SpaceH8(),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.RATING_FEATURE.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SpaceH2(),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.greyClr,
                    ),
                    featureMethod(
                        Strings.EASE_TO_USE.tr,
                        product,
                        product?.ratingReviews.customerRatingsFeature?.easyToUse
                                ?.toStringAsFixed(1)
                                .toDouble() ??
                            0.0),
                    const SpaceH4(),
                    featureMethod(
                        Strings.VALUE_OF_MONEY.tr,
                        product,
                        product?.ratingReviews.customerRatingsFeature
                                ?.valueForMoney
                                ?.toStringAsFixed(1)
                                .toDouble() ??
                            0.0),
                    const SpaceH4(),
                    featureMethod(
                        Strings.DURABILITY.tr,
                        product,
                        product?.ratingReviews.customerRatingsFeature!
                                .durability
                                ?.toStringAsFixed(1)
                                .toDouble() ??
                            0.0),
                    const SpaceH4(),
                    featureMethod(
                        Strings.TEMP_CONTROL.tr,
                        product,
                        product?.ratingReviews.customerRatingsFeature
                                ?.temperatureControl
                                ?.toStringAsFixed(1)
                                .toDouble() ??
                            0.0),
                    const SpaceH4(),
                    featureMethod(
                        Strings.VERSATILITY.tr,
                        product,
                        product?.ratingReviews.customerRatingsFeature
                                ?.versatility
                                ?.toStringAsFixed(1)
                                .toDouble() ??
                            0.0),
                    const SpaceH4(),
                    featureMethod(
                        Strings.EASE_TO_CLEAN.tr,
                        product,
                        product?.ratingReviews.customerRatingsFeature
                                ?.easyToClean
                                ?.toStringAsFixed(1)
                                .toDouble() ??
                            0.0),
                    const SpaceH8(),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.greyClr,
                    ),
                    const SpaceH8(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.QA.tr,
                          style: context.bodyLarge.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SpaceH4(),
                        CustomTextFormField(
                          controller: controller.questionController,
                          isRequired: true,
                          height: Sizes.HEIGHT_16,
                          labelText: Strings.QUESTION.tr,
                          hintText: "Write A Question..",
                          labelColor: AppColors.black,
                          textColor: AppColors.black,
                          cursorColor: AppColors.black,
                          maxLines: 3,
                          errorColor: AppColors.error,
                          enableBorderColor: AppColors.black,
                          focusBorderColor: AppColors.primaryColor,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SpaceH4(),
                        CustomButton.solid(
                          showIconOnRight: true,
                          text: Strings.SUBMIT.tr,
                          backgroundColor: AppColors.primaryColor,
                          textColor: AppColors.white,
                          radius: 5.0,
                          onTapAsync: () async =>
                              controller.askQuestionProduct(),
                        ),
                        const SpaceH8(),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.greyClr,
                        ),
                        const SpaceH16(),
                      ],
                    ),
                    const SpaceH4(),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: product?.ratingReviews.reviews?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageService.image(product
                                        ?.ratingReviews.reviews?[index].image ??
                                    ""),
                                const SpaceW4(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(product?.ratingReviews.reviews?[index]
                                            .userName ??
                                        ""),
                                    Text(product?.ratingReviews.reviews?[index]
                                            .date ??
                                        ""),
                                    const SpaceH4(),
                                    SizedBox(
                                      width: 330.0,
                                      child: Text(
                                        product?.ratingReviews.reviews?[index]
                                                .comment ??
                                            "",
                                        maxLines: 8,
                                        style: context.bodyMedium
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    reviewPart(
                                        context,
                                        product,
                                        index,
                                        Strings.EASE_TO_USE.tr,
                                        "(${product?.ratingReviews.reviews?[index].ratingsByFeature?.easyToUse})"),
                                    reviewPart(
                                        context,
                                        product,
                                        index,
                                        Strings.VALUE_OF_MONEY.tr,
                                        "(${product?.ratingReviews.reviews?[index].ratingsByFeature?.valueForMoney})"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    reviewPart(
                                        context,
                                        product,
                                        index,
                                        Strings.DURABILITY.tr,
                                        "(${product?.ratingReviews.reviews?[index].ratingsByFeature?.durability})"),
                                    reviewPart(
                                        context,
                                        product,
                                        index,
                                        Strings.TEMP_CONTROL.tr,
                                        "(${product?.ratingReviews.reviews?[index].ratingsByFeature?.temperatureControl})"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    reviewPart(
                                        context,
                                        product,
                                        index,
                                        Strings.VERSATILITY.tr,
                                        "(${product?.ratingReviews.reviews?[index].ratingsByFeature?.durability})"),
                                    reviewPart(
                                        context,
                                        product,
                                        index,
                                        Strings.EASE_TO_CLEAN.tr,
                                        "(${product?.ratingReviews.reviews?[index].ratingsByFeature?.temperatureControl})"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey, // Customize the divider color
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SpaceH8(),
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.TOP_SELLING_PRODUCT.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SpaceH8(),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.greyClr,
                    ),
                    const SpaceH8(),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: product?.topSellingProducts.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: Sizes.WIDTH_18,
                        mainAxisSpacing: Sizes.HEIGHT_20,
                        childAspectRatio: 3 / 3.5,
                      ),
                      itemBuilder: (context, index) =>
                          PaginatedListViewCardContent(
                        item: product!.topSellingProducts[index],
                        showRating: true,
                        onPrimaryButtonTap: (productId) async {
                          Get.bottomSheet(
                            CustomBottomSheetWidget(
                                id: productId,
                                onTap: () {
                                  CartRepository.cartAPi(
                                      productType: "product",
                                      productId: productId.toInt(),
                                      quantity: 1,
                                      color: locationsController
                                          .colorValue.value
                                          .toString(),
                                      size: locationsController.sizeValue.value
                                          .toString());
                                  Get.back();
                                }),
                          );
                        },
                        onCardTap: (id) => controller.updateId(id.toString()),
                        onSecondaryButtonTap: (id) {
                          WishlistRepository.addToWishList(
                              productId: id.toString());
                          log.e(id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SpaceH8(),
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.RELATED_PRODUCTS.tr,
                      style: context.bodyLarge
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SpaceH8(),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.greyClr,
                    ),
                    const SpaceH8(),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: product?.relatedProducts.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: Sizes.WIDTH_18,
                        mainAxisSpacing: Sizes.HEIGHT_20,
                        childAspectRatio: 3 / 3.5,
                      ),
                      itemBuilder: (context, index) =>
                          PaginatedListViewCardContent(
                        item: product!.relatedProducts[index],
                        showRating: true,
                        onPrimaryButtonTap: (productId) async {
                          Get.bottomSheet(
                            CustomBottomSheetWidget(
                                id: productId,
                                onTap: () {
                                  CartRepository.cartAPi(
                                      productType: "product",
                                      productId: productId.toInt(),
                                      quantity: 1,
                                      color: locationsController
                                          .colorValue.value
                                          .toString(),
                                      size: locationsController.sizeValue.value
                                          .toString());
                                  Get.back();
                                }),
                          );
                        },
                        onCardTap: (id) => controller.updateId(id.toString()),
                        onSecondaryButtonTap: (id) {
                          WishlistRepository.addToWishList(
                              productId: id.toString());
                          log.e(id);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        width: double.maxFinite,
        height: 90.0,
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(color: AppColors.scaffoldBackground),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton.solid(
                text: controller.isAuctionProduct
                    ? Strings.PLACE_BID.tr
                    : Strings.SEND_INQUIRY,
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
                radius: Sizes.RADIUS_6,
                onTap: () => controller.isAuctionProduct
                    ? controller.onLeftBtnTap(
                        context,
                        product?.product.thumbnailImg ?? "",
                        ((product?.product.minimumBid)! +
                            (product?.product.highestBid ?? 0.0)),
                        product!.product.id.toString())
                    : Get.toNamed(Routes.SEND_INQUIRY, arguments: {
                        "productName": product?.product.name,
                        "id": product?.product.id
                      })).constrainedBox(maxHeight: 50, maxWidth: 170),
            const SpaceW16(),
            if (!controller.isAuctionProduct) ...[
              CustomButton.solid(
                backgroundColor: AppColors.cartBtn,
                textColor: AppColors.white,
                radius: Sizes.RADIUS_6,
                child: ImageService.image(
                  controller.isAuctionProduct
                      ? Assets.AUCTION
                      : Icons.shopping_cart_outlined,
                  imageColor: AppColors.white,
                  scale: 1.5,
                ),
                onTap: () => Get.toNamed(Routes.CART),
              ).constrainedBox(maxHeight: 50, maxWidth: 80),
            ],
            const SpaceW10(),
            product?.product.stock == 0
                ? CustomButton.solid(
                    backgroundColor: controller.isAuctionProduct
                        ? AppColors.primaryColor
                        : AppColors.greyClr,
                    textColor: AppColors.white,
                    text: controller.isAuctionProduct
                        ? Strings.AUTO_BID
                        : Strings.OUT_OF_STOCK,
                    radius: Sizes.RADIUS_6,
                    onTapAsync: () async {
                      controller.isAuctionProduct
                          ? controller.onRightBtnTap(
                              context,
                              product?.product.thumbnailImg ?? "",
                              product,
                              ((product?.product.minimumBid)! +
                                  (product?.product.highestBid ?? 0.0)),
                              product!.product.id.toString())
                          : log.e("test");
                    },
                  ).constrainedBox(maxHeight: 60, maxWidth: 150)
                : CustomButton.solid(
                    backgroundColor: AppColors.primaryColor,
                    textColor: AppColors.white,
                    text: controller.isAuctionProduct
                        ? Strings.AUTO_BID
                        : Strings.BUY_NOW,
                    radius: Sizes.RADIUS_6,
                    onTap: () {
                      CartRepository.cartAPi(
                        productType: "product",
                        productId: product?.product.id?.toInt(),
                        quantity: product?.product.minQty,
                        color: locationController.colorValue.value.toString(),
                        size: locationController.sizeValue.value.toString(),
                      );
                      controller.onRightBtnTap(
                          context,
                          product?.product.thumbnailImg ?? "",
                          product,
                          ((product?.product.minimumBid)! +
                              (product?.product.highestBid ?? 0.0)),
                          product!.product.id.toString());
                    },
                  ).constrainedBox(maxHeight: 60, maxWidth: 150),
          ],
        ),
      ),
    );
  }

  Padding shareUrl(img, url) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => controller.launchURL(url),
        child: ImageService.image(img, scale: 3.8),
      ),
    );
  }

  Container reviewPart(
      BuildContext context, ProductData? product, int index, title, rating) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: context.bodyMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SpaceW2(),
          const Icon(
            Icons.star_border,
            color: AppColors.primaryColor,
          ),
          const SpaceW2(),
          Text(
            rating,
            style: context.bodyMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Row featureMethod(title, ProductData? product, double rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Get.context!.bodyLarge
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
        Row(
          children: [
            StarRating(
              rating: rating,
              iconSize: 30.0,
              alignment: MainAxisAlignment.start,
            ),
            Text("$rating",
                style: Get.context!.bodyLarge
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w500))
          ],
        ),
      ],
    );
  }

  Widget _buildRatingRow(int star, double? percentage) {
    return Row(
      children: [
        Text(
          '$star',
          style: Get.context!.bodyLarge.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Icon(Icons.star, color: Colors.orange, size: 25),
        Expanded(
          child: LinearProgressIndicator(
            minHeight: 14,
            value: percentage != null ? percentage / 100 : 0,
            backgroundColor: Colors.grey[200],
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        const SizedBox(width: 8),
        Text(percentage != null ? '${percentage.toStringAsFixed(0)}%' : '0%'),
      ],
    );
  }

  Widget _buildInfoText(
      BuildContext context, String title, String subTitle, String? unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.titleMedium),
        Row(
          children: [
            Text(
              subTitle,
              style: context.titleLarge.copyWith(color: AppColors.primaryColor),
            ),
            Text(unit!, style: context.titleMedium),
          ],
        ),
      ],
    );
  }

  Stack _buildImages(ProductData? product) {
    return Stack(
      children: [
        GetBuilder<ProductDetailsController>(
          id: "product_preview_image",
          builder: (_) {
            return ImageService.image(
              product?.product
                      .galleryImages?[controller.selectedImageIndex ?? 0] ??
                  "",
              borderRadius: 8.0,
              imageSize: 250.0,
              imageWidth: double.maxFinite,
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 50.0,
            child: _buildPreviewImages(product),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewImages(ProductData? product) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 10.0),
      itemCount: product?.product.galleryImages?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () => controller.toggleSelectedImage(product, index),
          child: GetBuilder<ProductDetailsController>(
              id: "product_preview_image",
              builder: (_) {
                return Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: AppColors.imageContainer,
                    border: Border.all(
                      color: index == controller.selectedImageIndex
                          ? AppColors.primaryColor
                          : AppColors.white,
                      width: index == controller.selectedImageIndex ? 2 : 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        offset: const Offset(0.0, 4.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: ImageService.image(
                    product?.product.galleryImages?[index] ?? "",
                    borderRadius: 4.0,
                    imageSize: 250.0,
                    imageWidth: double.maxFinite,
                  ),
                );
              }),
        );
      },
      separatorBuilder: (_, __) => const SpaceW10(),
    );
  }
}
