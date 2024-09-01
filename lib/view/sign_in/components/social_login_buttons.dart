import '../../../resources/exports/index.dart';

class SocialLoginButtons extends StatelessWidget {
  final List<SocialLogin> socialLoginBtns;
  const SocialLoginButtons({Key? key, required this.socialLoginBtns})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: socialLoginBtns.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildSocialButtons(socialLoginBtns[index]);
        },
        separatorBuilder: (_, __) => const SpaceW20(),
      ),
    );
  }

  Container _buildSocialButtons(SocialLogin item) {
    return Container(
      height: 80.0,
      width: 80.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
            offset: const Offset(0.0, 4.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: GestureDetector(onTap: item.onTap, child: Image.asset(item.icon)),
    );
  }
}
