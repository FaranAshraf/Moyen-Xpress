import '../../../resources/exports/index.dart';

class NotificationsShimmer extends StatelessWidget {
  const NotificationsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildNotification());
  }

  Widget _buildNotification() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) {
        return _buildNotificationCard();
      },
      separatorBuilder: (_, __) => const SpaceH16(),
    );
  }

  Container _buildNotificationCard() {
    return Container(
      width: Get.width,
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
        children: [
          Row(
            children: [
              ImageService.image(
                EneftyIcons.notification_bing_outline,
              ).shimmerWidget,
              const SpaceW10(),
              RichTitlePlaceholder(
                linesCount: 5,
                width: Get.width - 170,
                height: 10,
              ).shimmerWidget,
              const SpaceW10(),
              const TitlePlaceholder(width: 100, linesCount: 1, height: 10)
                  .shimmerWidget
            ],
          ),
        ],
      ),
    );
  }
}
