import 'package:moyen_express/view/home/components/home_all_products.dart';
import 'package:moyen_express/view/home/components/home_auction.dart';
import 'package:moyen_express/view/home/components/home_quote.dart';
import 'package:moyen_express/view/home/components/home_technician.dart';
import 'package:moyen_express/view_model/helpers/access_token.dart';

import '../../repository/region_seller_repository.dart';
import '../../resources/exports/index.dart';
import '../../view_model/controllers/track_ship/track_shipment_controller.dart';
import 'components/home_wholesales_product.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final TrackShipmentController trackShipmentController =
        Get.put(TrackShipmentController());

    return Container(
      width: Get.width,
      height: Get.height,
      color: AppColors.scaffoldBackground,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NewsBanner(),
            const SpaceH16(),
            Obx(
              () => GestureDetector(
                onTap: ()async {
                 AuthManager.instance.session;
                  AccessFirebaseToken accessFirebaseToken=AccessFirebaseToken();
                  String token=await accessFirebaseToken.getAccessToken();
                  log.e(token);
                },
                child: CustomCarouselSlider(
                  banners: controller.banners.categories1,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ),
            const SpaceH16(),
            _buildTitleAndSeeAll(
              context,
              title: Strings.CATEGORIES.tr,
              // onTap: ()=>DashboardController.instance.off(Routes.CONFIRM_VIEW)
              onTap: () => DashboardController.instance.off(Routes.CATEGORIES),
            ),
            const SpaceH16(),
            const HomeCategories().constrainedBox(maxHeight: 150.0),
            const SpaceH20(),
            shipCard(context),
            const SpaceH10(),
            const HomeFlashDeals(),
            // const SpaceH40(),
            // _buildTitleAndSeeAll(
            //   context,
            //   title: Strings.ALL_PRODUCTS.tr,
            //   onTap: () => Get.toNamed(Routes.ALL_PRODUCTS),
            // ),
            // const HomeAllProducts(),
            const SpaceH20(),
            _buildTitleAndSeeAll(
              context,
              title: Strings.DAILY_DEALS.tr,
              onTap: () => Get.toNamed(Routes.DAILY_DEALS),
            ),
            const HomeDailyDeals(),
            const SpaceH40(),
            Obx(
              () => CustomCarouselSlider(
                banners: controller.banners.categories2,
                isLoading: controller.isLoading.value,
              ),
            ),
            const SpaceH40(),
            _buildTitleAndSeeAll(
              context,
              title: Strings.NEW_ARRIVALS.tr,
              onTap: () => Get.toNamed(Routes.NEW_ARRIVALS),
            ),
            const HomeAllProducts(),
            const SpaceH20(),
            _buildTitleAndSeeAll(
              context,
              title: Strings.WHOLESALERS.tr,
              onTap: () => Get.toNamed(Routes.WHOLESALES_PRODUCTS),
            ),
            const HomeWholeSalesProducts(),
            _buildTitleAndSeeAll(
              context,
              title: Strings.TECHNICIANS.tr,
              onTap: () => Get.toNamed(Routes.TECHNICIAN_VIEW),
            ),
            const HomeTechnician(),
            _buildTitleAndSeeAll(
              context,
              title: Strings.AUCTIONS.tr,
              onTap: () => Get.toNamed(Routes.AUCTION),
            ),
            const HomeAuction(),
            _buildTitleAndSeeAll(
              context,
              title: Strings.PROMOTIONS.tr,
              onTap: () => Get.toNamed(Routes.PROMOTIONS),
            ),
            const HomePromotions(),
            const SpaceH40(),
            Obx(
              () => CustomCarouselSlider(
                banners: controller.banners.categories3,
                isLoading: controller.isLoading.value,
              ),
            ),
            const SpaceH40(),
            _buildTitleAndSeeAll(
              context,
              title: Strings.TOP_SELLERS.tr,
              onTap: () => Get.toNamed(Routes.TOP_SELLERS),
            ),
            const HomeTopSellers(),
            const SpaceH40(),
            _buildTitleAndSeeAll(
              context,
              title: Strings.TOP_BRANDS.tr,
              onTap: () => Get.toNamed(Routes.TOP_BRANDS),
            ),
            const HomeTopBrands(),
            const SpaceH10(),
            const HomeShippingCard(),
            // const SpaceH10(),
            const HomeQuote(),
            const SpaceH10(),

            _buildTitleAndSeeAll(
              context,
              title: Strings.REGIONS_SELLERS.tr,
              onTap: () => Get.toNamed(Routes.REGION_SELLER),
            ),
            CustomFutureBuilder(
              future: RegionSellerRepository.getRegionSeller(),
              hasDataBuilder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 12.0, right: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          log.e(snapshot.data?[index]?.id);
                          Get.toNamed(Routes.REGION_SELLER_STORE, arguments: {
                            "regionId": snapshot.data?[index]?.id
                          });
                        },
                        child: Container(
                          height: 80.0,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    offset: const Offset(2, 2),
                                    color: AppColors.greyClr.withOpacity(0.5))
                              ],
                              color: AppColors.white),
                          child: Row(
                            children: [
                              const SpaceW10(),
                              ImageService.image(
                                  snapshot.data?[index]?.image ?? ""),
                              const SpaceW16(),
                              Text(
                                snapshot.data?[index]?.name ?? "",
                                style:
                                    context.bodyMedium.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text('No data available');
                }
              },
            ),

            const SpaceH30(),
          ],
        ),
      ),
    );
  }

  shipCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 2,
          height: Get.height / 12,
          decoration:
              BoxDecoration(color: AppColors.scaffoldBackground, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3)),
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpaceW8(),
              Image.asset(
                Assets.FREE_DELIVERY,
              ),
              const SpaceW16(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.FREE_SHIPPING.tr,
                    style: context.titleMedium.copyWith(
                      height: 0.9,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      decorationColor: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      Strings.DESC.tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleMedium.copyWith(
                        height: 1.1,
                        color: AppColors.greyClr,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildTitleAndSeeAll(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            title,
            style:
                context.headlineSmall.copyWith(color: AppColors.primaryColor),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                Strings.SEE_ALL.tr,
                style: context.titleMedium.copyWith(
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
