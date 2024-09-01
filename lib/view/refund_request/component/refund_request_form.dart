
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import '../../../resources/exports/index.dart';

class RefundRequestForm extends GetView<RefundRequestController> {
  const RefundRequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.refundRequest,
        child: Column(
          children: [
            fieldHeading(Strings.PRODUCT_NAME.tr, context),
            CustomTextFormField(
              controller: controller.productName,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              labelText: Strings.PRODUCT_NAME.tr,
              labelColor: AppColors.black.withOpacity(0.5),
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.error,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              borderRadius: 5.0,
            ),
            fieldHeading(Strings.ORDER_CODE.tr, context),
            CustomTextFormField(
              controller: controller.orderCode,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              labelText: Strings.ORDER_CODE.tr,
              labelColor: AppColors.black.withOpacity(0.5),
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.error,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              borderRadius: 5.0,
            ),
            fieldHeading(Strings.QUANTITY_TYPE.tr, context),
            const SpaceH4(),
            Obx(() => SizedBox(
                  width: double.maxFinite,
                  height: 65,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        padding: const EdgeInsets.all(8),
                        value: controller.quantityType.value,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.quantityTypeItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item,
                                  style: context.bodyLarge.copyWith(
                                      fontSize: 17,
                                      color: AppColors.black.withOpacity(0.7)),
                                ),
                                Icon(Icons.check,
                                    color: item == controller.quantityType.value
                                        ? AppColors.primaryColor
                                        : Colors.transparent),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.quantityType.value = newValue!;
                        },
                      ),
                    ),
                  ),
                )),
            const SpaceH4(),
            fieldHeading(Strings.REFUND_TYPE.tr, context),
            const SpaceH4(),
            Obx(() => SizedBox(
                  width: double.maxFinite,
                  height: 65,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        padding: const EdgeInsets.all(8),
                        value: controller.quantityType.value,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.quantityTypeItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item,
                                  style: context.bodyLarge.copyWith(
                                      fontSize: 17,
                                      color: AppColors.black.withOpacity(0.7)),
                                ),
                                Icon(Icons.check,
                                    color: item == controller.quantityType.value
                                        ? AppColors.primaryColor
                                        : Colors.transparent),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.quantityType.value = newValue!;
                        },
                      ),
                    ),
                  ),
                )),
            const SpaceH4(),
            fieldHeading(Strings.RETURN_TYPE.tr, context),
            const SpaceH4(),
            Obx(() => SizedBox(
                  width: double.maxFinite,
                  height: 65,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        padding: const EdgeInsets.all(8),
                        value: controller.quantityType.value,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.quantityTypeItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item,
                                  style: context.bodyLarge.copyWith(
                                      fontSize: 17,
                                      color: AppColors.black.withOpacity(0.7)),
                                ),
                                Icon(Icons.check,
                                    color: item == controller.quantityType.value
                                        ? AppColors.primaryColor
                                        : Colors.transparent),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.quantityType.value = newValue!;
                        },
                      ),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 3),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(Strings.RETURN_COST.tr,
                      style: context.bodyMedium
                          .copyWith(color: AppColors.black.withOpacity(0.7)))),
            ),
            const SpaceH4(),
            fieldHeading(Strings.REFUND_REASON.tr, context),
            CustomTextFormField(
              maxLines: 3,
              controller: controller.refundReason,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              labelText: Strings.REFUND_REASON,
              labelColor: AppColors.black.withOpacity(0.5),
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.error,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              borderRadius: 5.0,
            ),
            const SpaceH4(),
            fieldHeading(Strings.DROP_OFF_ADDRESS.tr, context),
            CustomTextFormField(
              controller: controller.wearHouseAddress,
              isRequired: false,
              height: Sizes.HEIGHT_20,
              labelText: "Type Here....",
              labelColor: AppColors.black.withOpacity(0.5),
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.error,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primaryColor,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              borderRadius: 5.0,
            ),
            fieldHeading(Strings.DROP_OFF_STATUS.tr, context),
            const SpaceH4(),
            Obx(() => SizedBox(
                  width: double.maxFinite,
                  height: 65,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        padding: const EdgeInsets.all(8),
                        value: controller.quantityType.value,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.quantityTypeItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item,
                                  style: context.bodyLarge.copyWith(
                                      fontSize: 17,
                                      color: AppColors.black.withOpacity(0.7)),
                                ),
                                Icon(Icons.check,
                                    color: item == controller.quantityType.value
                                        ? AppColors.primaryColor
                                        : Colors.transparent),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.quantityType.value = newValue!;
                        },
                      ),
                    ),
                  ),
                )),
            const SpaceH4(),
            fieldHeading(Strings.PRODUCT_IMAGE.tr, context),
            const SpaceH4(),
            CustomButton(
              text: Strings.UPLOAD.tr,
              textColor: AppColors.white,
              radius: 5,
              icon: const Icon(
                EneftyIcons.document_upload_outline,
                color: AppColors.white,
              ),
              onTap: () => controller.pickFiles(),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(p.basename(controller.idCardFrontPath.value),
                        style: context.bodyLarge
                            .copyWith(color: AppColors.primaryColor))),
              ),
            ),
            const SpaceH16(),
            Align(
              alignment: Alignment.topLeft,
              child: Text(Strings.NOTE_REFUND.tr,
                  overflow: TextOverflow.clip,
                  style: context.bodySmall
                      .copyWith(fontSize: 14, color: AppColors.black)),
            ),
            const SpaceH2(),
            CustomButton.solid(
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.white,
              text: Strings.SEND.tr,
              onTap: () {
                if (controller.refundRequest.currentState!.validate()) {
                  CustomDialog.showDialog(
                      content: successDialog(context, () => Get.back(),
                          "Your Refund Request has been Submitted"));
                }
              },
              radius: Sizes.RADIUS_6,
              constraints: const BoxConstraints(minHeight: 55),
            ),
          ],
        ));
  }

  Align fieldHeading(
    String title,
    BuildContext context,
  ) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(title,
            style: context.bodyMedium
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500)));
  }

  Column successDialog(BuildContext context, dynamic onTap, String title) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Lottie.asset(Assets.SUCCESS,
                  width: 150, height: 150, fit: BoxFit.fill),
              Text(title,
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
}
