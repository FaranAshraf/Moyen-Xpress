import '../../resources/exports/index.dart';

class AuthenticationMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!AuthManager.instance.isLoggedIn) {
      return const RouteSettings(name: Routes.SIGN_IN);
    } else {
      return super.redirect(route);
    }
  }
}
