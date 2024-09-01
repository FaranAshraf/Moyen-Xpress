import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/utils/bottom_sheet.dart';

import '../resources/exports/index.dart';

class CustomFutureProduct<T> extends StatelessWidget {
  final Future<T> future;
  final AsyncWidgetBuilder<T> hasDataBuilder;
  final Function(T?)? data;
  final double loaderSize;
  final Widget? customLoader;
  final String? errorTitle;
  final String? errorSubtitle;
  final double? noContentPadding;
  final Widget? reloadWidget;
  final bool showNoContentBackground;

  const CustomFutureProduct({
    Key? key,
    required this.future,
    required this.hasDataBuilder,
    this.data,
    this.loaderSize = 30,
    this.customLoader,
    this.errorTitle,
    this.errorSubtitle = 'Failed to Retrieve your data.',
    this.noContentPadding,
    this.reloadWidget,
    this.showNoContentBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SubCategoryController subCategoryController =
        Get.put(SubCategoryController());
    final LocationsController locationsController =
        Get.put(LocationsController());
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return customLoader ??
              const Center(
                child: SizedBox(
                    width: Sizes.WIDTH_24,
                    height: Sizes.HEIGHT_24,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.0, color: AppColors.primaryColor)),
              );
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || snapshot.data == null) {
            return reloadWidget ??
                NoContent(
                   img: Assets.NO_HISTORY,
                  title: errorTitle ?? "Content Not Found !!",
                  subtitle: errorSubtitle!,
                  padding: noContentPadding ?? 32,
                  showBackground: showNoContentBackground,
                );
          } else if (snapshot.hasData) {
            if (snapshot.data == [] || GetUtils.isBlank(snapshot.data)!) {
              subCategoryController.appBarValue.value = true;
              return reloadWidget ??
                  PaginatedListView(
                      showPaddingHorizontally: false,
                      apiUrl:
                          "/api/v2/products/category/${subCategoryController.itemId.value}",
                      onPrimaryButtonTap: (productId) async => Get.bottomSheet(
                            CustomBottomSheetWidget(
                                id: productId,
                                onTap: () {
                                  CartRepository.cartAPi(
                                    productType: "product",
                                    productId: productId.toInt(),
                                    quantity: 1,
                                    color: locationsController.colorValue.value
                                        .toString(),
                                    size: locationsController.sizeValue.value
                                        .toString(),
                                  );

                                  Get.back();
                                }),
                          ),
                      onCardTap: (id) {
                        log.e(id);
                        Get.toNamed(
                          Routes.PRODUCT_DETAILS,
                          arguments: {"proId": id, "isAuctionProduct": false},
                        );
                      });
            } else {
              if (data != null) data!.call(snapshot.data);
              return hasDataBuilder(context, snapshot);
            }
          } else {
            return Center(
              child: Text(
                errorSubtitle!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
        } else {
          return Center(
            child: Text(
              'State: ${snapshot.connectionState}',
              style: const TextStyle(color: AppColors.primaryColor),
            ),
          );
        }
      },
    );
  }
}
