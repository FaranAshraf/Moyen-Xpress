import 'package:moyen_express/repository/wallet_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/wallet/wallet_controller.dart';

import '../../model/wallet/wallet_model.dart';
import '../../view_model/helpers/global_helper/currency_conversion.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final WalletController controller = Get.put(WalletController());
    // ignore: unused_local_variable
    final CurrencyConversionController conversionController =
        Get.put(CurrencyConversionController());
    return Scaffold(
        appBar: CustomAppBar(title: Strings.WALLET.tr),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : CustomFutureBuilder<WalletModel?>(
                  future: WalletRepository.getWalletPrice(),
                  hasDataBuilder: (context, snapshot) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: 5.0),
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
                                    "${ snapshot.data?.walletBalance.toString()} ",
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
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom +
                                          10.0,
                                    ),
                                    child: SizedBox(
                                      height:
                                          190.0, // Adjust the height of your bottom sheet as needed
                                      child: Center(
                                        child: SingleChildScrollView(
                                          child: Form(
                                            key: controller.priceKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  Strings.SELECT_AMOUNT.tr,
                                                  style: context.bodyMedium
                                                      .copyWith(
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                CustomTextFormField(
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                    signed: true,
                                                    decimal: false,
                                                  ),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    IntegerInputFormatter(),
                                                  ],
                                                  isRequired: true,
                                                  controller: controller
                                                      .priceController,
                                                  height: Sizes.HEIGHT_16,
                                                  labelText:
                                                      Strings.ENTER_AMOUNT.tr,
                                                  labelColor: AppColors.black,
                                                  prefixIconColor:
                                                      AppColors.black,
                                                  textColor: AppColors.black,
                                                  cursorColor: AppColors.black,
                                                  errorColor: AppColors.error,
                                                  enableBorderColor:
                                                      AppColors.black,
                                                  focusBorderColor:
                                                      AppColors.primaryColor,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  borderRadius: 7.0,
                                                ),
                                                const SizedBox(height: 10),
                                                CustomButton.solid(
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  textColor: AppColors.white,
                                                  text: Strings.NEXT.tr,
                                                  onTapAsync: () =>
                                                      buttonFunction(context),
                                                  radius: Sizes.RADIUS_6,
                                                ),
                                                const SpaceH20(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
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
                                      color: AppColors.greyClr,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.white,
                                      size: 45,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    Strings.WALLET_RECHARGE.tr,
                                    style: context.bodyMedium.copyWith(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
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
                                Text(Strings.WALLET_RECHARGE_HISTORY.tr,
                                    style: context.bodyMedium.copyWith(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor)),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
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
                                      snapshot.data?.walletHistory?.length ?? 0,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        _buildRow(
                                            context,
                                            Strings.DATE.tr,
                                            snapshot.data?.walletHistory?[index]
                                                .date
                                                .toString()),
                                        _buildRow(context, Strings.AMOUNT.tr,
                                            "${ snapshot.data?.walletHistory?[index].amount.toString()} USD"),
                                        _buildRow(
                                            context,
                                            Strings.TRANSACTION_TYPE.tr,
                                            snapshot.data?.walletHistory?[index]
                                                .transactionType
                                                .toString()),
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
                  }),
        ));
  }

  Future buttonFunction(BuildContext context) async {
    if (controller.priceKey.currentState?.validate() ?? false) {
      Get.close(-1);
      await controller.makePayment(
        context,
        double.tryParse(controller.priceController.text) ?? 0.0,
      );
    }
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
