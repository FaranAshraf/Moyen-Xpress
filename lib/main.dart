import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moyen_express/firebase_options.dart';
import 'package:moyen_express/lang/trans.dart';

import 'resources/exports/index.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  print("Environment Variables: ${FlutterConfig.variables}");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await GlobalInitialization.globalInitialization();
  Stripe.publishableKey = FlutterConfig.get("STRIPE_KEY");
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print(message.notification!.title.toString());
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _getStorage = GetStorage();
    final String languageLocale = _getStorage.read("language_locale") ?? "en";
    return DismissKeyboard(
      child: GetMaterialApp(
        title: 'Moyen Xpress',
        debugShowCheckedModeBanner: false,
        theme: ThemeController().getTheme,
        builder: (context, widget) {
          return ResponsiveWrapper.builder(
            MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1),
              ),
              child: BouncingScrollWrapperX.builder(
                context,
                widget!,
                dragWithMouse: true,
              ),
            ),
            defaultScale: true,
            breakpoints: const [
              ResponsiveBreakpoint.autoScaleDown(450, name: MOBILE),
            ],
          );
        },
        locale: Locale(languageLocale),
        fallbackLocale: const Locale('en', 'US'),
        translations: AppTranslations(),
        onGenerateRoute: Pages.onGenerateRoute,
        initialRoute: Routes.SPLASH_SCREEN,
        defaultTransition: Transition.rightToLeft,
        smartManagement: SmartManagement.full,
        // home: const DemoView(),
      ),
    );
  }
}
