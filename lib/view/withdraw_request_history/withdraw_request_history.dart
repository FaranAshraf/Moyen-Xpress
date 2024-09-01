import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/withdraw_request_history/withdraw_request_history.dart';

class WithDrawRequestHistory extends GetView<WithDrawRequestController> {
  const WithDrawRequestHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.WITHDRAW_REQUEST_HISTORY.tr),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: controller.amountController,
                      isRequired: true,
                      height: Sizes.HEIGHT_16,
                      borderRadius: 7.0,
                      labelText: Strings.AMOUNT.tr,
                      labelColor: AppColors.black,
                      prefixIconColor: AppColors.black,
                      textColor: AppColors.black,
                      cursorColor: AppColors.black,
                      errorColor: AppColors.error,
                      enableBorderColor: AppColors.black,
                      focusBorderColor: AppColors.primaryColor,
                      textInputAction: TextInputAction.next,
                    ),
                    const SpaceH8(),
                    Obx(() => Container(
                          width: double.maxFinite,
                          height: 55,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              padding: const EdgeInsets.all(4),
                              value: controller.dropDownValue.value,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: controller.items.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: SizedBox(
                                    width: 140.0,
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.bodyLarge.copyWith(
                                          fontSize: 17,
                                          color:
                                              AppColors.black.withOpacity(0.7)),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) async {
                                controller.dropDownValue.value = newValue!;
                              },
                            ),
                          ),
                        )),
                    Obx(
                      () => controller.dropDownValue.value == "Stripe"
                          ? Column(
                              children: [
                                const SpaceH8(),
                                CustomTextFormField(
                                  controller: controller.stripeId,
                                  isRequired: true,
                                  height: Sizes.HEIGHT_16,
                                  borderRadius: 7.0,
                                  labelText: Strings.STRIPE_ID.tr,
                                  labelColor: AppColors.black,
                                  prefixIconColor: AppColors.black,
                                  textColor: AppColors.black,
                                  cursorColor: AppColors.black,
                                  errorColor: AppColors.error,
                                  enableBorderColor: AppColors.black,
                                  focusBorderColor: AppColors.primaryColor,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SpaceH8(),
                                CustomTextFormField(
                                  controller: controller.stripeMessage,
                                  maxLines: 3,
                                  isRequired: false,
                                  height: Sizes.HEIGHT_16,
                                  borderRadius: 7.0,
                                  labelText: Strings.MESSAGE.tr,
                                  labelColor: AppColors.black,
                                  prefixIconColor: AppColors.black,
                                  textColor: AppColors.black,
                                  cursorColor: AppColors.black,
                                  errorColor: AppColors.error,
                                  enableBorderColor: AppColors.black,
                                  focusBorderColor: AppColors.primaryColor,
                                  textInputAction: TextInputAction.next,
                                )
                              ],
                            )
                          : controller.dropDownValue.value == "Paypal"
                              ? Column(
                                  children: [
                                    const SpaceH8(),
                                    CustomTextFormField(
                                      controller: controller.payPalId,
                                      isRequired: true,
                                      height: Sizes.HEIGHT_16,
                                      borderRadius: 7.0,
                                      labelText: Strings.PAYPAL_ID.tr,
                                      labelColor: AppColors.black,
                                      prefixIconColor: AppColors.black,
                                      textColor: AppColors.black,
                                      cursorColor: AppColors.black,
                                      errorColor: AppColors.error,
                                      enableBorderColor: AppColors.black,
                                      focusBorderColor: AppColors.primaryColor,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    const SpaceH8(),
                                    CustomTextFormField(
                                      controller: controller.payPalMessage,
                                      maxLines: 3,
                                      isRequired: false,
                                      height: Sizes.HEIGHT_16,
                                      borderRadius: 7.0,
                                      labelText: Strings.MESSAGE.tr,
                                      labelColor: AppColors.black,
                                      prefixIconColor: AppColors.black,
                                      textColor: AppColors.black,
                                      cursorColor: AppColors.black,
                                      errorColor: AppColors.error,
                                      enableBorderColor: AppColors.black,
                                      focusBorderColor: AppColors.primaryColor,
                                      textInputAction: TextInputAction.next,
                                    )
                                  ],
                                )
                              : controller.dropDownValue.value ==
                                      "Bank Transfer"
                                  ? Column(
                                      children: [
                                        const SpaceH8(),
                                        CustomTextFormField(
                                          controller: controller.bankName,
                                          isRequired: true,
                                          height: Sizes.HEIGHT_16,
                                          borderRadius: 7.0,
                                          labelText: Strings.BANK_NAME.tr,
                                          labelColor: AppColors.black,
                                          prefixIconColor: AppColors.black,
                                          textColor: AppColors.black,
                                          cursorColor: AppColors.black,
                                          errorColor: AppColors.error,
                                          enableBorderColor: AppColors.black,
                                          focusBorderColor:
                                              AppColors.primaryColor,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SpaceH8(),
                                        CustomTextFormField(
                                          controller: controller.bankAccName,
                                          isRequired: true,
                                          height: Sizes.HEIGHT_16,
                                          borderRadius: 7.0,
                                          labelText: Strings.BANK_ACC_NAME.tr,
                                          labelColor: AppColors.black,
                                          prefixIconColor: AppColors.black,
                                          textColor: AppColors.black,
                                          cursorColor: AppColors.black,
                                          errorColor: AppColors.error,
                                          enableBorderColor: AppColors.black,
                                          focusBorderColor:
                                              AppColors.primaryColor,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SpaceH8(),
                                        CustomTextFormField(
                                          controller: controller.bankAccNo,
                                          isRequired: true,
                                          height: Sizes.HEIGHT_16,
                                          borderRadius: 7.0,
                                          labelText: Strings.BANK_ACC_NO.tr,
                                          labelColor: AppColors.black,
                                          prefixIconColor: AppColors.black,
                                          textColor: AppColors.black,
                                          cursorColor: AppColors.black,
                                          errorColor: AppColors.error,
                                          enableBorderColor: AppColors.black,
                                          focusBorderColor:
                                              AppColors.primaryColor,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SpaceH8(),
                                        CustomTextFormField(
                                          controller: controller.bankRoutingNo,
                                          isRequired: false,
                                          height: Sizes.HEIGHT_16,
                                          borderRadius: 7.0,
                                          labelText: Strings.BANK_ROUTING_NO.tr,
                                          labelColor: AppColors.black,
                                          prefixIconColor: AppColors.black,
                                          textColor: AppColors.black,
                                          cursorColor: AppColors.black,
                                          errorColor: AppColors.error,
                                          enableBorderColor: AppColors.black,
                                          focusBorderColor:
                                              AppColors.primaryColor,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SpaceH8(),
                                        CustomTextFormField(
                                          controller: controller.bankMessage,
                                          maxLines: 3,
                                          isRequired: false,
                                          height: Sizes.HEIGHT_16,
                                          borderRadius: 7.0,
                                          labelText: Strings.MESSAGE.tr,
                                          labelColor: AppColors.black,
                                          prefixIconColor: AppColors.black,
                                          textColor: AppColors.black,
                                          cursorColor: AppColors.black,
                                          errorColor: AppColors.error,
                                          enableBorderColor: AppColors.black,
                                          focusBorderColor:
                                              AppColors.primaryColor,
                                          textInputAction: TextInputAction.next,
                                        )
                                      ],
                                    )
                                  : Container(),
                    )
                  ],
                ),
              ),
            ),
            CustomButton.solid(
              margin: const EdgeInsets.symmetric(
                vertical: 25.0,
              ),
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.white,
              text: Strings.SEND.tr,
              radius: Sizes.RADIUS_6,
              onTapAsync: () => controller.postWithDrawRequest(),
              constraints: const BoxConstraints(minHeight: 55),
            ),
          ],
        ),
      ),
    );
  }
}
