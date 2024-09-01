import '../../../resources/exports/index.dart';

class MyDrawer extends StatelessWidget {
  final List<DrawerModel> items;

  const MyDrawer({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
  height: double.maxFinite,
  width: Get.width * 0.8,
  padding: const EdgeInsets.all(16.0),
  color: AppColors.primaryColor,
  child: Center(
    child: ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
                child: ImageService.image(items[index].icon, scale: 1.8),
              ),
              const SpaceW20(),
              Expanded(
                child: Text(
                  items[index].title.tr,
                  style: context.titleLarge.copyWith(color: AppColors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => const SpaceH20(),
    ),
  ),
);

  }
}
