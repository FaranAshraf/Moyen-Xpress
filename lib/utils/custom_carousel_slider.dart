import '../resources/exports/index.dart';
import '../dummy/slider_data.dart';

class CustomCarouselSlider extends StatefulWidget {
  final String? apiUrl;
  final List<CustomCarouselModel>? banners;
  final bool isLoading;

  const CustomCarouselSlider({
    super.key,
    this.apiUrl,
    this.banners,
    this.isLoading = true,
  });

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  static BaseApiServices baseApiService = NetworkApiServices();
  List<CustomCarouselModel> data = [];

  int selectedIndex = 0;

  Future<void> sliderData() async {
    if (widget.apiUrl == null || widget.apiUrl!.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => data = CustomCarouselModel.listFromJson(bannerData));
    } else {
      var apiResponse = await baseApiService.getApi(widget.apiUrl!);
      if (apiResponse is bool) return;
      setState(() => CustomCarouselModel.listFromJson(bannerData));
    }
  }

  void updateIndicatorIndex(int index) => setState(() => selectedIndex = index);

  @override
  void didUpdateWidget(covariant CustomCarouselSlider oldWidget) {
    if (widget.banners != null) {
      setState(() => data = widget.banners ?? []);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    if (widget.banners != null) {
      setState(() => data = widget.banners ?? []);
    } else {
      sliderData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 11.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ).shimmerWidget
        : Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  onPageChanged: (val, _) => updateIndicatorIndex(val),
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  aspectRatio: 1,
                  enlargeCenterPage: true,
                  viewportFraction: 0.96,
                ),
                items: data
                    .map(
                      (val) => SizedBox(
                        width: double.maxFinite,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: ImageService.image(
                            val.image ?? "",
                            borderRadius: 0.0,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SpaceH20(),
              AnimatedSmoothIndicator(
                activeIndex: selectedIndex,
                count: data.length,
                axisDirection: Axis.horizontal,
                effect: const ExpandingDotsEffect(
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 6.0,
                  dotHeight: 6.0,
                  dotColor: Colors.grey,
                  activeDotColor: AppColors.primaryColor,
                ),
              ),
            ],
          );
  }
}
