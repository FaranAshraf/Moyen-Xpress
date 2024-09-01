import '../resources/exports/index.dart';

class CountDownTimer extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final bool showSeeAll;
  final DateTime? duration;
  final VoidCallback? onTap;
  const CountDownTimer({
    Key? key,
    this.title,
    this.showSeeAll = true,
    this.duration,
    this.onTap,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null) ...[
          Text(Strings.FLASH_DEALS.tr, style: context.headlineSmall),
        ],
        if (subTitle != null) ...[
          Text(
            "${Strings.UP_TO.tr} $subTitle% ${Strings.OFF.tr}",
            style: context.headlineMedium.copyWith(
              color: AppColors.primaryColor,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceH12(),
        ],
        Stack(
          children: [
            Center(
              child: SlideCountdownSeparated(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      offset: const Offset(0.0, 3.0),
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                duration: duration?.difference(DateTime.now()) ??
                    const Duration(days: 1),
              ),
            ),
            if (showSeeAll) ...[
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: onTap ??
                      () => Get.toNamed(
                            Routes.FLASH_DEALS,
                            arguments: {
                              "duration": duration,
                              "discountPer":
                                  subTitle == null ? 0 : int.parse(subTitle!),
                            },
                          ),
                  child: Text(
                    Strings.SEE_ALL.tr,
                    style: context.titleMedium.copyWith(
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SpaceH12(),
      ],
    );
  }
}
