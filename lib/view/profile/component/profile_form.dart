import 'package:moyen_express/resources/exports/index.dart';

class ProfileForm extends GetView<ProfileController> {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
          child: Column(
        children: [
          const SpaceH14(),
          CustomTextFormField(
            controller: controller.nameController,
            height: Sizes.HEIGHT_20,
            labelText: Strings.NAME.tr,
            labelColor: AppColors.black,
            prefixIcon: Icons.person_2_outlined,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.black,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
          const SpaceH4(),
          CustomTextFormField(
            controller: controller.phoneController,
            height: Sizes.HEIGHT_20,
            labelText: Strings.EMAIL.tr,
            labelColor: AppColors.black,
            prefixIcon: EneftyIcons.sms_outline,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.black,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
          const SpaceH4(),
          Obx(
            () => CustomTextFormField(
              controller: controller.oldPasswordController,
              height: Sizes.HEIGHT_20,
              obscureText: !controller.oldPassword.value,
              labelText: Strings.OLD_PASSWORD.tr,
              labelColor: AppColors.black,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              suffixIcon: controller.oldPassword.value
                  ? EneftyIcons.eye_slash_outline
                  : EneftyIcons.eye_outline,
              onSuffixTap: controller.toggleOldPassword,
            ),
          ),
          const SpaceH4(),
          Obx(
            () => CustomTextFormField(
              controller: controller.newPasswordController,
              height: Sizes.HEIGHT_20,
              labelText: Strings.NEW_PASSWORD.tr,
              labelColor: AppColors.black,
              obscureText: !controller.newPassword.value,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              suffixIcon: controller.newPassword.value
                  ? EneftyIcons.eye_slash_outline
                  : EneftyIcons.eye_outline,
              onSuffixTap: controller.togglePassword,
            ),
          ),
          const SpaceH4(),
          Obx(
            () => CustomTextFormField(
              controller: controller.confirmPasswordController,
              height: Sizes.HEIGHT_20,
              labelText: Strings.CONFIRM_PASSWORD.tr,
              labelColor: AppColors.black,
              obscureText: !controller.confirmPassword.value,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              suffixIcon: controller.confirmPassword.value
                  ? EneftyIcons.eye_slash_outline
                  : EneftyIcons.eye_outline,
              onSuffixTap: controller.toggleConfirmPassword,
            ),
          ),
          const SpaceH8(),
          CustomButton(
            onTap: () => Get.toNamed(Routes.ADD_NEW_SCREEN),
            icon: const Icon(
              Icons.add,
              color: AppColors.white,
              size: 30,
            ),
            iconSpacing: Sizes.ELEVATION_4,
            text: Strings.ADD_NEW_ADDRESS.tr,
            textColor: AppColors.white,
            radius: 5,
          ),
          const SpaceH10(),
          Form(
            key: controller.emailKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: controller.changeEmailController,
                  height: Sizes.HEIGHT_20,
                  labelText: Strings.CHANGE_YOUR_EMAIL.tr,
                  labelColor: AppColors.black,
                  prefixIcon: EneftyIcons.sms_outline,
                  prefixIconColor: AppColors.black,
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  errorColor: AppColors.error,
                  enableBorderColor: AppColors.black,
                  focusBorderColor: AppColors.primaryColor,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
                const SpaceH8(),
                CustomButton(
                  text: Strings.VERIFY_EMAIL.tr,
                  textColor: AppColors.white,
                  radius: 5,
                  onTapAsync: () => controller.updateEmail(),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
