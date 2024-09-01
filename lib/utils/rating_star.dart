import '../resources/exports/index.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double? rating;
  final RatingChangeCallback? onRatingChanged;
  final Color color;
  final double iconSize;
  final MainAxisAlignment? alignment;

  const StarRating({
    super.key,
    this.starCount = 5,
     this.rating,
    this.onRatingChanged,
    this.color = AppColors.primaryColor,
    this.alignment,
    this.iconSize = Sizes.ICON_SIZE_24,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating!) {
      icon = Icon(Icons.star_border, color: color, size: iconSize);
    } else if (index > rating! - 1 && index < rating!) {
      icon = Icon(Icons.star_half, color: color, size: iconSize);
    } else {
      icon = Icon(Icons.star, color: color, size: iconSize);
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment ?? MainAxisAlignment.center,
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
