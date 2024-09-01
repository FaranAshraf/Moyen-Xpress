import '../../../resources/exports/index.dart';

class SignUpForm extends GetView<SignUpController> {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: controller.nameCtrl,
            isRequired: true,
            height: Sizes.HEIGHT_20,
            labelText: Strings.NAME.tr,
            labelColor: AppColors.black,
            prefixIcon: EneftyIcons.user_outline,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          ),
          const SpaceH10(),
          CustomTextFormField(
            controller: controller.emailCtrl,
            isRequired: true,
            height: Sizes.HEIGHT_20,
            labelText: Strings.EMAIL.tr,
            labelColor: AppColors.black,
            prefixIcon: EneftyIcons.sms_outline,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            validator: Validators.emailValidation,
          ),
          const SpaceH10(),
          Obx(
            () => CustomTextFormField(
              controller: controller.passwordCtrl,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              obscureText: !controller.isPasswordVisible.value,
              labelText: Strings.PASSWORD.tr,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.lock_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.error,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              suffixIconColor: AppColors.black,
              suffixIcon: controller.isPasswordVisible.value
                  ? EneftyIcons.eye_slash_outline
                  : EneftyIcons.eye_outline,
              onSuffixTap: controller.togglePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.text,
              inputFormatters: InputFormat.denySpace,
              onFieldSubmit: (s) {},
            ),
          ),
          const SpaceH10(),
          Obx(
            () => CustomTextFormField(
              controller: controller.confirmPassCtrl,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              obscureText: !controller.isConfirmPasswordVisible.value,
              labelText: Strings.CONFIRM_PASSWORD.tr,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.lock_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.error,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              suffixIconColor: AppColors.black,
              suffixIcon: controller.isConfirmPasswordVisible.value
                  ? EneftyIcons.eye_slash_outline
                  : EneftyIcons.eye_outline,
              onSuffixTap: controller.toggleConfirmPassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.text,
              inputFormatters: InputFormat.denySpace,
              onFieldSubmit: (s) {},
            ),
          ),
        ],
      ),
    );
  }
}
