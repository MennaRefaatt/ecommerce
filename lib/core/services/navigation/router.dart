import 'package:ecommerce/features/authentication/register/presentation/screen/register_screen.dart';
import 'package:ecommerce/features/ecommerce/favorite/presentation/screens/favorite_screen.dart';
import 'package:ecommerce/features/ecommerce/home/presentation/screen/home_screen.dart';
import 'package:ecommerce/features/ecommerce/maps/presentation/screen/map_screen.dart';
import 'package:ecommerce/features/ecommerce/search/presentation/screen/search_screen.dart';
import 'package:ecommerce/features/test.dart';
import 'package:ecommerce/features/user/chat/presentation/screen/chat_screen.dart';
import 'package:ecommerce/features/user/settings/complaints_screen/presentation/view/screens/complaints_screen.dart';
import 'package:ecommerce/features/user/settings/contact_us_screen/view/screens/contact_us_screen.dart';
import 'package:ecommerce/features/user/settings/fAQs_screen/view/screens/f_a_q_s_screen.dart';
import 'package:ecommerce/features/user/settings/profile_screen/view/screens/change_password/view/screens/change_password_screen.dart';
import 'package:ecommerce/features/user/settings/profile_screen/view/screens/profile_screen.dart';
import 'package:ecommerce/features/user/settings/profile_screen/view/screens/update_account/view/screens/update_account_screen.dart';
import 'package:ecommerce/features/user/settings/settings_screen/view/screens/settings_screen.dart';
import 'package:ecommerce/features/user/settings/terms_and_conditions_screen/view/screens/terms_and_conditions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../features/authentication/login/presentation/screen/login_screen.dart';
import '../../../features/ecommerce/suggested_products/presentation/screen/suggested_products_screen.dart';
import '../../../features/ecommerce/suggested_products/suggested_products_args.dart';
import 'app_endpoints.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      AppEndpoints.login,
      child: (context) => LoginScreen(),
    );
    r.child(
      AppEndpoints.chatScreen,
      child: (context) => const ChatScreen(),
    );
    r.child(
      AppEndpoints.mapsLocation,
      child: (context) => const MapScreen(),
    );
    r.child(
      AppEndpoints.splash,
      child: (context) => const Test(),
    );
    r.child(
      AppEndpoints.register,
      child: (context) => RegisterScreen(),
    );
    r.child(
      AppEndpoints.suggestedProductsScreen,
      child: (context) {
        final args = SuggestedProductsArgs(products: []);
        return SuggestedProductsScreen(args:args);
      },
    );
    r.child(
      AppEndpoints.settingsScreen,
      child: (context) => const SettingsScreen(),
    );
    r.child(
      AppEndpoints.homeScreen,
      child: (context) =>  const HomeScreen(),
    );

    r.child(
      AppEndpoints.complaintsScreen,
      child: (context) => ComplaintsScreen(),
    );
    r.child(
      AppEndpoints.contactUsScreen,
      child: (context) => ContactUsScreen(),
    );
    r.child(
      AppEndpoints.termsAndConditionsScreen,
      child: (context) => TermsAndConditionsScreen(),
    );
    r.child(
      AppEndpoints.profileScreen,
      child: (context) => const ProfileScreen(),
    );
    r.child(
      AppEndpoints.updateAccountScreen,
      child: (context) => UpdateAccountScreen(),
    );
    r.child(
      AppEndpoints.fAQsScreen,
      child: (context) => FAQsScreen(),
    );
    r.child(
      AppEndpoints.changePassword,
      child: (context) => const ChangePasswordScreen(),
    );

    r.child(
      AppEndpoints.favoriteScreen,
      child: (context) =>  const FavoriteScreen(),
    );

    r.child(
      AppEndpoints.searchScreen,
      child: (context) => SearchScreen(),
      transition: TransitionType.custom,
      customTransition: CustomTransition(
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation, // Fade effect
            child: child,
          );
        },
        transitionDuration:
            const Duration(milliseconds: 500), // Customize duration
      ),
    );

  }

  static void init() {}
}
