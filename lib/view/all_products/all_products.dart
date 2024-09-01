import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/repository/wishlist_repository.dart';
import 'package:moyen_express/utils/bottom_sheet.dart';

import '../../model/filter_model/filter_model.dart';
import '../../resources/exports/index.dart';
import '../../view_model/controllers/all_products/all_products_controller.dart';
import '../../view_model/controllers/filter_product/filter_product_controller.dart';

class AllProducts extends GetView<AllProductsController> {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationsController locationsController =
        Get.put(LocationsController());
    final GridController colorController = Get.put(GridController());
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.ALL_PRODUCTS.tr),
        centerTitle: true,
        leadingWidth: 50.0,
        leading: GestureDetector(
          onTap: () => Get.offAllNamed(Routes.DASHBOARD),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(
                      Strings.ALL_BRANDS.tr,
                      maxLines: 2,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SpaceW4(),
                    Obx(
                      () => Container(
                        width: 130.0,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CarBrand?>(
                            padding: const EdgeInsets.all(4),
                            value: controller.selectedBrand.value,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: [
                              DropdownMenuItem<CarBrand?>(
                                value: null,
                                child: SizedBox(
                                  width: 90.0,
                                  child: Text(
                                    controller.valueItem.value,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                              ...controller.brands.map((CarBrand? brand) {
                                return DropdownMenuItem<CarBrand?>(
                                  value: brand,
                                  child: SizedBox(
                                    width: 80.0,
                                    child: Text(
                                      brand?.name ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                            onChanged: (CarBrand? newValue) {
                              controller.onBrandSelected(newValue);
                            },
                          ),
                        ),
                      ),
                    )
                  ]),
                  const SpaceW8(),
                  Text(
                    Strings.SORT_BY.tr,
                    maxLines: 2,
                    style: context.bodyMedium.copyWith(
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SpaceW4(),
                  Obx(() => Container(
                        width: 110.0,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            padding: const EdgeInsets.all(4),
                            value: controller.dropDownValue.value,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.items.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: SizedBox(
                                  width: 70.0,
                                  child: Text(
                                    item,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.bodyLarge.copyWith(
                                        fontSize: 17,
                                        color:
                                            AppColors.black.withOpacity(0.7)),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.updateSortBy(newValue);
                              }
                            },
                          ),
                        ),
                      )),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.FILTERS_UI),
                    child: const Icon(
                      Icons.filter_alt,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
      
            Obx(() => PaginatedListView(
                  key: UniqueKey(),
                  apiUrl: "/api/appV1/search",
                  parameters: {
                    "limit": 5,
                    "sort_by": (() {
                      switch (controller.dropDownValue.value) {
                        case "cheapest":
                          return "price-asc";
                        case "expensive":
                          return "price-desc";
                        case "oldest":
                          return "oldest";
                        case "newest":
                          return "newest";
                        default:
                          return "";
                      }
                    })(),
                    "brand": controller.selectedBrand.value?.name ?? "",
                    colorController.countryId == 0 ? "" : "country":
                        colorController.countryId,
                    colorController.stateId == 0 ? "" : "state":
                        colorController.stateId,
                    colorController.cityId == 0 ? "" : "city":
                        colorController.cityId,
                    if (colorController.colorCode.value.isNotEmpty)
                      "color": colorController.colorCode.value,
                    if (colorController.minPrice.value.isNotEmpty)
                      "min_price": colorController.minPrice.value,
                    if (colorController.maxPrice.value.isNotEmpty)
                      "max_price": colorController.maxPrice.value,
                    if (colorController.selectedRatingFilter.value != 0)
                      "rating":
                          colorController.selectedRatingFilter.value.toString(),
                  },
                  onCardTap: (id) {
                    log.e(id);
                    Get.toNamed(
                      Routes.PRODUCT_DETAILS,
                      arguments: {"proId": id, "isAuctionProduct": false},
                    );
                  },
                  onPrimaryButtonTap: (productId) async => Get.bottomSheet(
                    CustomBottomSheetWidget(
                      id: productId,
                      onTap: () {
                        CartRepository.cartAPi(
                            productType: "product",
                            productId: productId.toInt(),
                            quantity: 1,
                            color:
                                locationsController.colorValue.value.toString(),
                            size:
                                locationsController.sizeValue.value.toString());
                        Get.back();
                      },
                    ),
                  ),
                  onSecondaryButtonTap: (id) {
                    WishlistRepository.addToWishList(productId: id.toString());
                    log.e(id);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
