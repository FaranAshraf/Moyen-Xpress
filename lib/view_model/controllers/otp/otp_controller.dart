import '../../../resources/exports/index.dart';

class OtpController extends GetxController {
  late TextEditingController pinCtrl;

  String email = "";
  String password = "";
  Duration myDuration = const Duration(seconds: 300);
  Timer? otpTimer;

  Future<void> verifyOtp() async {
    if (pinCtrl.text.length < 6 || email.isEmpty) return;
    await AuthRepository.verifyOtp(
      email: email,
      verificationCode: int.parse(pinCtrl.text),
    );
    Get.close(2);
  }

  void startTimer() {
    update(["resend_otp"]);
    otpTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final seconds = myDuration.inSeconds - 1;
        if (seconds == -1) {
          otpTimer?.cancel();
          update(["confirm_otp_button"]);
        } else {
          myDuration = Duration(seconds: seconds);
        }
        update(["otp_timer_text"]);
      },
    );
  }

  String getOtpDuration() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void onInit() {
    startTimer();
    email = Get.arguments != null ? Get.arguments['email'] : "";
    password = Get.arguments != null ? Get.arguments['password'] : "";
    pinCtrl = TextEditingController();
    super.onInit();
  }
}
