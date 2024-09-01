import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/wire_transfer/wire_transfer_controller.dart';


class WireTransfer extends GetView<WireTransferController> {
  const WireTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Strings.WIRE_TRANSFER),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SpaceH8(),
                  headWire(
                    context,
                    Strings.BANK_ACC_NO,
                  ),
                  CustomTextFormField(
                    enabled: true,
                    readOnly: true,
                    controller: controller.bankAccNumber,
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
                    Strings.BANK_ROUT_NO,
                  ),
                  CustomTextFormField(
                    enabled: true,
                    readOnly: true,
                    controller: controller.bankRouteNumber,
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
                    Strings.SWIFT_CODE,
                  ),
                  CustomTextFormField(
                    enabled: true,
                    readOnly: true,
                    controller: controller.swiftCode,
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
                    Strings.BENEFICIARY,
                  ),
                  CustomTextFormField(
                    enabled: true,
                    readOnly: true,
                    controller: controller.beneficiary,
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
                    Strings.BANK_NAME,
                  ),
                  CustomTextFormField(
                    enabled: true,
                    readOnly: true,
                    controller: controller.bankName,
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
                    Strings.ADDRESS,
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
                                          title:
                                              const Text('Select From Camera'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 7),
                                        child: ListTile(
                                          onTap: () {
                                            controller.pickImageFromGallery();
                                            Get.close(-1);
                                          },
                                          leading: const Icon(Icons.image),
                                          title:
                                              const Text('Select From Gallery'),
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
              await controller.getWireTransfer();
              Get.toNamed(Routes.CONFIRM_ID);
            },
            radius: Sizes.RADIUS_6,
            constraints: const BoxConstraints(minHeight: 55),
          ),
        ),
      ]),
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
