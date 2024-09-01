import 'package:moyen_express/view_model/controllers/my_account/my_account_controller.dart';

import '../../../resources/exports/index.dart';

class AccountDrawer extends GetView<MyAccountController> {
  final List<FullDrawerModel> items;

  const AccountDrawer({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: Get.width * 0.8,
      padding: const EdgeInsets.all(16.0),
      color: AppColors.primaryColor,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SpaceH16(),
              const CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 40,
                backgroundImage: NetworkImage(
                    "https://moyenxpress.com/public/assets/img/avatar-place.png"),
              ),
              Center(
                child: Text(AuthManager.instance.user?.fullName ?? "",
                    style: context.bodyMedium
                        .copyWith(color: AppColors.white, fontSize: 18)),
              ),
              Center(
                child: Text(AuthManager.instance.user?.emailAddress ?? "",
                    style: context.bodyMedium
                        .copyWith(color: AppColors.white, fontSize: 18)),
              ),
              ListView.separated(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () => items[index].onTap(),
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: AppColors.drawerIconBackground,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow,
                                offset: const Offset(0.0, 8.0),
                                blurRadius: 7.0,
                              ),
                            ],
                          ),
                          child:
                              ImageService.image(items[index].icon, scale: 1.8),
                        ),
                        const SpaceW20(),
                        Text(
                          items[index].title.tr,
                          style:
                              context.titleLarge.copyWith(color: AppColors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ).expanded()
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SpaceH20(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
