import '../resources/exports/index.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageUrl;
  final XFile? imageFile;
  final BoxFit? fit;
  final double? borderRadius;
  final double imageSize;
  final double? imageWidth;

  const CustomImageWidget({
    Key? key,
    required this.imageUrl,
    this.imageFile,
    this.fit,
    this.borderRadius,
    this.imageSize = Sizes.ICON_SIZE_50 + 20,
    this.imageWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 90),
      child: imageFile != null
          ? _buildFileImage()
          : SizedBox(
              height: imageSize,
              width: imageWidth ?? imageSize,
              child: imageUrl.isNotEmpty &&
                      imageUrl !=
                          "https://moyenxpress.com/public/uploads/placeholder.png"
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => _buildPlaceHolder(),
                      errorWidget: (context, url, error) => _buildErrorWidget(),
                      fit: fit ?? BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl:
                          "https://moyenxpress.com/public/uploads/placeholder.png",
                      placeholder: (context, url) => _buildPlaceHolder(),
                      errorWidget: (context, url, error) => _buildErrorWidget(),
                      fit: BoxFit.cover,
                    ),
            ),
    );
  }

  Container _buildErrorWidget() {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Icon(
        Icons.image,
        color: AppColors.iconGrey,
        size: imageSize,
      ),
    );
  }

  Widget _buildPlaceHolder() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
    ).shimmerWidget;
  }

  Widget _buildFileImage() {
    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: Image.file(
        key: ValueKey(GlobalHelper.getRandomId()),
        File(imageFile!.path),
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, _, __) => _buildPlaceHolder(),
      ),
    );
  }
}
