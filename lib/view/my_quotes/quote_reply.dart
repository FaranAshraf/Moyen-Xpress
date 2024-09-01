import 'package:moyen_express/repository/my_quotes_repositories.dart';
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/my_quote_replies/quotation_replies_controller.dart';
import '../../model/my_quotes/my_quotes_replies.dart';
import '../../view_model/helpers/global_helper/currency_conversion.dart';

class QuoteReplies extends GetView<QuoteRepliesController> {
  const QuoteReplies({super.key});

  @override
  Widget build(BuildContext context) {
    final QuoteRepliesController controller = Get.put(QuoteRepliesController());
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return Scaffold(
      appBar: CustomAppBar(title: Strings.QUOTE_REPLIES.tr),
      body: CustomFutureBuilder(
        future: MyQuoteRepository.getQuoteReplies(id: controller.replyId),
        hasDataBuilder: (context, snapshot) {
          if (snapshot.data?.quoteReplies == null || snapshot.data!.quoteReplies!.isEmpty) {
            return Container(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                width: double.maxFinite,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                    color: AppColors.greyClr.withOpacity(0.3),
                  ),
                ], borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: const Text(
                "No Replies Yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.quoteReplies!.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                width: double.maxFinite,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                    color: AppColors.greyClr.withOpacity(0.3),
                  ),
                ], borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    _buildRow(context, Strings.ID.tr, snapshot.data!.quoteReplies![index].id.toString()),
                    _buildRow(context, Strings.PRODUCT_NAME.tr, snapshot.data!.quoteReplies![index].sellerName),
                    _buildRow(context, Strings.PER_UNIT_PRICE.tr,
                      "${conversionController.convertCurrencyAmt(amount: snapshot.data!.quoteReplies![index].perUnitPrice.toString()).value} ${conversionController.currentCurrency.value}"),
                    _buildRow(context, Strings.TOTAL_QUOTE_PRICE.tr,
                      "${conversionController.convertCurrencyAmt(amount: snapshot.data!.quoteReplies![index].totalQuotePrice.toString()).value} ${conversionController.currentCurrency.value}"),
                    _buildRow(context, Strings.TAX.tr,
                      "${conversionController.convertCurrencyAmt(amount: snapshot.data!.quoteReplies![index].tax.toString()).value} ${conversionController.currentCurrency.value}"),
                    _buildRow(context, Strings.DELIVERY_CHARGES.tr,
                      "${conversionController.convertCurrencyAmt(amount: snapshot.data!.quoteReplies![index].deliveryCharges.toString()).value} ${conversionController.currentCurrency.value}"),
                    _buildRow(context, Strings.DELIVERY_DAYS.tr, snapshot.data!.quoteReplies![index].deliveryDays),
                    _buildRow(context, Strings.STATUS.tr, snapshot.data!.quoteReplies![index].status),
                    const SpaceH2(),
                    _buildActionRow(context, snapshot.data!.quoteReplies![index], conversionController),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.bodyMedium.copyWith(
            color: AppColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value ?? "",
          style: context.bodyMedium.copyWith(
            color: AppColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow(BuildContext context, QuoteReply quoteReply, CurrencyConversionController conversionController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.ACTION.tr,
          style: context.bodyMedium.copyWith(
            color: AppColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          children: [
            CustomButton.solid(
              showIconOnRight: true,
              text: Strings.ACCEPT.tr,
              backgroundColor: AppColors.success,
              textColor: AppColors.white,
              radius: 5.0,
              onTap: () {
                Get.toNamed(Routes.QUOTATION_REPLIES, arguments: {
                  "replyId": quoteReply.id,
                });
              },
            ).constrainedBox(maxWidth: 120.0, maxHeight: 30.0),
            const SpaceW8(),
            CustomButton.solid(
              showIconOnRight: true,
              text: Strings.REJECT.tr,
              backgroundColor: AppColors.error,
              textColor: AppColors.white,
              radius: 5.0,
              onTap: () {
                Get.toNamed(Routes.QUOTATION_REPLIES, arguments: {
                  "replyId": quoteReply.id,
                });
              },
            ).constrainedBox(maxWidth: 120.0, maxHeight: 30.0),
          ],
        ),
      ],
    );
  }
}
