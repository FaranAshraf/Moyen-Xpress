import '../../resources/exports/index.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: PopScope(
        canPop: false,
        child: Scaffold(  
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartDocked,
          floatingActionButton: const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: PolygonWidget(),
          ),
          key: controller.drawerKey,
          endDrawer: MyDrawer(items: controller.drawerItems),
          extendBody: true,
          appBar: _buildAppBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavigator().expanded(),
            ],
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context),
        ),
      ),
    );
  }

  Navigator _buildNavigator() {
    return Navigator(
      key: Get.nestedKey(Strings.GET_NESTED_KEY_1),
      onGenerateRoute: Pages.onGenerateRoute,
      initialRoute: Routes.HOME,
    );
  }

  CustomShadow _buildBottomNavigationBar(BuildContext context) {
    return CustomShadow(
      offset: const Offset(0.0, -2.0),
      color: AppColors.black.withOpacity(0.2),
      child: ClipPath(
        clipper: NavBarClipper(),
        child: Container(
          width: double.maxFinite,
          height: 100.0,
          color: AppColors.white,
          // padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              controller.navbarItems.items.length,
              (index) => controller.navbarItems.items[index].title ==
                      Strings.CART
                  ? GestureDetector(
                      onTap: () => controller.navbarItems.items[index].onTap(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                controller.navbarItems.items[index].icon,
                                color: AppColors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          const SpaceH4(),
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(
                                Strings.SHOP.tr,
                                style: context.bodyMedium,
                              ),
                            ),
                          ),
                          const SpaceH8(),
                        ],
                      ),
                    )
                  : GetBuilder<DashboardController>(
                      id: "bottom_nav_bar",
                      builder: (_) => _buildNavbarItem(
                        context,
                        controller.navbarItems.items[index],
                        color: controller.navbarItems.currentRouteIndex == index
                            ? AppColors.primaryColor
                            : AppColors.black,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavbarItem(
    BuildContext context,
    NavbarDataModel item, {
    Color color = AppColors.black,
  }) {
    return GestureDetector(
      onTap: () => item.onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          item.icon is IconData
              ? Icon(item.icon as IconData, color: color, size: 25)
              : ImageService.image(item.icon, imageSize: 25),
          SizedBox(
              width: 90,
              child: Center(
                  child: Text(item.title.tr,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: context.bodyMedium
                          .copyWith(color: color, fontSize: 14)))),
          const SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: 150.0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Image.asset(Assets.LOGO),
      ),
      actions: [
        InkWell(
          onTap: () => Get.toNamed(Routes.CART),
          child: Stack(children: [
            SizedBox(
              width: 50,
              child: Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.black.withOpacity(0.9),
                size: 35.0,
              ),
            ),
            Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: CircleAvatar(
                  radius: 11.0,
                  backgroundColor: Colors.red,
                  child: Obx(
                    () => Center(
                      child: Text(
                        controller.cartItems.length.toString(),
                        style: Get.context!.bodyMedium
                            .copyWith(color: AppColors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
        const SpaceW4(),
        InkWell(
          onTap: () => Get.toNamed(Routes.SEARCH_PRODUCT),
          child: const Icon(
            EneftyIcons.search_normal_outline,
            color: AppColors.black,
            size: 35.0,
          ),
        ),
        const SpaceW10(),
        GestureDetector(
          onTap: () => controller.onMenuTap(),
          child: const Icon(
            Icons.menu,
            color: AppColors.black,
            size: 35.0,
          ),
        ),
        const SpaceW10(),
      ],
    );
  }
}
