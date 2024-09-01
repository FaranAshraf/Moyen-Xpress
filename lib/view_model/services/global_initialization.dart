import '../../dummy/sign_in_data.dart';
import '../../resources/exports/index.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class GlobalInitialization {
  static Future<void> globalInitialization() async {
    WidgetsFlutterBinding.ensureInitialized();
    CustomLogger.configure();
    await initialization();
  }

  static Future initialization() async {
    await FlutterConfig.loadEnvVariables();

    LicenseRegistry.addLicense(() async* {
      final license =
          await rootBundle.loadString('assets/fonts/Poppins/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    await GetStorage.init(Strings.CACHE_BOX_KEY);

    await GetStorage.init().then((value) async {
      await Get.putAsync(() async => AuthManager(), permanent: true);
      await Get.putAsync(() async => SplashController(), permanent: true);
      if (AuthManager.instance.session.value?.user != null) {
        await AuthManager.instance.clearCacheImages();
      } else {
        AuthManager.instance.session.value?.user = User.fromJson(signInData);
      }
      await DefaultCacheManager().emptyCache();
    });
  }
}
