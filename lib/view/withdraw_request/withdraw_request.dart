import 'package:moyen_express/model/withdraw_request/withdraw_request_model.dart';
import 'package:moyen_express/repository/wallet_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/withdraw_request/withdraw_request_controller.dart';

import '../../view_model/helpers/global_helper/currency_conversion.dart';

class WithDrawRequest extends GetView<WithDrawController> {
  const WithDrawRequest({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final WithDrawController controller = Get.put(WithDrawController());
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return Scaffold(
        appBar: CustomAppBar(title: Strings.MY_WITHDRAWS.tr),
        body: CustomFutureBuilder<WalletSuccessContents?>(
            future: WalletRepository.getWithdrawRequest(),
            hasDataBuilder: (context, snapshot) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
                      width: double.maxFinite,
                      height: 170.0,
                      decoration: BoxDecoration(
                        gradient: Gradients.sellerDetails,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.paid,
                            color: AppColors.white,
                            size: 45,
                          ),
                          const SizedBox(height: 10),
                          Text(
                              "${conversionController.convertCurrencyAmt(amount: snapshot.data?.walletBalance).value} ${conversionController.currentCurrency.value}",
                              // ignore: prefer_const_constructors
                              style: context.bodyMedium.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white)),
                          Text(Strings.WALLET_BALANCE.tr,
                              style: context.bodyMedium.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.WITHDRAW_REQUEST_HISTORY);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        width: double.maxFinite,
                        height: 150.0,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35.0),
                                  color: AppColors.greyClr),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.white,
                                size: 45,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(Strings.SEND_WITHDRAW.tr,
                                style: context.bodyMedium.copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor)),
                          ],
                        ),
                      ),
                    ),
                    Container(
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
                          Text(Strings.WITHDRAW_REQUEST_HISTORY.tr,
                              style: context.bodyMedium.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Divider(
                              color: Colors.grey.shade500,
                              indent: 0,
                              endIndent: 0,
                              height: 1,
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                snapshot.data?.withdrawRequests?.length ?? 0,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  _buildRow(
                                      context,
                                      Strings.DATE.tr,
                                      snapshot
                                          .data?.withdrawRequests?[index].date
                                          .toString()),
                                  _buildRow(context, Strings.AMOUNT.tr,
                                      "${conversionController.convertCurrencyAmt(amount: snapshot.data?.withdrawRequests?[index].amount).value} ${conversionController.currentCurrency.value}"),
                                  _buildRow(
                                      context,
                                      Strings.WITHDRAW_TYPE.tr,
                                      snapshot.data?.withdrawRequests?[index]
                                          .withdrawType
                                          .toString()),
                                  _buildRow(
                                      context,
                                      Strings.STATUS.tr,
                                      snapshot
                                          .data?.withdrawRequests?[index].status
                                          .toString()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Strings.MESSAGE.tr,
                                        style: context.bodyMedium.copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          snapshot
                                                  .data
                                                  ?.withdrawRequests?[index]
                                                  .message
                                                  .toString() ??
                                              "",
                                          overflow: TextOverflow.clip,
                                          style: context.bodyMedium.copyWith(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey.shade500,
                              indent: 0,
                              endIndent: 0,
                              height: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
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

class IntegerInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only digits 0-9
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (int.tryParse(newValue.text) == null) {
      return oldValue; // Revert to old value if input is not an integer
    } else {
      return newValue;
    }
  }
}
