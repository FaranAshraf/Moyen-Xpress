import '../resources/exports/index.dart';

enum SnackBarStyle {
  info,
  success,
  failure,
  warning,
}

class CustomSnackBar {
  static void showSnackBar({
    required String message,
    int durationInSec = 2,
    SnackBarStyle snackBarStyle = SnackBarStyle.success,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
      () => {
        Get.closeCurrentSnackbar(),
        Get.closeAllSnackbars(),
      },
    );

    switch (snackBarStyle) {
      case SnackBarStyle.success:
        Get.snackbar(
          '',
          '',
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.transparent,
          snackPosition: SnackPosition.TOP,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.all(8),
          barBlur: 0,
          overlayBlur: 0,
          messageText: _buildMessageText("Success", message, AppColors.success),
          duration: Duration(seconds: durationInSec),
        );
        break;
      case SnackBarStyle.failure:
        Get.snackbar(
          '',
          '',
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.transparent,
          snackPosition: SnackPosition.TOP,
          barBlur: 0,
          overlayBlur: 0,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.all(8),
          messageText: _buildMessageText("Error !", message, AppColors.error),
          duration: Duration(seconds: durationInSec),
        );
        break;
      default:
        Get.snackbar(
          '',
          '',
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.transparent,
          snackPosition: SnackPosition.TOP,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.all(8),
          barBlur: 0,
          overlayBlur: 0,
          messageText: _buildMessageText("Success", message, AppColors.success),
          duration: Duration(seconds: durationInSec),
        );
        break;
    }
  }

  static Container _buildMessageText(
      String title, String message, Color color) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.context!.headlineSmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceH10(),
          Text(
            message,
            style: Get.context!.bodyLarge.copyWith(color: AppColors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
