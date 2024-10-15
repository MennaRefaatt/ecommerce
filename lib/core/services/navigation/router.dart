import 'package:ecommerce/features/authentication/register/presentation/screen/register_screen.dart';
import 'package:ecommerce/features/ecommerce/search/presentation/screen/search_screen.dart';
import 'package:ecommerce/features/test.dart';
import 'package:ecommerce/features/user/chat/presentation/screen/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../features/authentication/login/presentation/screen/login_screen.dart';

import '../../../features/ecommerce/home/presentation/screen/home_screen.dart';
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
      AppEndpoints.splash,
      child: (context) => const Test(),
    );
    r.child(
      AppEndpoints.register,
      child: (context) => RegisterScreen(),
    );
    r.child(
      AppEndpoints.homeScreen,
      child: (context) => const HomeScreen(),
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

    // r.child(AppEndpoints.specializationDetails,
    //     child: (context) {
    //   ///TODO: Add args
    //       final args = r.args.data ;
    //       safePrint("args = $args");
    //       return SpecialtyDoctors(index: args,);
    //     },);
  }

  static void init() {}
}
