import 'package:moyen_express/model/recently_views/recently_views_model.dart';
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/recently_views/recently_views_controller.dart';

import '../../repository/recently_views_repository.dart';

class RecentlyViews extends GetView<RecentlyViewsController> {
  const RecentlyViews({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final RecentlyViewsController controller =
        Get.put(RecentlyViewsController());
    return Scaffold(
        appBar: CustomAppBar(title: Strings.RECENTLY_VIEWS.tr),
        body: CustomFutureBuilder<RecentViewData?>(
          future: RecentlyViewRepository.getDailyDeals(),
          hasDataBuilder: (context, snapshot) => ListView.builder(
              itemCount: snapshot.data?.recentView?.length,
              itemBuilder: (context, index) {
                controller.proCart.value=snapshot.data!.cartCount.toString();
                controller.wishCart.value=snapshot.data!.wishListCount.toString();
                controller.youOrder.value=snapshot.data!.totalProducts.toString();
                return GestureDetector(
                  onTap: () {
                    log.e(
                      snapshot.data?.recentView?[index].id,
                    );

                    Get.toNamed(
                      Routes.PRODUCT_DETAILS,
                      arguments: {
                        "proId": snapshot.data?.recentView?[index].id,
                        "isAuctionProduct": false
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                            color: AppColors.greyClr.withOpacity(0.3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                              snapshot.data?.recentView?[index].date ?? "",
                              style: context.bodyMedium.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor)),
                        ),
                        Row(
                          children: [
                            ImageService.image(
                                snapshot.data?.recentView?[index]
                                        .productImage ??
                                    "",
                                borderRadius: 8.0,
                                imageSize: 100,
                                imageWidth: 100),
                            const SpaceW8(),
                            SizedBox(
                              width: 200,
                              child: Text(
                                  snapshot.data?.recentView?[index]
                                          .productName ??
                                      "",
                                  maxLines: 2,
                                  style: context.bodyMedium.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
