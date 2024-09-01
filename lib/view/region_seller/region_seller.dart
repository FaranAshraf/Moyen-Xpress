import 'package:moyen_express/resources/exports/index.dart';

import '../../repository/region_seller_repository.dart';

class HomeRegionSeller extends StatelessWidget {
  const HomeRegionSeller({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.REGIONS_SELLERS.tr),
      body: CustomFutureBuilder(
        future: RegionSellerRepository.getRegionSeller(),
        hasDataBuilder: (context, snapshot) {
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data
                ?.length, 
            itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 12.0, right: 12.0),
              child: GestureDetector(
                onTap: () => Get.toNamed(Routes.REGION_SELLER_STORE,arguments: {
                  "regionId":snapshot.data?[index]?.id
                }),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 80.0,
                    width: double.maxFinite,
                    decoration:   BoxDecoration(
                      borderRadius:BorderRadius.circular(7.0),
                     boxShadow:  [ BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: const Offset(2, 2),
                      color: AppColors.greyClr.withOpacity(0.5)
                     )],
                      color: AppColors.white),
                    child: Row(
                      children: [
                        const SpaceW10(),
                                    
                        ImageService.image(snapshot.data?[index]?.image ?? ""),
                        const SpaceW16(),
                        Text(
                          snapshot.data?[index]?.name ?? "",
                          style: context.bodyMedium.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
