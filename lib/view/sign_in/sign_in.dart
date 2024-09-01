import '../../resources/exports/index.dart';

class SignIn extends GetView<SignInController> {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap:()=> Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: kToolbarHeight,
          left: 12,
          right: 12,
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.WELCOME_BACK_TO.tr,
                  style: context.titleLarge.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  Strings.MOYENXPRESS.tr,
                  style: context.headlineLarge.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SpaceH20(),
                Text(
                  Strings.LOGIN_SUBTITLE.tr,
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SpaceH40(),
                const LoginForm(),
                const SpaceH10(),
                _buildSignUpAndForgotPassText(context),
                const SpaceH20(),
                CustomButton.solid(
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  text: Strings.SIGN_IN.tr,
                  onTapAsync: () async => controller.signIn(),
                  radius: Sizes.RADIUS_12,
                  constraints: const BoxConstraints(minHeight: 55),
                ),
                const SpaceH30(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SocialLoginButtons(
                    socialLoginBtns: AuthenticationHelper.socialLoginBtns,
                  ),
                ),
                const SpaceH40(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpAndForgotPassText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(Routes.SIGN_UP),
          child: Text(
            Strings.DO_NOT_HAVE_AN_ACCOUNT.tr,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.w300,
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryColor,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
        // Text(
        //   Strings.FORGOT_PASSWORD.tr,
        //   style: context.titleLarge.copyWith(
        //     fontWeight: FontWeight.w300,
        //     color: AppColors.primaryColor,
        //     decoration: TextDecoration.underline,
        //     decorationColor: AppColors.primaryColor,
        //   ),
        //   overflow: TextOverflow.ellipsis,
        //   textAlign: TextAlign.right,
        // ),
      ],
    );
  }
}
