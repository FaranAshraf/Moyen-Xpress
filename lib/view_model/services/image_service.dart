import '../../resources/exports/index.dart';

class ImageService {
  static Widget image(
    dynamic image, {
    double? borderRadius,
    double? imageSize,
    double? imageWidth,
    Color? imageColor,
    BoxFit fit = BoxFit.cover,
    double? scale,
  }) {
    if (image is IconData) {
      return Icon(image, color: imageColor ?? AppColors.white, size: imageSize);
    } else if (image.isEmpty ||
        image.contains("http") ||
        image.contains("https")) {
      return CustomImageWidget(
        imageUrl: image,
        borderRadius: borderRadius,
        imageSize: imageSize ?? 70,
        imageWidth: imageWidth,
      );
    } else {
      return Image.asset(
        image ?? Assets.HOME_SLIDER,
        color: imageColor,
        fit: scale != null ? null : fit,
        scale: scale,
      );
    }
  }
}
