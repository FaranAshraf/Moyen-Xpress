import 'package:moyen_express/repository/notification_repository.dart';

import '../../resources/exports/index.dart';

class Notifications extends GetView<NotificationsController> {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller=Get.put(NotificationsController());
    return Scaffold(
      body: CustomFutureBuilder(
        customLoader: const NotificationsShimmer(),
        data: (notifications) => controller.notifications = notifications ?? [],
        future: NotificationRepository.getNotifications(),
        hasDataBuilder: (_, __) => _buildNotification(),
      ),
    );
  }

  Widget _buildNotification() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: controller.notifications.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildNotificationCard(context, controller.notifications[index]);
      },
      separatorBuilder: (_, __) => const SpaceH16(),
    );
  }

   _buildNotificationCard(
    BuildContext context,
    NotificationsModel notification,
  ) {
    return GestureDetector(

      onTap:()=> notification.type == 0?Get.toNamed(Routes.PURCHASE_HISTORY):null,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              offset: const Offset(0.0, 0.0),
              blurRadius: 8.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                notification.dateTime ?? "-",
                style: context.labelMedium.copyWith(
                  color: AppColors.timeGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                ImageService.image(
                  controller.getIcon(notification.type ?? -1),
                  imageColor: AppColors.primaryColor,
                  scale: 1.5,
                ),
                const SpaceW10(),
                RichText(
                  text: TextSpan(
                    text: notification.message ?? "-",
                    style: context.titleSmall,
                    children: [
                      if (notification.type == 0) ...[
                        TextSpan(
                          text: " #${notification.orderId ?? "-"}",
                          style: context.titleMedium.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ).expanded(),
                const SpaceW10(),
              ],
            ),
            const SpaceH12(),
            if (notification.type == 1) ...[
              CustomButton.solid(
                backgroundColor: AppColors.primaryColor,
                text: Strings.PURCHASE_NOW.tr,
                textStyle: context.labelSmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.0,
                ),
                onTap: Get.back,
                radius: Sizes.RADIUS_6,
              ).constrainedBox(maxWidth: 100.0, maxHeight: 30),
            ],
          ],
        ),
      ),
    );
  }
}
