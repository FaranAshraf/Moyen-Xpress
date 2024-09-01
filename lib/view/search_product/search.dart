import '../../model/search/search_model.dart';
import '../../resources/exports/index.dart';
import '../../view_model/helpers/global_helper/currency_conversion.dart';

class SearchProduct extends GetView<SearchProductController> {
  const SearchProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchProductController searchProductController =
        Get.put(SearchProductController());
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return Scaffold(
      appBar: CustomAppBar(title: Strings.SEARCH.tr),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
                controller: searchProductController.searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Search...',
                ),
                onSubmitted: (term) {
                  if (term.trim().isNotEmpty) {
                    controller.onSearchTermSubmitted(term.trim());
                  }
                }),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return Expanded(
              child: _buildResults(
                  controller.searchResults.value, conversionController),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResults(SearchProducts? searchResults,
      CurrencyConversionController conversionController) {
    if (searchResults == null) {
      return Column(
        children: [
          const SpaceH40(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                Assets.SEARCH_PRODUCTS,
                scale: 1.8,
              ),
            ),
          ),
        ],
      );
    }

    final products = searchResults.products ?? [];
    final categories = searchResults.categories ?? [];
    final keywords = searchResults.keywords ?? [];
    final shops = searchResults.shops ?? [];

    return ListView(
      children: [
        if (products.isNotEmpty) ...[
          _buildCategoryTitle('Products'),
          ...products.map(
              (product) => _buildProductItem(product, conversionController)),
        ],
        if (categories.isNotEmpty) ...[
          _buildCategoryTitle('Categories'),
          ...categories.map((cat) => _buildCategoryItem(cat)),
        ],
        if (keywords.isNotEmpty) ...[
          _buildCategoryTitle('Keywords'),
          ...keywords.map((keyword) => _buildKeywordItem(keyword)),
        ],
        if (shops.isNotEmpty) ...[
          _buildCategoryTitle('Shops'),
          ...shops.map((shop) => _buildShopItem(shop)),
        ],
      ],
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20.0,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildProductItem(
      SearchPro product, CurrencyConversionController conversionController) {

double getTaxedPrice() {
  double unitPriceUSD;

  // Convert the unit price to USD if needed
  if (product?.currency == "USD") {
    unitPriceUSD = product?.unitPrice?.toDouble() ?? 0.0;
  } else {
    final unitPriceString = product?.unitPrice?.toString() ?? '0.0';
    final convertedValue = conversionController
        .convertCurrencyAmtWithType(amount: unitPriceString, toUsd: false, currencyType: product?.currency)
        .value;

// but i am giving it here
  
    unitPriceUSD = double.tryParse(convertedValue) ?? 0.0;
 
  }

  double taxedPrice = unitPriceUSD;

  // Loop through all taxes and calculate them dynamically
  product?.taxes?.forEach((taxInfo) {
    double taxAmount;
    if (conversionController.currentCurrency.value == "USD" && product?.currency == "USD"){
     taxAmount = taxInfo?.tax?.toDouble() ?? 0;
    }
    else {
      final taxString = taxInfo?.tax?.toString() ?? '0.0';
      final convertedvalue = conversionController.convertCurrencyAmtWithType(amount: taxString, currencyType: product?.currency ?? 'XOF' ).value;
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
        .convertCurrencyAmtWithType(amount: taxedPriceString, toUsd: false, currencyType: product?.currency ?? 'XOF')
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
  final discount = product?.discount?.toInt() ?? 0;

  // Ensure the discount calculation method is correctly defined and uses USD values
  final discountType = product?.discount_type?.toString();
  final discountCurrency = product?.discount_currency?.toString();
  
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
        .convertCurrencyAmtWithType(amount: discountedPriceString, toUsd: false, currencyType: product?.currency ?? 'XOF')
        .value;


    return double.tryParse(convertedValue) ?? 0.0;
  }


return discountedPrice;

  
}

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {"proId": product.id, "isAuctionProduct": false},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
          // border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Row(
          children: [
            Container(
              height: 110.0,
              width: 110.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product.thumbnailImg ?? ""),
                    fit: BoxFit.fill),
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
            ),
            const SpaceW12(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 270.0,
                  child: Text(
                    product.name ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                 "${getDiscount().toString()} ${conversionController.currentCurrency.value}",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(SearchCat cat) {
    return GestureDetector(
      onTap: () {
        log.d(cat.id);
        Get.toNamed(Routes.SUB_CATEGORIES,
            arguments: {"subCategoryId": cat.id});
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Row(
          children: [
            Container(
              height: 110.0,
              width: 110.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(cat.icon ?? ""), fit: BoxFit.fill),
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
            ),
            const SpaceW12(),
            Text(
              cat.name ?? '',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeywordItem(String keyword) {
    return GestureDetector(
      onTap: () {
        controller.keywords = keyword;
        log.e(controller.keywords);
        // Get.toNamed(Routes.NEW_ARRIVALS);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Row(
          children: [
            Text(
              keyword,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopItem(SearchShop shop) {
    return GestureDetector(
      onTap: () {
        log.f(shop.id);
        Get.toNamed(
          Routes.STORE_HOME,
          arguments: {"storeId": shop.id},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
          // border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Row(
          children: [
            Container(
              height: 110.0,
              width: 110.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(shop.logo ?? ""), fit: BoxFit.fill),
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
            ),
            const SpaceW12(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 270.0,
                  child: Text(
                    shop.name ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 270.0,
                  child: Text(
                    shop.address ?? "",
                    maxLines: 3,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
