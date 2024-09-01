import '../../../resources/exports/index.dart';

class ContactForm extends GetView<ContactController> {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.nameKey,
      child: Column(
        children: [
          fieldHeading(Strings.NAME.tr, context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextFormField(
              controller: controller.nameController,
              borderRadius: 5,
              isRequired: true,
              height: Sizes.HEIGHT_16,
              labelText: Strings.NAME.tr,
              labelColor: AppColors.black,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
            ),
          ),
          fieldHeading(Strings.EMAIL.tr, context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextFormField(
              controller: controller.emailController,
              borderRadius: 5,
              isRequired: true,
              height: Sizes.HEIGHT_16,
              labelText: Strings.EMAIL.tr,
              labelColor: AppColors.black,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
            ),
          ),
          fieldHeading(Strings.PHONE_NUMBER.tr, context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextFormField(
              controller: controller.phoneController,
              borderRadius: 5,
              isRequired: true,
              height: Sizes.HEIGHT_16,
              labelText: Strings.PHONE_NUMBER.tr,
              labelColor: AppColors.black,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
            ),
          ),
          fieldHeading(Strings.MESSAGE.tr, context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextFormField(
              controller: controller.msgController,
              maxLines: 3,
              borderRadius: 5,
              height: Sizes.HEIGHT_16,
              labelText: Strings.MESSAGE.tr,
              labelColor: AppColors.black,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: 'Submit',
              radius: 5,
              textStyle: context.bodyMedium.copyWith(
                  fontSize: 18,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500),
             onTapAsync: ()async => controller.contactData(),
            ),
          ),
          const SpaceH12(),
        ],
      ),
    );
  }

  Column successModal(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Lottie.asset(Assets.SUCCESS,
                  width: 150, height: 150, fit: BoxFit.fill),
              Text("Your Message has been Successfully Send.",
                  textAlign: TextAlign.center,
                  style: context.bodyLarge.copyWith(fontSize: 22, height: 1.3))
            ],
          ),
        ),
        CustomButton.solid(
          margin: const EdgeInsets.all(12),
          backgroundColor: Colors.green,
          textColor: AppColors.white,
          text: "OK",
          onTap: () {
            Navigator.pop(context);
            Get.toNamed(Routes.DASHBOARD);
          },
          radius: Sizes.RADIUS_6,
          constraints: const BoxConstraints(minHeight: 55),
        ),
      ],
    );
  }
}

Column successDialog(BuildContext context, dynamic onTap) {
  return Column(
    children: [
      Expanded(
        child: Column(
          children: [
            Lottie.asset(Assets.SUCCESS,
                width: 150, height: 150, fit: BoxFit.fill),
            Text("Your Message Send Successfully.",
                textAlign: TextAlign.center,
                style: context.bodyLarge.copyWith(fontSize: 22, height: 1.3))
          ],
        ),
      ),
      CustomButton.solid(
        margin: const EdgeInsets.all(12),
        backgroundColor: Colors.green,
        textColor: AppColors.white,
        text: "OK",
        onTap: onTap,
        radius: Sizes.RADIUS_6,
        constraints: const BoxConstraints(minHeight: 55),
      ),
    ],
  );
}

Padding fieldHeading(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, top: 10),
    child: Align(
        alignment: Alignment.topLeft,
        child: Text(title,
            style: context.bodyMedium
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500))),
  );
}
