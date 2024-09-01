import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/repository/wishlist_repository.dart';
import 'package:moyen_express/utils/bottom_sheet.dart';

import '../../resources/exports/index.dart';

class DailyDeals extends GetView<HomeController> {
  const DailyDeals({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationsController locationsController =
        Get.put(LocationsController());
    return Scaffold(
      appBar:  CustomAppBar(title: Strings.DAILY_DEALS.tr),
      body: PaginatedListView(
        apiUrl: Urls.DAILY_DEALS,
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
              },
            ),
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
