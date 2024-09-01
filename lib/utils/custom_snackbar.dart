import '../resources/exports/index.dart';

class CustomSnackbar {
  static Duration defaultDuration = Durations.extralong4 * 3;

  static Future<void> closeAllSnackBars() async {
    if (Get.isSnackbarOpen) {
      await Future.delayed(
        Durations.short1,
        () async {
          Get.closeAllSnackbars();
          await Get.closeCurrentSnackbar();
        },
      );
    }
  }

  static void error({
    String? title,
    required String message,
    Color? color,
    Duration? duration,
  }) async {
    await closeAllSnackBars();

    Get.snackbar(
      title ?? '',
      message,
      titleText: title == null ? const SizedBox.shrink() : null,
      duration: duration ?? defaultDuration,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
      colorText: Colors.white,
      maxWidth: 600,
      backgroundColor: color ?? Colors.redAccent,
      dismissDirection: DismissDirection.none,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  static get unsupportedPlatform => error(
        message: 'Operation is not supported on this platform.',
      );

  static get noItemSelected => error(
        message: 'Please select an item to continue.',
      );

  static get failedToUpdateImage => error(message: 'Failed to Update Image.');
}
