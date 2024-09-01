import 'package:moyen_express/repository/inquiries_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/inquiries/inquiries_controller.dart';

import '../../model/inquiries/inquiries_model.dart';

class InquiriesView extends GetView<InquiriesController> {
  const InquiriesView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final InquiriesController controller = Get.put(InquiriesController());
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: CustomAppBar(title: Strings.MY_INQUIRIES.tr),
      body: CustomFutureBuilder<List<Inquiries>?>(
        future: InquiriesRepository.getInquiries(),
        hasDataBuilder: (context, snapshot) => ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Get.toNamed(Routes.INQUIRY_NOTES, arguments: {
              "id": snapshot.data?[index].id??1,
              "sellerId": snapshot.data?[index].sellerId??34
            }),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              width: double.maxFinite,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                    color: AppColors.greyClr.withOpacity(0.3))
              ], borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      snapshot.data?[index].isSellerReplied == 1
                          ? Strings.REPLIED.tr
                          : Strings.UN_REPLIED,
                      style: context.bodyLarge.copyWith(
                          color: AppColors.active,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.PRODUCT_NAME.tr,
                        style: context.bodyMedium.copyWith(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        snapshot.data?[index].productName ?? "",
                        style: context.bodyMedium.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.DATE_SMALL.tr,
                        style: context.bodyMedium.copyWith(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        dateFormat.format(snapshot.data![index].createdAt!),
                        style: context.bodyMedium.copyWith(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.QUANTITY.tr,
                        style: context.bodyMedium.copyWith(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        snapshot.data?[index].productQty.toString() ?? "",
                        style: context.bodyMedium.copyWith(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.NOTE.tr,
                        style: context.bodyMedium.copyWith(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        snapshot.data?[index].userNote ?? "",
                        style: context.bodyMedium.copyWith(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.DELIVERY_ADDRESS.tr,
                        style: context.bodyMedium.copyWith(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 220,
                        child: Text(
                          "${snapshot.data?[index].deliveryCountry}, ${snapshot.data?[index].deliveryState}, ${snapshot.data?[index].deliveryCity}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyMedium.copyWith(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  const SpaceH2(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.ACTION.tr,
                        style: context.bodyMedium.copyWith(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      CustomButton.solid(
                        showIconOnRight: true,
                        text: Strings.SEE_DETAIL.tr,
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.white,
                        radius: 5.0,
                        onTap: () =>
                            Get.toNamed(Routes.INQUIRY_DETAIL, arguments: {
                          "isReplied": snapshot.data?[index].isSellerReplied,
                          "id": snapshot.data?[index].id,
                        }),
                      ).constrainedBox(maxWidth: 160.0, maxHeight: 25.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
