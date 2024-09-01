import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/repository/wishlist_repository.dart';
import 'package:moyen_express/utils/bottom_sheet.dart';

import '../../resources/exports/index.dart';

class FlashDeals extends GetView<FlashDealsController> {
  final bool isHome;
  const FlashDeals({super.key, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: Strings.FLASH_DEALS.tr),
      body: Column(
        children: [
          const SpaceH12(),
          Center(
            child: GetBuilder<FlashDealsController>(
              id: "flash_deals_timer",
              builder: (_) {
                return CountDownTimer(
                  duration: controller.flashDeal.duration,
                  subTitle: "${controller.flashDeal.discountPer}",
                  showSeeAll: false,
                );
              },
            ),
          ),
          const SpaceH8(),
          _buildGridView(context).expanded(),
        ],
      ),
    );
  }

  Widget _buildGridView(BuildContext context) {
    final LocationsController locationsController =
        Get.put(LocationsController());
    return PagedGridView(
      addAutomaticKeepAlives: true,
      pagingController: controller.pagingController,
      padding: const EdgeInsets.all(Sizes.PADDING_12),
      addRepaintBoundaries: true,
      shrinkWrap: true,
      physics: isHome
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Sizes.WIDTH_18,
        mainAxisSpacing: Sizes.HEIGHT_20,
        childAspectRatio: 3 / 3.5,
      ),
      builderDelegate: PagedChildBuilderDelegate<ListViewModel>(
        firstPageProgressIndicatorBuilder: (context) => const GridViewShimmer(),
        newPageProgressIndicatorBuilder: (context) =>
            CustomLoading.spinKitThreeBouncePrimary,
        firstPageErrorIndicatorBuilder: (context) =>  Align(
          alignment: Alignment.center,
          child: NoContent(
             img: Assets.NO_HISTORY,
            title: Strings.CONTENT_NOT_FOUND.tr,
            subtitle: Strings.SOMETHING_WENT_WRONG.tr,
            padding: 32,
            showBackground: false,
          ),
        ),
        noItemsFoundIndicatorBuilder: (context) =>  Align(
          alignment: Alignment.center,
          child: NoContent(
             img: Assets.NO_HISTORY,
            title: Strings.CONTENT_NOT_FOUND.tr,
            subtitle: Strings.NO_ITEMS_FOUND.tr,
            padding: 32,
            showBackground: false,
          ),
        ),
        newPageErrorIndicatorBuilder: (context) => Align(
          alignment: Alignment.center,
          child: CustomLoading.spinKitThreeBouncePrimary,
        ),
        itemBuilder: (context, item, index) => PaginatedListViewCardContent(
          item: item,
          showRating: true,
          fit: BoxFit.cover,
          onPrimaryButtonTap: (productId) async {
            Get.bottomSheet(
              CustomBottomSheetWidget(
                
                  id: productId,
                  onTap: () {
                    CartRepository.cartAPi(
                                      productType: "product",

                        productId: productId.toInt(),
                        quantity: 1,
                        color: locationsController.colorValue.value.toString(),
                        size: locationsController.sizeValue.value.toString());
                    Get.back();
                  }),
            );
          },
          onCardTap: (id) => Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {"proId": id, "isAuctionProduct": false},
        ),
              onSecondaryButtonTap: (id) {
          WishlistRepository.addToWishList(productId: id.toString());
          log.e(id);
        },
        ),
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
