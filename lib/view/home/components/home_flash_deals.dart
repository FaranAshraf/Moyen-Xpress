import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/repository/wishlist_repository.dart';
import 'package:moyen_express/utils/bottom_sheet.dart';

import '../../../resources/exports/index.dart';

class HomeFlashDeals extends GetView<HomeController> {
  const HomeFlashDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomFutureBuilder(
        future: HomeRepository.getFlashDeals(),
        customLoader: const Column(
          children: [
            CountDownTimerShimmer(),
            GridViewShimmer(),
          ],
        ),
        hasDataBuilder: (_, snapshot) => _buildItems(
          snapshot.data ?? FlashDealsModel(),
        ),
      ),
    );
  }

  Widget _buildItems(FlashDealsModel data) {
    final LocationsController locationsController =
        Get.put(LocationsController());
    return Column(
      children: [
        Center(
          child: CountDownTimer(
            title: Strings.FLASH_DEALS.tr,
            subTitle: "${data.discountPer}",
            duration: data.duration,
          ),
        ),
        const SpaceH8(),
        GridView.builder(
          padding: EdgeInsets.zero,
          itemCount:
              (data.items ?? []).length > 4 ? 4 : data.items?.length ?? 0,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Sizes.WIDTH_18,
            mainAxisSpacing: Sizes.HEIGHT_20,
            childAspectRatio: 3 / 3.5,
          ),
          itemBuilder: (context, index) => PaginatedListViewCardContent(
            borderRadius: 0.0,
            item: (data.items ?? [])[index],
            showRating: true,
            onPrimaryButtonTap: (productId) async => Get.bottomSheet(
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
            ),
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
      ],
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
