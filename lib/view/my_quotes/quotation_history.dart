import 'package:moyen_express/resources/exports/index.dart';

import '../../model/my_quotes/my_quotes_model.dart';
import '../../repository/my_quotes_repositories.dart';
import '../../view_model/controllers/my_quote/quotation_history.dart';

class QuotationHistoryView extends GetView<QuotationHistoryController> {
  const QuotationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: CustomAppBar(title: Strings.QUOTATION_HISTORY.tr),
      body: CustomFutureBuilder<List<QuotationHistoryData>?>(
        future: MyQuoteRepository.getQuotationHistory(),
        hasDataBuilder: (context, snapshot) => ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) => Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                const SizedBox(
                  height: 5,
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
                      snapshot.data?[index].date ?? "",
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
                      snapshot.data?[index].quantity.toString() ?? "",
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
                      Strings.QUANTITY_TYPE.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].quantityType.toString() ?? "",
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
                      Strings.DESCRIPTION.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].description.toString() ?? "",
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
                      Strings.DELIVERY_ADDRESS.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].deliveryAddress.toString() ?? "",
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
                      Strings.STATUS.tr,
                      style: context.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      snapshot.data?[index].status ?? "",
                      style: context.bodyMedium.copyWith(
                          color: snapshot.data?[index].status == 'Sent'
                              ? AppColors.green
                              : AppColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
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
                        text: Strings.REPLIES.tr,
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.white,
                        radius: 5.0,
                        onTap: () {
                          Get.toNamed(Routes.QUOTATION_REPLIES,
                              arguments: {"replyId": snapshot.data?[index].id});
                        }).constrainedBox(maxWidth: 160.0, maxHeight: 25.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  //  Get.toNamed(Routes.INQUIRY_DETAIL, arguments: {
  //                       "isReplied": snapshot.data?[index].isSellerReplied,
  //                       "id": snapshot.data?[index].id,
  //                     }),