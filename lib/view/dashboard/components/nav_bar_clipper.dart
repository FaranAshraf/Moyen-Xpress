import '../../../resources/exports/index.dart';

class NavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..moveTo(0, 40)
      ..lineTo((size.width * 0.5) - 38.0, 38)
      ..arcToPoint(
        Offset((size.width * 0.5) + 32.0, 38),
        clockwise: true,
        radius: const Radius.circular(30.0),
      )
      ..lineTo(size.width, 40)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..moveTo(0, 0);

    path.fillType = PathFillType.evenOdd;
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}
