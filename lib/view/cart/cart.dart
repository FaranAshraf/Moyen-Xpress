import 'package:moyen_express/model/view_cart/view_cart_model.dart';
import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/utils/custom_future_cart_builder_empty.dart';
import '../../resources/exports/index.dart';
import '../../view_model/helpers/global_helper/currency_conversion.dart';

class Cart extends GetView<CartController> {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: Strings.MY_CART.tr,
      ),
      body: GetBuilder<CartController>(builder: (controller) {
        return CustomFutureCartBuilderEmpty(
          future: CartRepository.getCartProducts(),
          hasDataBuilder: (_, snapshot) {
            if (snapshot.hasData) {
              List<CartItem> cartItems = snapshot.data as List<CartItem>;
              return _buildItems(context, cartItems, conversionController);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }),
    );
  }

  Widget _buildItems(BuildContext context, List<CartItem> items,
      CurrencyConversionController conversionController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              return _buildProducts(
                  context, items[index], index, conversionController);
            },
          ),
        ),
        const SizedBox(height: 10),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(Strings.SUB_TOTAL,
        //           style: context.bodyMedium
        //               .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
        //       Text(
        //         calculateSubtotal(items).toPrice(withSymbol: true),
        //         style: context.bodyMedium
        //             .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        //       ),
        //     ],
        //   ),
        // ),
        CustomButton.solid(
          margin: const EdgeInsets.only(left: 16.0, right: 10.0, bottom: 10.0),
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.white,
          text: Strings.CHECK_OUT.tr,
          onTapAsync: () async => Future.delayed(
              const Duration(seconds: 1), () => Get.toNamed(Routes.LOCATIONS)),
          radius: Sizes.RADIUS_6,
          constraints: const BoxConstraints(minHeight: 55),
        ),
      ],
    );
  }



  Widget _buildProducts(BuildContext context, CartItem product, int index,
      CurrencyConversionController conversionController) {

double getTaxedPrice() {
  double unitPriceUSD;

  // Convert the unit price to USD if needed
  if (product?.product?.currency == "USD") {
    unitPriceUSD = product?.product?.unit_price?.toDouble() ?? 0.0;
  } else {
    final unitPriceString = product?.product?.unit_price?.toString() ?? '0.0';
    final convertedValue = conversionController
        .convertCurrencyAmtWithType(amount: unitPriceString, toUsd: false, currencyType: product?.product?.currency)
        .value;

// but i am giving it here
  
    unitPriceUSD = double.tryParse(convertedValue) ?? 0.0;
 
  }

  double taxedPrice = unitPriceUSD;

  // Loop through all taxes and calculate them dynamically
  product?.taxes?.forEach((taxInfo) {
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
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
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
                product.product == null
                    ? product.service?.thumbnail ?? ""
                    : product.product?.photos ?? "",
                borderRadius: 8.0,
              ),
            ),
            const SpaceW16(),
            GetBuilder<CartController>(
                id: "item_price",
                builder: (_) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              product.product == null
                                  ? product.service?.name ?? ""
                                  : product.product?.name ?? "",
                              style: context.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ).expanded(),
                          const SpaceW10(),
                          InkWell(
                            onTap: () async {
                              await controller.removeCartItem(product.id);

                              controller.update();
                            },
                            child: const Icon(Icons.delete_outline,
                                color: AppColors.error),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          QtyContainer(
                            product: product,
                            id: product.id,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${(getDiscount() * (product.quantity ?? 0)).toStringAsFixed(2)} ${conversionController.currentCurrency.value}",
  style: context.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ).expanded(),
                        ],
                      ),
                    ],
                  ).expanded();
                }),
          ],
        ).constrainedBox(maxHeight: 100));
  }

  // double calculateSubtotal(List<CartItem> cartItems) {
  //   double subtotal = 0.0;
  //   for (var item in cartItems) {
  //     subtotal += ((item.product!.unit_price ?? 0.0) + ((item.tax ?? 0))) *
  //         (item.quantity ?? 0);
  //   }
  //   return subtotal;
  //}
}
