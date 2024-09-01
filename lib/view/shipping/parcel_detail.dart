import 'package:moyen_express/resources/exports/index.dart';

class ParcelDetail extends GetView<GetQuoteController> {
  const ParcelDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.GET_A_QUOTE.tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 350.0,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(12.0),
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Text(
                            "Not sure about the size and weight then check the examples.",
                            style: context.bodyLarge.copyWith(
                                color: AppColors.white,
                                fontSize: 20,
                                height: 1.0,
                                fontWeight: FontWeight.w500),
                          ),
                          const SpaceH12(),
                          Row(
                            children: [
                              const SpaceW12(),
                              Image.asset(
                                Assets.A4_BOX,
                                scale: 6,
                              ),
                              const SpaceW20(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "A4 Size Envelope",
                                    style: context.bodyLarge.copyWith(
                                        color: AppColors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        height: 1.1),
                                  ),
                                  Text(
                                    "34 x 24 x 1 cm",
                                    style: context.bodyLarge.copyWith(
                                        color: AppColors.white, fontSize: 18),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SpaceH12(),
                          Row(
                            children: [
                              Image.asset(
                                Assets.BOOKS_BOX,
                                scale: 7.1,
                              ),
                              const SpaceW8(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "A4 Size Envelope",
                                    style: context.bodyLarge.copyWith(
                                        color: AppColors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        height: 1.1),
                                  ),
                                  Text(
                                    "23 x 14 x 4 cm",
                                    style: context.bodyLarge.copyWith(
                                        color: AppColors.white, fontSize: 18),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SpaceH12(),
                          Row(
                            children: [
                              Image.asset(
                                Assets.SHOE_BOX,
                                scale: 7.1,
                              ),
                              const SpaceW8(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shoe Size Box",
                                    style: context.bodyLarge.copyWith(
                                        color: AppColors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        height: 1.1),
                                  ),
                                  Text(
                                    "35 x 20 x 15 cm",
                                    style: context.bodyLarge.copyWith(
                                        color: AppColors.white, fontSize: 18),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SpaceH12(),
                          Row(
                            children: [
                              Image.asset(
                                Assets.MOVING_BOX,
                                scale: 7.1,
                              ),
                              const SpaceW8(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Moving Box",
                                    style: context.bodyLarge.copyWith(
                                        color: AppColors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        height: 1.1),
                                  ),
                                  Text(
                                    "75 x 35 x 35 cm",
                                    style: context.bodyLarge.copyWith(
                                        color: AppColors.white, fontSize: 18),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.black,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: fieldHeading(Strings.WHAT_IN_THE_BOX.tr, context),
                  ),
                  Form(
                    key: controller.name4Key,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomTextFormField(
                            controller: controller.description,
                            isRequired: false,
                            height: Sizes.HEIGHT_20,
                            labelText: "Describe Here....",
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child:
                              fieldHeading(Strings.VALUE_OF_PARCEL.tr, context),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomTextFormField(
                            controller: controller.valueOfItem,
                            isRequired: false,
                            height: Sizes.HEIGHT_20,
                            labelText: Strings.VALUE_OF_PARCEL.tr,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child:
                              fieldHeading(Strings.SET_PICKUP_DATE.tr, context),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: SizedBox(
                            height: Sizes.HEIGHT_60,
                            child: TextField(
                              controller: controller.dateController,
                              decoration: InputDecoration(
                                  hintText: 'mm/dd/yyyy',
                                  suffixIcon: const Icon(Icons.calendar_today),
                                  hintStyle: context.bodyMedium.copyWith(
                                      color:
                                          const Color.fromARGB(255, 90, 89, 89)
                                              .withOpacity(0.4)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: AppColors.black, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: AppColors.black, width: 1))),
                              readOnly: true,
                              onTap: () async {
                                await controller.datePick(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomButton.solid(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
            text: Strings.SUBMIT.tr,
            onTapAsync: () async {
              if (controller.name4Key.currentState?.validate() ?? false) {
                controller.contactData();
              }
            },
            radius: Sizes.RADIUS_6,
            constraints: const BoxConstraints(minHeight: 55),
          ),
        ],
      ),
    );
  }

  Align fieldHeading(String title, BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(title,
            style: context.bodyMedium
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500)));
  }
}
