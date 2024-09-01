import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/repository/recently_views_repository.dart';

class MyAccountController extends GetxController {
  final box = GetStorage();

  RxList<dynamic> checkOut = [
    {
      "title": "Product(s)",
      "color": 0xffc84f9b,
      "subtitle": "in your cart",
      "count": 0,
      "onTap": () {
        Get.toNamed(Routes.CART);
      }
    },
    {
      "title": "Product(s)",
      "color": 0xff5f4cbb,
      "subtitle": "in your wishlist",
      "count": 0,
      "onTap": () {
        Get.toNamed(Routes.WISHLIST);
      }
    },
    {
      "title": "Product(s)",
      "color": 0xff5f9ddf,
      "subtitle": "your ordered",
      "count": 0,
      "onTap": () {
        Get.toNamed(Routes.PURCHASE_HISTORY);
      }
    },
    {
      "title": "Product(s)",
      "color": 0xFFFFAC4D,
      "subtitle": "Recently Viewed Products",
      "count": 0,
      "onTap": () {
        Get.toNamed(Routes.RECENTLY_VIEWS);
      }
    }
  ].obs;
  List<dynamic> tabs = [
    {
      "title": Strings.MY_INQUIRIES,
      "icon": Icons.question_answer_rounded,
      "onTap": () {
        Get.toNamed(Routes.INQUIRIES);
      }
    },
    {
      "title": Strings.MY_CASHBACK,
      "icon": Icons.money,
      "onTap": () {
        Get.toNamed(Routes.CASHBACK_HISTORY);
      }
    },
    {
      "title": Strings.MY_QUOTE,
      "icon": EneftyIcons.quote_down_bold,
      "onTap": () {
        Get.toNamed(Routes.QUOTATION_HISTORY);
      }
    },
    {
      "title": Strings.SEND_REFUND_REQUEST,
      "icon": Icons.replay_sharp,
      "onTap": () {
        Get.toNamed(Routes.SEND_REQUEST_REFUND);
      }
    },
    {
      "title": Strings.SEND_REPLACE_REQUEST,
      "icon": Icons.autorenew,
      "onTap": () {
        Get.toNamed(Routes.SEND_REQUEST_REPLACE);
      }
    },
    {"title": Strings.CONVERSATIONS, "icon": Icons.chat_sharp, "onTap": () {}},
    {
      "title": Strings.MY_WALLET,
      "icon": Icons.wallet,
      "onTap": () {
        Get.toNamed(Routes.WALLET);
      }
    },
    {
      "title": Strings.WITHDRAW_REQUEST,
      "icon": Icons.request_page,
      "onTap": () {
        Get.toNamed(Routes.WITHDRAW_REQUEST);
      }
    },
    {
      "title": Strings.MANAGED_PROFILE,
      "icon": Icons.person_2_outlined,
      "onTap": () {
        Get.toNamed(Routes.PROFILE_SCREEN);
      }
    },
    {
      "title": Strings.DELETE_MY_ACCOUNT,
      "icon": Icons.delete_outline_rounded,
      "onTap": () {
        final box = GetStorage();

        showDialog(
          context: Get.context!,
          builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SpaceH10(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.white),
                      ),
                      child: ClipOval(
                        child: ImageService.image(
                          box.read("imageUrl") ??
                              "https://pics.craiyon.com/2023-07-15/dc2ec5a571974417a5551420a4fb0587.webp",
                          imageSize: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 16,
                        child:
                            Icon(Icons.warning, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Delete your account?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You will lose all your data by deleting your account. This action cannot be undone.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton.solid(
                      margin: const EdgeInsets.all(10.0),
                      backgroundColor: Colors.blue,
                      textColor: AppColors.white,
                      text: Strings.DENY_DELETE.tr,
                      radius: Sizes.RADIUS_6,
                      constraints: const BoxConstraints(minHeight: 55),
                    ),
                    CustomButton.solid(
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      backgroundColor: AppColors.error,
                      textColor: AppColors.white,
                      text: Strings.DELETE_MY_ACCOUNT.tr,
                      radius: Sizes.RADIUS_6,
                      onTapAsync: () async {
                        // Perform account deletion
                        await AuthRepository.deleteMyAccount();

                        // Clear cached images
                        await AuthManager.instance.clearCacheImages();

                        // Remove user credentials
                        await AuthManager.instance.removeCredentials();

                        // Notify all relevant controllers or UI components
                        AuthManager.instance
                            .updateSession(); // Update session or notify controllers if needed
                        AuthManager.instance.isLoggedIn == true;
                        // Navigate to the onboarding route and clear navigation stack
                        Get.offAllNamed(Routes.ONBOARDING);

                        // Optionally, add a delay to ensure navigation occurs after the state changes
                        await Future.delayed(const Duration(milliseconds: 500));
                      },
                      constraints: const BoxConstraints(minHeight: 55),
                    )
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }
    },
    {
      "title": Strings.LOGOUT,
      "icon": Icons.logout,
      "onTap": () async {
        await AuthRepository.logout();

        await AuthManager.instance.clearCacheImages();

        await AuthManager.instance.removeCredentials();

        AuthManager.instance.updateSession();

        Get.offAllNamed(Routes.ONBOARDING);
      }
    },
  ];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final recentViewData = await RecentlyViewRepository.getDailyDeals();
    if (recentViewData != null) {
      checkOut[0]['count'] = recentViewData.cartCount ?? 0;
      checkOut[1]['count'] = recentViewData.wishListCount ?? 0;
      checkOut[2]['count'] = recentViewData.totalProducts ?? 0;
      checkOut[3]['count'] = recentViewData.recentView?.length ?? 0;
      update();
    }
  }
}
