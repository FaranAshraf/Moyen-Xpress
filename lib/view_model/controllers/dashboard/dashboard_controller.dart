import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/view_cart/view_cart_model.dart';
import '../../../repository/cart_repository.dart';
import '../../../resources/exports/index.dart';
import '../../helpers/global_helper/currency_conversion.dart';
import '../../helpers/notification_services/notification_services.dart';

class DashboardController extends GetxController {
  final TechnicianController technicianController =
      Get.put(TechnicianController());
  final StoreHomeController storeHomeController =
      Get.put(StoreHomeController());
  final PurchasingHistoryController purchasingHistoryController =
      Get.put(PurchasingHistoryController());
  final OnBoardingController onController = Get.put(OnBoardingController());
  static DashboardController instance = Get.find();

  late NavbarModel navbarItems;
  late List<DrawerModel> drawerItems;
  late List<FullDrawerModel> accountDrawerItem;
  late GlobalKey<ScaffoldState> drawerKey;
  RxString selectedCountry = "".obs;
  Future<dynamic>? off(String page, {dynamic arguments}) async {
    int index = navbarItems.items.indexWhere(
      (element) => element.title.toLowerCase().contains(
            page.replaceAll("/", "").replaceAll("_", " "),
          ),
    );

    if (navbarItems.currentRouteIndex == index) return;

    navbarItems = navbarItems.copyWith(currentRouteIndex: index);

    log.w(navbarItems.currentRouteIndex);

    update(["bottom_nav_bar"]);

    await Get.offAllNamed(
      page,
      id: Strings.GET_NESTED_KEY_1,
      arguments: arguments,
    );
  }

  void onMenuTap() => drawerKey.currentState?.openEndDrawer();
  void onAccountTap() => drawerKey.currentState?.openDrawer();
  Future<void> onDrawerItemTap(Future<dynamic>? route) async {
    drawerKey.currentState?.closeEndDrawer();
    await route;
  }

  static DashboardController get to => Get.find();
  static const String modelKey = 'Model_shown';

  Future<bool> isTutorialShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool tutorialShown = prefs.getBool(modelKey) ?? false;
    if (kDebugMode) {
      print("Model shown: $tutorialShown");
    }
    return tutorialShown;
  }

  Future<void> markTutorialAsShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(modelKey, true);
    if (kDebugMode) {
      print("Tutorial marked as shown");
    }
  }

  RxList<CartItem> cartItems = <CartItem>[].obs;

  Future<void> fetchCartItems() async {
    try {
      List<CartItem>? cartProducts = await CartRepository.getCartProducts();
      cartItems.assignAll(cartProducts!);
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print("Error fetching cart products: $e");
      }
    }
  }

  // ignore: unused_field
  late Timer _apiTimer;
  void startApiTimer() {
    const duration = Duration(seconds: 5);
    _apiTimer = Timer.periodic(duration, (_) {
      fetchCartItems();
    });
  }

  final box = GetStorage();
  Map<String, String> languageList = {
    "English": "en",
    "Français": "fr",
    // "Urdu": "ur",
  };
  late RxString currentCurrency =
      "USD".obs; // Assuming USD is your default currency

  late RxString currentLanguage = "English".obs;
  late String currentLanguageCode = "en";

  void showSettingsDialog() async {
    bool tutorialAlreadyShown = await isTutorialShown();
    if (tutorialAlreadyShown) {
      return;
    }
    Get.defaultDialog(
      title: 'Select Language',
      titleStyle: const TextStyle(color: AppColors.primaryColor),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 1)),
                  child: Center(
                    child: DropdownButton<String>(
                      menuMaxHeight: 300,
                      isExpanded: true,
                      iconSize: 30,
                      underline: const SizedBox(),
                      isDense: false,
                      alignment: Alignment.center,
                      dropdownColor: AppColors.white,
                      value: currentLanguage.value,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          // Update the current selected language
                          currentLanguage.value = newValue;
                          log.e(newValue);
                          // Trigger UI update
                          update();
                        }
                      },
                      items: languageList.keys.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            SizedBox(
                height: Get.height * 0.06,
                width: Get.width * 0.9,
                child: CustomButton.solid(
                  text: Strings.SAVE,
                  textColor: AppColors.white,
                  backgroundColor: AppColors.primaryColor,
                  onTap: () {
                    Get.back();
                    currentLanguageCode = languageList[currentLanguage]!;
                    updateAppLanguage();
                  },
                ))
          ],
        ),
      ),
    );
    markTutorialAsShown();
  }

  Future<void> initLanguage() async {
    await box.initStorage; // Initialize storage

    // Initialize currency
    if (box.hasData('selectedCurrency')) {
      String? savedCurrency = box.read('selectedCurrency');
      if (savedCurrency != null &&
          currencyListNew
              .map((e) => e['abbreviation'])
              .contains(savedCurrency)) {
        currentCurrency.value = savedCurrency;
      }
    }

    if (box.hasData('selectedLanguage')) {
      // Check if language preference exists in storage
      String? savedLanguage = box.read('selectedLanguage');
      if (savedLanguage != null && languageList.containsValue(savedLanguage)) {
        currentLanguage.value = languageList.keys.firstWhere(
          (key) => languageList[key] == savedLanguage,
          orElse: () => "English",
        );
        currentLanguageCode = savedLanguage;
        updateAppLanguage();
      }
    }
  }

  void saveSelectedCurrency() {
    box.write('selectedCurrency', currentCurrency.value);
  }

  void saveSelectedLanguage() {
    box.write('selectedLanguage', currentLanguageCode);
  }

  void updateAppLanguage() {
    Get.updateLocale(Locale(currentLanguageCode));
    saveSelectedLanguage();
  }

  List<Map<String, String>> currencyListNew = [
    {"abbreviation": "AED", "name": "United Arab Emirates Dirham"},
    {"abbreviation": "AFN", "name": "Afghan Afghani"},
    {"abbreviation": "ALL", "name": "Albanian Lek"},
    {"abbreviation": "AMD", "name": "Armenian Dram"},
    {"abbreviation": "ANG", "name": "Netherlands Antillean Guilder"},
    {"abbreviation": "AOA", "name": "Angolan Kwanza"},
    {"abbreviation": "ARS", "name": "Argentine Peso"},
    {"abbreviation": "AUD", "name": "Australian Dollar"},
    {"abbreviation": "AWG", "name": "Aruban Florin"},
    {"abbreviation": "AZN", "name": "Azerbaijani Manat"},
    {"abbreviation": "BAM", "name": "Bosnia-Herzegovina Convertible Mark"},
    {"abbreviation": "BBD", "name": "Barbadian Dollar"},
    {"abbreviation": "BDT", "name": "Bangladeshi Taka"},
    {"abbreviation": "BGN", "name": "Bulgarian Lev"},
    {"abbreviation": "BHD", "name": "Bahraini Dinar"},
    {"abbreviation": "BIF", "name": "Burundian Franc"},
    {"abbreviation": "BMD", "name": "Bermudian Dollar"},
    {"abbreviation": "BND", "name": "Brunei Dollar"},
    {"abbreviation": "BOB", "name": "Bolivian Boliviano"},
    {"abbreviation": "BRL", "name": "Brazilian Real"},
    {"abbreviation": "BSD", "name": "Bahamian Dollar"},
    {"abbreviation": "BTN", "name": "Bhutanese Ngultrum"},
    {"abbreviation": "BWP", "name": "Botswanan Pula"},
    {"abbreviation": "BYN", "name": "Belarusian Ruble"},
    {"abbreviation": "BZD", "name": "Belize Dollar"},
    {"abbreviation": "CAD", "name": "Canadian Dollar"},
    {"abbreviation": "CDF", "name": "Congolese Franc"},
    {"abbreviation": "CHF", "name": "Swiss Franc"},
    {"abbreviation": "CLP", "name": "Chilean Peso"},
    {"abbreviation": "CNY", "name": "Chinese Yuan"},
    {"abbreviation": "COP", "name": "Colombian Peso"},
    {"abbreviation": "CRC", "name": "Costa Rican Colón"},
    {"abbreviation": "CUP", "name": "Cuban Peso"},
    {"abbreviation": "CVE", "name": "Cape Verdean Escudo"},
    {"abbreviation": "CZK", "name": "Czech Republic Koruna"},
    {"abbreviation": "DJF", "name": "Djiboutian Franc"},
    {"abbreviation": "DKK", "name": "Danish Krone"},
    {"abbreviation": "DOP", "name": "Dominican Peso"},
    {"abbreviation": "DZD", "name": "Algerian Dinar"},
    {"abbreviation": "EGP", "name": "Egyptian Pound"},
    {"abbreviation": "ERN", "name": "Eritrean Nakfa"},
    {"abbreviation": "ETB", "name": "Ethiopian Birr"},
    {"abbreviation": "EUR", "name": "Euro"},
    {"abbreviation": "FJD", "name": "Fijian Dollar"},
    {"abbreviation": "FKP", "name": "Falkland Islands Pound"},
    {"abbreviation": "FOK", "name": "Faroese Króna"},
    {"abbreviation": "GBP", "name": "British Pound Sterling"},
    {"abbreviation": "GEL", "name": "Georgian Lari"},
    {"abbreviation": "GGP", "name": "Guernsey Pound"},
    {"abbreviation": "GHS", "name": "Ghanaian Cedi"},
    {"abbreviation": "GIP", "name": "Gibraltar Pound"},
    {"abbreviation": "GMD", "name": "Gambian Dalasi"},
    {"abbreviation": "GNF", "name": "Guinean Franc"},
    {"abbreviation": "GTQ", "name": "Guatemalan Quetzal"},
    {"abbreviation": "GYD", "name": "Guyanaese Dollar"},
    {"abbreviation": "HKD", "name": "Hong Kong Dollar"},
    {"abbreviation": "HNL", "name": "Honduran Lempira"},
    {"abbreviation": "HRK", "name": "Croatian Kuna"},
    {"abbreviation": "HTG", "name": "Haitian Gourde"},
    {"abbreviation": "HUF", "name": "Hungarian Forint"},
    {"abbreviation": "IDR", "name": "Indonesian Rupiah"},
    {"abbreviation": "ILS", "name": "Israeli New Shekel"},
    {"abbreviation": "IMP", "name": "Isle of Man Pound"},
    {"abbreviation": "INR", "name": "Indian Rupee"},
    {"abbreviation": "IQD", "name": "Iraqi Dinar"},
    {"abbreviation": "IRR", "name": "Iranian Rial"},
    {"abbreviation": "ISK", "name": "Icelandic Króna"},
    {"abbreviation": "JEP", "name": "Jersey Pound"},
    {"abbreviation": "JMD", "name": "Jamaican Dollar"},
    {"abbreviation": "JOD", "name": "Jordanian Dinar"},
    {"abbreviation": "JPY", "name": "Japanese Yen"},
    {"abbreviation": "KES", "name": "Kenyan Shilling"},
    {"abbreviation": "KGS", "name": "Kyrgystani Som"},
    {"abbreviation": "KHR", "name": "Cambodian Riel"},
    {"abbreviation": "KID", "name": "Kiribati Dollar"},
    {"abbreviation": "KMF", "name": "Comorian Franc"},
    {"abbreviation": "KRW", "name": "South Korean Won"},
    {"abbreviation": "KWD", "name": "Kuwaiti Dinar"},
    {"abbreviation": "KYD", "name": "Cayman Islands Dollar"},
    {"abbreviation": "KZT", "name": "Kazakhstani Tenge"},
    {"abbreviation": "LAK", "name": "Laotian Kip"},
    {"abbreviation": "LBP", "name": "Lebanese Pound"},
    {"abbreviation": "LKR", "name": "Sri Lankan Rupee"},
    {"abbreviation": "LRD", "name": "Liberian Dollar"},
    {"abbreviation": "LSL", "name": "Lesotho Loti"},
    {"abbreviation": "LYD", "name": "Libyan Dinar"},
    {"abbreviation": "MAD", "name": "Moroccan Dirham"},
    {"abbreviation": "MDL", "name": "Moldovan Leu"},
    {"abbreviation": "MGA", "name": "Malagasy Ariary"},
    {"abbreviation": "MKD", "name": "Macedonian Denar"},
    {"abbreviation": "MMK", "name": "Myanmar Kyat"},
    {"abbreviation": "MNT", "name": "Mongolian Tugrik"},
    {"abbreviation": "MOP", "name": "Macanese Pataca"},
    {"abbreviation": "MRU", "name": "Mauritanian Ouguiya"},
    {"abbreviation": "MUR", "name": "Mauritian Rupee"},
    {"abbreviation": "MVR", "name": "Maldivian Rufiyaa"},
    {"abbreviation": "MWK", "name": "Malawian Kwacha"},
    {"abbreviation": "MXN", "name": "Mexican Peso"},
    {"abbreviation": "MYR", "name": "Malaysian Ringgit"},
    {"abbreviation": "MZN", "name": "Mozambican Metical"},
    {"abbreviation": "NAD", "name": "Namibian Dollar"},
    {"abbreviation": "NGN", "name": "Nigerian Naira"},
    {"abbreviation": "NIO", "name": "Nicaraguan Córdoba"},
    {"abbreviation": "NOK", "name": "Norwegian Krone"},
    {"abbreviation": "NPR", "name": "Nepalese Rupee"},
    {"abbreviation": "NZD", "name": "New Zealand Dollar"},
    {"abbreviation": "OMR", "name": "Omani Rial"},
    {"abbreviation": "PAB", "name": "Panamanian Balboa"},
    {"abbreviation": "PEN", "name": "Peruvian Nuevo Sol"},
    {"abbreviation": "PGK", "name": "Papua New Guinean Kina"},
    {"abbreviation": "PHP", "name": "Philippine Peso"},
    {"abbreviation": "PKR", "name": "Pakistani Rupee"},
    {"abbreviation": "PLN", "name": "Polish Zloty"},
    {"abbreviation": "PYG", "name": "Paraguayan Guarani"},
    {"abbreviation": "QAR", "name": "Qatari Riyal"},
    {"abbreviation": "RON", "name": "Romanian Leu"},
    {"abbreviation": "RSD", "name": "Serbian Dinar"},
    {"abbreviation": "RUB", "name": "Russian Ruble"},
    {"abbreviation": "RWF", "name": "Rwandan Franc"},
    {"abbreviation": "SAR", "name": "Saudi Riyal"},
    {"abbreviation": "SBD", "name": "Solomon Islands Dollar"},
    {"abbreviation": "SCR", "name": "Seychellois Rupee"},
    {"abbreviation": "SDG", "name": "Sudanese Pound"},
    {"abbreviation": "SEK", "name": "Swedish Krona"},
    {"abbreviation": "SGD", "name": "Singapore Dollar"},
    {"abbreviation": "SHP", "name": "Saint Helena Pound"},
    {"abbreviation": "SLE", "name": "Sierra Leonean Leone"},
    {"abbreviation": "SOS", "name": "Somali Shilling"},
    {"abbreviation": "SRD", "name": "Surinamese Dollar"},
    {"abbreviation": "SSP", "name": "South Sudanese Pound"},
    {"abbreviation": "STN", "name": "São Tomé and Príncipe Dobra"},
    {"abbreviation": "SYP", "name": "Syrian Pound"},
    {"abbreviation": "SZL", "name": "Swazi Lilangeni"},
    {"abbreviation": "THB", "name": "Thai Baht"},
    {"abbreviation": "TJS", "name": "Tajikistani Somoni"},
    {"abbreviation": "TMT", "name": "Turkmenistani Manat"},
    {"abbreviation": "TND", "name": "Tunisian Dinar"},
    {"abbreviation": "TOP", "name": "Tongan Pa'anga"},
    {"abbreviation": "TRY", "name": "Turkish Lira"},
    {"abbreviation": "TTD", "name": "Trinidad and Tobago Dollar"},
    {"abbreviation": "TVD", "name": "Tuvaluan Dollar"},
    {"abbreviation": "TWD", "name": "New Taiwan Dollar"},
    {"abbreviation": "TZS", "name": "Tanzanian Shilling"},
    {"abbreviation": "UAH", "name": "Ukrainian Hryvnia"},
    {"abbreviation": "UGX", "name": "Ugandan Shilling"},
    {"abbreviation": "USD", "name": "United States Dollar"},
    {"abbreviation": "UYU", "name": "Uruguayan Peso"},
    {"abbreviation": "UZS", "name": "Uzbekistan Som"},
    {"abbreviation": "VES", "name": "Venezuelan Bolívar"},
    {"abbreviation": "VND", "name": "Vietnamese Dong"},
    {"abbreviation": "VUV", "name": "Vanuatu Vatu"},
    {"abbreviation": "WST", "name": "Samoan Tala"},
    {"abbreviation": "XAF", "name": "Central African CFA Franc"},
    {"abbreviation": "XCD", "name": "East Caribbean Dollar"},
    {"abbreviation": "XDR", "name": "Special Drawing Rights"},
    {"abbreviation": "XOF", "name": "West African CFA Franc"},
    {"abbreviation": "XPF", "name": "CFP Franc"},
    {"abbreviation": "YER", "name": "Yemeni Rial"},
    {"abbreviation": "ZAR", "name": "South African Rand"},
    {"abbreviation": "ZMW", "name": "Zambian Kwacha"},
    {"abbreviation": "ZWL", "name": "Zimbabwean Dollar"},
  ];

  void getSettings() {
    Get.defaultDialog(
      title: 'Select Language & Currency',
      titleStyle: const TextStyle(color: AppColors.primaryColor),
      content: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 1)),
                  child: Center(
                    child: DropdownButton<String>(
                      menuMaxHeight: 300,
                      isExpanded: true,
                      iconSize: 30,
                      underline: const SizedBox(),
                      isDense: false,
                      alignment: Alignment.center,
                      dropdownColor: AppColors.white,
                      value: currentCurrency.value,
                      items: currencyListNew
                          .map<DropdownMenuItem<String>>((currency) {
                        return DropdownMenuItem<String>(
                          value: currency['abbreviation']!,
                          child: Text(
                              "${currency['name']} (${currency["abbreviation"]})"),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          currentCurrency.value = newValue;
                          saveSelectedCurrency();
                          if (kDebugMode) {
                            print("New currency selected: $newValue");
                          }
                          update();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SpaceH20(),
              Obx(() => Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                            color: AppColors.primaryColor, width: 1)),
                    child: Center(
                      child: DropdownButton<String>(
                        menuMaxHeight: 300,
                        isExpanded: true,
                        iconSize: 30,
                        underline: const SizedBox(),
                        isDense: false,
                        alignment: Alignment.center,
                        dropdownColor: AppColors.white,
                        value: currentLanguage.value,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            currentLanguage.value = newValue;

                            update();
                          }
                        },
                        items: languageList.keys.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                  height: Get.height * 0.06,
                  width: Get.width * 0.9,
                  child: CustomButton.solid(
                    text: Strings.SAVE,
                    textColor: AppColors.white,
                    backgroundColor: AppColors.primaryColor,
                    onTap: () {
                      Get.back();
                      currentLanguageCode = languageList[currentLanguage]!;
                      updateAppLanguage();
                      final cc = Get.put(CurrencyConversionController());
                      cc.changeCurrentCurrency(currentCurrency.value);
                      box.write(Strings.LANGUAGE_LOCALE,
                          languageList[currentLanguage]!);
                      Get.updateLocale(Locale(languageList[currentLanguage]!));

                      Get.back();
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  NotificationServices notificationServices = NotificationServices();
  @override
  void onInit() {
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(Get.context!);
    notificationServices.setupInteractMessage(Get.context!);
    notificationServices.getDeviceToken().then((value) {
      log.e("Device Token:$value");
    });
    startApiTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initLanguage();
      // showSettingsDialog();
      getSettings();
    });

    drawerKey = GlobalKey<ScaffoldState>();
    navbarItems = NavbarModel(
      currentRouteIndex: 0,
      items: [
        NavbarDataModel(
          icon: Icons.home_outlined,
          title: Strings.HOME,
          onTap: () async => instance.off(Routes.HOME),
        ),
        NavbarDataModel(
          icon: Icons.list,
          title: Strings.CATEGORIES,
          onTap: () {
            onController.showBanner3.value = true;
            instance.off(Routes.CATEGORIES);
          },
        ),
        NavbarDataModel(
          // ignore: deprecated_member_use
          icon: FontAwesomeIcons.luggageCart,
          title: Strings.CART,
          onTap: () => Get.toNamed(Routes.ALL_PRODUCTS),
        ),
        NavbarDataModel(
          icon: Icons.notifications_none,
          title: Strings.NOTIFICATION,
          onTap: () async => instance.off(Routes.NOTIFICATION),
        ),
        AuthManager.instance.isLoggedIn
            ? NavbarDataModel(
                icon: Icons.person_outline,
                title: Strings.ACCOUNT,
                onTap: () async => Get.toNamed(
                      Routes.MY_ACCOUNT,
                    ))
            : NavbarDataModel(
                icon: Icons.person_outline,
                title: Strings.SIGN_IN,
                onTap: () async => Get.toNamed(
                  Routes.SIGN_IN,
                  arguments: {"showPadding": true},
                ),
              )
      ],
    );

    drawerItems = [
      DrawerModel(
        title: Strings.STORES,
        icon: Icons.store_outlined,
        onTap: () {
          onController.showBanner2.value = true;
          onDrawerItemTap(Get.toNamed(Routes.STORE));
        },
      ),
      DrawerModel(
        title: Strings.SHIP_WITH_MOYEN,
        icon: Icons.local_shipping_outlined,
        onTap: () => onDrawerItemTap(Get.toNamed(Routes.GET_QUOTE)),
      ),
      DrawerModel(
        title: Strings.TECHNICIAN,
        icon: Icons.construction_outlined,
        onTap: () {
          technicianController.isTechProducts.value = true;
          onDrawerItemTap(Get.toNamed(Routes.TECHNICIAN_VIEW));
        },
      ),
      DrawerModel(
        title: "${Strings.MX_SHIPPING} (ORMQ)",
        icon: Icons.local_shipping_outlined,
        onTap: () => onDrawerItemTap(Get.toNamed(Routes.MXSHIPPING_VIEW)),
      ),
      DrawerModel(
        title: Strings.PURCHASE_HISTORY,
        icon: Icons.history,
        onTap: () {
          purchasingHistoryController.isPurchaseHistory.value = true;
          onDrawerItemTap(Get.toNamed(Routes.PURCHASE_HISTORY));
        },
      ),
      DrawerModel(
        title: Strings.AUCTION,
        icon: Assets.AUCTION,
        onTap: () {
          technicianController.isTechProducts.value = false;
          onDrawerItemTap(Get.toNamed(Routes.AUCTION));
        },
      ),
      DrawerModel(
        title: Strings.MY_ORDERS,
        icon: Assets.MY_ORDERS,
        onTap: () => onDrawerItemTap(Get.toNamed(Routes.MY_ORDERS)),
      ),
      DrawerModel(
        title: Strings.WISHLIST,
        icon: Icons.favorite_outline,
        onTap: () => onDrawerItemTap(Get.toNamed(Routes.WISHLIST)),
      ),
      DrawerModel(
        title: Strings.SETTING,
        icon: Icons.settings,
        onTap: () {
          Get.close(-1);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            getSettings();
          });
        },
      ),
      DrawerModel(
        title: Strings.ABOUT,
        icon: Icons.error_outline,
        onTap: () => onDrawerItemTap(Get.toNamed(Routes.ABOUT)),
      ),
      DrawerModel(
        title: Strings.CONTACT,
        icon: Icons.phone_outlined,
        onTap: () => onDrawerItemTap(Get.toNamed(Routes.CONTACT)),
      ),
    ];

    if (onController.showBanner1.value == true) {
      Future.delayed(const Duration(seconds: 7), () {
        if (Get.currentRoute == Routes.DASHBOARD) {
          CustomDialog.showDialog(
              width: 350,
              height: 600,
              content: const BannerView(img: Assets.ANIMATED_BANNER1));
        }
      });
    }

    storeHomeController.onDummyData.value = false;
    super.onInit();
  }
}
