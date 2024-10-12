import 'package:flutter_modular/flutter_modular.dart';
import 'app_endpoints.dart';

class AppNavigationUtils {
  static void pushReplacementNamed(String route) {
    Modular.to.pushNamedAndRemoveUntil(route, (route) => false);
  }

  static void pushAndClean(String route, {Object? arguments}) {
    AppNavigationUtils.pushNamed(route, arguments: arguments);
    Modular.to.navigateHistory.clear();
  }

  static Future<dynamic> pushNamed(String route, {Object? arguments}) async {
    // prevent same route
    if (Modular.to.path == route && Modular.to.path != '/') {
      return;
    }

    await Modular.to.pushNamed(route, arguments: arguments);
  }

  static Future<void> pushNamedSameRouteOk(String route, {Object? arguments}) async {
    await Modular.to.pushNamed(route, arguments: arguments);
  }

  static void pop([dynamic result]) {
    if (Modular.to.canPop()) {
      Modular.to.pop(result);
    } else {
      Modular.to.navigate(AppEndpoints.homeScreen);
    }
  }
}
