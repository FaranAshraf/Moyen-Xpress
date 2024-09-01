
import 'package:moyen_express/resources/exports/index.dart';

import '../../view_model/controllers/Cash_payment/Cash_payment_controller.dart';

class CashPayment extends GetView<CashPaymentController> {
  const CashPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.CASH_PAYMENT.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SpaceH8(),
                    Text(
                      Strings.CASH_NOTIFIER.tr,
                      textAlign: TextAlign.center,
                      style: context.bodyLarge.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.error),
                    ),
                    const SpaceH8(),
                    headWire(
                      context,
                      Strings.COUNTRY.tr,
                    ),
                    CustomTextFormField(
                      enabled: true,
                      readOnly: true,
                      controller: controller.country,
                      height: Sizes.HEIGHT_16,
                      labelColor: AppColors.black,
                      prefixIconColor: AppColors.black,
                      textColor: AppColors.black,
                      cursorColor: AppColors.black,
                      errorColor: AppColors.error,
                      enableBorderColor: AppColors.black,
                      focusBorderColor: AppColors.primaryColor,
                      textInputAction: TextInputAction.next,
                    ),
                    headWire(
                      context,
                      Strings.BUSINESS.tr,
                    ),
                    CustomTextFormField(
                      enabled: true,
                      readOnly: true,
                      controller: controller.business,
                      height: Sizes.HEIGHT_16,
                      labelColor: AppColors.black,
                      prefixIconColor: AppColors.black,
                      textColor: AppColors.black,
                      cursorColor: AppColors.black,
                      errorColor: AppColors.error,
                      enableBorderColor: AppColors.black,
                      focusBorderColor: AppColors.primaryColor,
                      textInputAction: TextInputAction.next,
                    ),
                    headWire(
                      context,
                      Strings.ADDRESS.tr,
                    ),
                    CustomTextFormField(
                      enabled: true,
                      readOnly: true,
                      controller: controller.address,
                      height: Sizes.HEIGHT_16,
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
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: AppColors.primaryColor,
                        ),
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            headWire(
                              context,
                              Strings.UPLOAD_IMAGE,
                            ),
                            const SpaceH8(),
                            CustomButton.solid(
                              backgroundColor: AppColors.white,
                              textColor: AppColors.black,
                              text: Strings.UPLOAD.tr,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, top: 7),
                                          child: ListTile(
                                            onTap: () {
                                              controller.pickImageFromCamera();
                                              Get.close(-1);
                                            },
                                            leading: const Icon(
                                                Icons.camera_alt_outlined),
                                            title: const Text(
                                                'Select From Camera'),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 7),
                                          child: ListTile(
                                            onTap: () {
                                              controller.pickImageFromGallery();
                                              Get.close(-1);
                                            },
                                            leading: const Icon(Icons.image),
                                            title: const Text(
                                                'Select From Gallery'),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              radius: Sizes.RADIUS_6,
                              constraints: const BoxConstraints(minHeight: 55),
                            ),
                          ],
                        )),
                    const SpaceH16(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomButton.solid(
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.white,
              text: Strings.COMPLETED_ORDER.tr,
              onTapAsync: () async {
                await controller.postCashPayment();
                Get.toNamed(Routes.CONFIRM_ID);
              },
              radius: Sizes.RADIUS_6,
              constraints: const BoxConstraints(minHeight: 55),
            ),
          ),
        ],
      ),
    );
  }

  Align headWire(BuildContext context, title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: context.bodyLarge
            .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
