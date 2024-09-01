import '../../../resources/exports/index.dart';

class SignInController extends GetxController {
  late bool showPadding;
  late GlobalKey<FormState> loginFormKey;
  late TextEditingController emailCtrl;
  late TextEditingController passwordCtrl;
  RxBool isPasswordVisible = false.obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signIn() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      User? user = await AuthRepository.signIn(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );
      if (user != null) {
        Session? session = AuthManager.instance.session.value?.copyWith(
          user: user,
          tokenID: user.token,
        );

        await AuthManager.instance.login(session);
        Get.offAllNamed(Routes.ONBOARDING);
      }
    }
  }

  @override
  void onInit() {
    showPadding = Get.arguments != null ? Get.arguments['showPadding'] : false;
    loginFormKey = GlobalKey<FormState>();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
