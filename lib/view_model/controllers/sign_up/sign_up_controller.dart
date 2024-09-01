import '../../../resources/exports/index.dart';

class SignUpController extends GetxController {
  late GlobalKey<FormState> signUpFormKey;
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController passwordCtrl;
  late TextEditingController confirmPassCtrl;

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPassword() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> signUp() async {
    if (signUpFormKey.currentState?.validate() ?? false) {
      await AuthRepository.signUp(
        name: nameCtrl.text,
        email: emailCtrl.text,
        password: passwordCtrl.text,
        confirmPassword: confirmPassCtrl.text,
      );
      Get.toNamed(Routes.OTP_SCREEN, arguments: {
        "email": emailCtrl.text,
        "password": passwordCtrl.text,
      });
    }
  }

  @override
  void onInit() {
    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    confirmPassCtrl = TextEditingController();
    signUpFormKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    confirmPassCtrl.dispose();
    super.onClose();
  }
}
