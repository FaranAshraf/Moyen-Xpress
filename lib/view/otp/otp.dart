import '../../resources/exports/index.dart';

class OtpScreen extends GetView<OtpController> {
  static const String routeName = "/otp_screen";
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            bottom: Sizes.PADDING_40,
            left: Sizes.PADDING_16,
            right: Sizes.PADDING_16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.ENTER_OTP.tr,
                style: context.headlineLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SpaceH4(),
              Text(
                "Enter the One-Time Password (OTP) sent to your registered Email to verify your account."
                    .tr,
                style: context.titleMedium.copyWith(
                  color: AppColors.black,
                ),
              ),
              const SpaceH32(),
              Center(child: _buildPinField()),
              const SpaceH20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<OtpController>(
                    id: "otp_timer_text",
                    builder: (_) {
                      return Text(
                        controller.getOtpDuration(),
                        style: context.titleMedium.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      );
                    },
                  ),
                  // GetBuilder<OtpController>(
                  //   id: "confirm_otp_button",
                  //   builder: (_) {
                  //     return GestureDetector(
                  //       onTap: () {},
                  //       child: Text(
                  //         controller.otpTimer == null ||
                  //                 controller.otpTimer!.isActive ||
                  //                 controller.isLoading
                  //             ? ""
                  //             : "Resend".tr,
                  //         style: context.titleMedium.copyWith(
                  //           color: AppColors.error,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
              const SpaceH20(),
              CustomButton.solid(
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
                text: Strings.VERIFY.tr,
                onTapAsync: () async => controller.verifyOtp(),
                radius: Sizes.RADIUS_6,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinField() {
    const focusedBorderColor = AppColors.primaryColor;
    const fillColor = AppColors.primaryLight;
    const borderColor = AppColors.primaryColor;

    final defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: const TextStyle(fontSize: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
    );
    return Pinput(
      length: 6,
      obscureText: true,
      obscuringWidget: Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
      ),
      controller: controller.pinCtrl,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
      listenForMultipleSmsOnAndroid: true,
      defaultPinTheme: defaultPinTheme,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onCompleted: (pin) {
        debugPrint('onCompleted: $pin');
      },
      onChanged: (value) {
        debugPrint('onChanged: $value');
      },
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: focusedBorderColor,
          ),
        ],
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: focusedBorderColor, width: 2),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: fillColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: AppColors.error),
      ),
    );
  }
}
