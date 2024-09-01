import 'package:moyen_express/resources/exports/index.dart';

class CardSheet extends StatelessWidget {
  final dynamic onTap;
  const CardSheet({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // margin: const EdgeInsets.only(top: 30.0),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: _buildMethod(context),
    );
  }

  Widget _buildMethod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: (MediaQuery.of(context).size.width * 0.77) / 2,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                  color: AppColors.greyClr,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SpaceH8(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Strings.CARD_PAYMENT.tr,
                      style: context.bodyLarge.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColors.tagGrey)),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.greyClr,
                ),
                CustomTextFormField(
                  isRequired: true,
                  height: Sizes.HEIGHT_20,
                  labelText: Strings.CARD_HOLDER_NAME.tr,
                  prefixIcon: EneftyIcons.card_bold,
                  labelColor: AppColors.black.withOpacity(0.4),
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  errorColor: AppColors.error,
                  enableBorderColor: AppColors.black.withOpacity(0.4),
                  focusBorderColor: AppColors.primaryColor,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.emailValidation,
                  borderRadius: 5.0,
                ),
                CustomTextFormField(
                  isRequired: true,
                  height: Sizes.HEIGHT_20,
                  labelText: Strings.CARD_NUMBER.tr,
                  labelColor: AppColors.black.withOpacity(0.4),
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  errorColor: AppColors.error,
                  enableBorderColor: AppColors.black.withOpacity(0.4),
                  focusBorderColor: AppColors.primaryColor,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.emailValidation,
                  borderRadius: 5.0,
                ),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextFormField(
                        isRequired: true,
                        height: Sizes.HEIGHT_20,
                        labelText: Strings.EXP_MONTH.tr,
                        labelColor: AppColors.black.withOpacity(0.4),
                        textColor: AppColors.black,
                        cursorColor: AppColors.black,
                        errorColor: AppColors.error,
                        enableBorderColor: AppColors.black.withOpacity(0.4),
                        focusBorderColor: AppColors.primaryColor,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.emailValidation,
                        borderRadius: 5.0,
                      ),
                    ),
                    const SpaceW20(),
                    Flexible(
                      child: CustomTextFormField(
                        isRequired: true,
                        height: Sizes.HEIGHT_20,
                        labelText: Strings.EXP_YEAR.tr,
                        labelColor: AppColors.black.withOpacity(0.4),
                        textColor: AppColors.black,
                        cursorColor: AppColors.black,
                        errorColor: AppColors.error,
                        enableBorderColor: AppColors.black.withOpacity(0.4),
                        focusBorderColor: AppColors.primaryColor,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.emailValidation,
                        borderRadius: 5.0,
                      ),
                    ),
                  ],
                ),
                CustomTextFormField(
                  isRequired: true,
                  height: Sizes.HEIGHT_20,
                  labelText: Strings.CARD_CVC.tr,
                  labelColor: AppColors.black.withOpacity(0.4),
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  errorColor: AppColors.error,
                  enableBorderColor: AppColors.black.withOpacity(0.4),
                  focusBorderColor: AppColors.primaryColor,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.emailValidation,
                  borderRadius: 5.0,
                ),
                const SpaceH8(),
                Center(child: Image.asset(Assets.PAY_CARDS)),
                const SpaceH8(),
                CustomButton.solid(
                  margin: const EdgeInsets.all(16.0),
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  text: Strings.COMPLETED_ORDER.tr,
                  onTap: onTap,
                  radius: Sizes.RADIUS_6,
                  constraints: const BoxConstraints(minHeight: 55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
