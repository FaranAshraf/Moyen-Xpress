import 'package:moyen_express/model/store/store_model.dart';
import 'package:moyen_express/repository/cart_repository.dart';

import 'package:moyen_express/repository/store_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/utils/bottom_sheet.dart';
import 'package:moyen_express/utils/paginated_list_vieww.dart';

class StoreHomeView extends GetView<StoreController> {
  const StoreHomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationsController locationsController =
        Get.put(LocationsController());
    List<ListViewModel> convertProductsToViewModels(List<Product> allProduct) {
      return allProduct.map((product) {
        return ListViewModel(
          id: product.id,
          title: product.name,
          image: product.image,
          price: product.unitPrice!.toDouble(),
          discount: product.discount,
          rating: product.rating?.toDouble(),
          // Add other properties as needed
        );
      }).toList();
    }

    List<ListViewModel> convertFeaturesToViewModels(
        List<Product> featureProducts) {
      return featureProducts.map((product) {
        return ListViewModel(
          id: product.id,
          title: product.name,
          image: product.image,
          price: product.unitPrice!.toDouble(),
          discount: product.discount,
          rating: product.rating?.toDouble(),
          // Add other properties as needed
        );
      }).toList();
    }

    List<ListViewModel> convertArrivalsToViewModels(
        List<Product> featureProducts) {
      return featureProducts.map((product) {
        return ListViewModel(
          id: product.id,
          title: product.name,
          image: product.image,
          price: product.unitPrice!.toDouble(),
          discount: product.discount,
          rating: product.rating?.toDouble(),
          // Add other properties as needed
        );
      }).toList();
    }

    List<ListViewModel> convertTopSellingToViewModels(
        List<Product> featureProducts) {
      return featureProducts.map((product) {
        return ListViewModel(
          id: product.id,
          title: product.name,
          image: product.image,
          price: product.unitPrice!.toDouble(),
          discount: product.discount,
          rating: product.rating?.toDouble(),
          // Add other properties as needed
        );
      }).toList();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: Strings.STORE_HOME.tr,
        actions: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
              onTap: () => Get.toNamed(Routes.CART),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: AppColors.primaryColor,
              )),
        ),
      ),
      body: CustomFutureBuilder<StoreDetail?>(
        future: StoreRepository.getStoreDetail(storeId: controller.storeId),
        hasDataBuilder: (context, snapshot) => ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: snapshot.data?.details?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 190.0,
                    margin: const EdgeInsets.all(12.0),
                    child:
                        ImageService.image(snapshot.data?.details![index].image ?? "", scale: 1.1,borderRadius: 5.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        ImageService.image(
                            snapshot.data?.details![index].image ?? "",
                            imageWidth: 90,
                            imageSize: 90,
                            fit: BoxFit.cover),
                        const SpaceW4(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 340,
                              child: Text(
                                  snapshot.data!.details![index].name ?? "-",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.bodyMedium.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                            StarRating(
                              rating: snapshot.data?.details![index].rating!
                                      .toDouble() ??
                                  0,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(
                                width: 340,
                                child: Text(
                                    snapshot.data!.details![index].address ??
                                        "-",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.bodyMedium.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.TOP_SELLING.tr,
                          style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: AppColors.tagGrey),
                        )),
                  ),
                  CustomFutureBuilder<StoreDetail?>(
                    future: StoreRepository.getStoreDetail(
                        storeId: controller.storeId),
                    hasDataBuilder: (context, snapshot) {
                      final storeDetail = snapshot.data;
                      if (storeDetail != null) {
                        final products = storeDetail.allProducts;
                        final viewModels =
                            convertTopSellingToViewModels(products!);
                        return PaginatedListViewww(
                          dummyData: viewModels ?? [],
                          onCardTap: (id) => Get.toNamed(
                            Routes.PRODUCT_DETAILS,
                            arguments: {"proId": id, "isAuctionProduct": false},
                          ),
                          onTap1: (index) {
                            CustomDialog.showDialog(
                                height: 320.0,
                                content: successDialog(context, () {
                                  Get.close(-1);
                                }));
                          },
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
                                        size: locationsController
                                            .sizeValue.value
                                            .toString());
                                     Get.close(-1);
                                  }),
                            );
                          },
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.ALL_PRODUCTS.tr,
                          style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: AppColors.tagGrey),
                        )),
                  ),
                  CustomFutureBuilder<StoreDetail?>(
                    future: StoreRepository.getStoreDetail(
                        storeId: controller.storeId),
                    hasDataBuilder: (context, snapshot) {
                      final storeDetail = snapshot.data;
                      if (storeDetail != null) {
                        final products = storeDetail.allProducts;
                        final viewModels =
                            convertProductsToViewModels(products!);
                        return PaginatedListViewww(
                          dummyData: viewModels ?? [],
                           onCardTap: (id) => Get.toNamed(
                            Routes.PRODUCT_DETAILS,
                            arguments: {"proId": id, "isAuctionProduct": false},
                          ),
                          onTap1: (index) {
                            CustomDialog.showDialog(
                                height: 320.0,
                                content: successDialog(context, () {
                                  Get.close(-1);
                                }));
                          },
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
                                        size: locationsController
                                            .sizeValue.value
                                            .toString());
                                            Get.close(-1);
                                  }),
                            );
                          },
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.NEW_ARRIVALS.tr,
                          style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: AppColors.tagGrey),
                        )),
                  ),
                  CustomFutureBuilder<StoreDetail?>(
                    future: StoreRepository.getStoreDetail(
                        storeId: controller.storeId),
                    hasDataBuilder: (context, snapshot) {
                      final storeDetail = snapshot.data;
                      if (storeDetail != null) {
                        final products = storeDetail.newArrivals;
                        final viewModels =
                            convertArrivalsToViewModels(products!);
                        return PaginatedListViewww(
                          dummyData: viewModels ?? [],
                           onCardTap: (id) => Get.toNamed(
                            Routes.PRODUCT_DETAILS,
                            arguments: {"proId": id, "isAuctionProduct": false},
                          ),
                          onTap1: (index) {
                            CustomDialog.showDialog(
                                height: 320.0,
                                content: successDialog(context, () {
                                  Get.close(-1);
                                }));
                          },
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
                                        size: locationsController
                                            .sizeValue.value
                                            .toString());
                                            Get.close(-1);
                                  }),
                            );
                          },
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  ),
                  (snapshot.data?.featuresProducts ?? []).isEmpty

                      ? const SpaceH4()
                      : Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Strings.FEATURES_PRODUCT.tr,
                                style: context.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    color: AppColors.tagGrey),
                              )),
                        ),
                  (snapshot.data?.featuresProducts ?? []).isEmpty

                      ? const SpaceH4()
                      : CustomFutureBuilder<StoreDetail?>(
                          future: StoreRepository.getStoreDetail(
                              storeId: controller.storeId),
                          hasDataBuilder: (context, snapshot) {
                            final storeDetail = snapshot.data;
                            if (storeDetail != null) {
                              final products = storeDetail.featuresProducts;
                              final viewModels =
                                  convertFeaturesToViewModels(products!);
                              return PaginatedListViewww(
                                dummyData: viewModels ?? [],
                                 onCardTap: (id) => Get.toNamed(
                            Routes.PRODUCT_DETAILS,
                            arguments: {"proId": id, "isAuctionProduct": false},
                          ),
                          onTap1: (index) {
                            CustomDialog.showDialog(
                                height: 320.0,
                                content: successDialog(context, () {
                                  Get.close(-1);
                                }));
                          },
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
                                        size: locationsController
                                            .sizeValue.value
                                            .toString());
                                            Get.close(-1);
                                  }),
                            );
                          },
                              );
                            } else {
                              return const Text('No data available');
                            }
                          },
                        ),
                ],
              );
            }),
      ),
    );
  }
  Column successDialog(BuildContext context, dynamic onTap) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Lottie.asset(Assets.SUCCESS,
                  width: 150, height: 150, fit: BoxFit.fill),
              Text("Product has been added Successfully",
                  textAlign: TextAlign.center,
                  style: context.bodyLarge.copyWith(fontSize: 22, height: 1.3))
            ],
          ),
        ),
        CustomButton.solid(
          margin: const EdgeInsets.all(12),
          backgroundColor: Colors.green,
          textColor: AppColors.white,
          text: "OK",
          onTap: onTap,
          radius: Sizes.RADIUS_6,
          constraints: const BoxConstraints(minHeight: 55),
        ),
      ],
    );
  }
}
