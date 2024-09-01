import 'package:moyen_express/repository/wallet_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/cashback_history/cashback_history_controller.dart';
import '../../model/cash_back_history/cashback_history_model.dart';
import '../../view_model/helpers/global_helper/currency_conversion.dart';

class CashBackHistory extends GetView<CashBackController> {
  const CashBackHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final CashBackController controller = Get.put(CashBackController());
     final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return Scaffold(
      appBar: CustomAppBar(title: Strings.CASHBACK_HISTORY.tr),
      body: FutureBuilder<List<CashBackModel>?>(
        future: WalletRepository.getCashBacks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No cashback history found.'));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Container(
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
                      child: Text(snapshot.data?[index].date ?? "",
                          style: context.bodyMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor)),
                    ),
                    _buildRow(context, Strings.ORDER_CODE,
                        snapshot.data?[index].orderCode),
                    _buildRow(context, Strings.PRODUCT_NAME,
                        snapshot.data?[index].productName),
                    _buildRow(context, Strings.CASHBACK_AMOUNT,
                        "${conversionController.convertCurrencyAmt(amount: snapshot.data?[index].cashbackAmount.toString()).value} ${conversionController.currentCurrency.value}"),
                  ],
                ),
              );
            },
          );
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
}
