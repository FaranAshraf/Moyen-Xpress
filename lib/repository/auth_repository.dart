import '../resources/exports/index.dart';

class AuthRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await apiService.postApi(Urls.SIGN_UP, {
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
    });
    if (response is bool) return;
  }

  static Future<User?> verifyOtp({
    required String email,
    required int verificationCode,
  }) async {
    final response = await apiService.postApi(Urls.VERIFY_OTP, {
      "email": email,
      "verification_code": verificationCode,
    });
    if (response is bool) return null;
    return User.fromJson(response);
  }

  static Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final response = await apiService.postApi(Urls.LOGIN, {
      "email": email,
      "password": password,
    });
    if (response is bool) return null;
    log.e(response);
    return User.fromJson(response);
  }

  static Future<void> profileUpdate({
    required String name,
    required String phoneNo,
    required String newPassword,
    required String newPasswordConfirmation,
    required String oldPassword,
    required String image,
  }) async {
    final response = await apiService.putApi(
        '/api/appV1/updateProfile/${AuthManager.instance.user!.userID!}', {
      "name": name,
      "phone": phoneNo,
      "new_password": newPassword,
      "new_password_confirmation": newPasswordConfirmation,
      "old_password": oldPassword,
      "avatar_original": image
    });

    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.warning);
  }

  static Future<void> deleteMyAccount() async {
    final response = await apiService.deleteApi(Urls.DELETE_ACCOUNT,
        quaryParameters: {"id": '${AuthManager.instance.user?.userID}'});
    if (response is bool) return;
    log.e(response);
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }

  static Future<void> logout() async {
    final response =
        await apiService.postApi('/api/appV1/logout', {}, quaryParameters: {
      "user_id": '${AuthManager.instance.user?.userID}',
    });
    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }

  static Future<void> updateEmail({
    required String email,
  }) async {
    final response =
        await apiService.postApi(Urls.UPDATE_EMAIL, {}, quaryParameters: {
      "email": email,
    });
    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }
}
