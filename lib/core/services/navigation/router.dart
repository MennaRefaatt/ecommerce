import 'package:ecommerce/features/authentication/register/presentation/screen/register_screen.dart';
import 'package:ecommerce/features/ecommerce/address/presentation/screens/add_address_screen/screen/add_address_screen.dart';
import 'package:ecommerce/features/ecommerce/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce/features/ecommerce/categories/presentation/screens/categories_screen.dart';
import 'package:ecommerce/features/ecommerce/category_details/category_details_args.dart';
import 'package:ecommerce/features/ecommerce/category_details/presentation/screens/category_details_screen.dart';
import 'package:ecommerce/features/ecommerce/confirm_order/presentation/screens/confirm_order_screen.dart';
import 'package:ecommerce/features/ecommerce/favorite/presentation/manager/favourite_cubit.dart';
import 'package:ecommerce/features/ecommerce/favorite/presentation/screens/favorite_screen.dart';
import 'package:ecommerce/features/ecommerce/home/presentation/screen/home_screen.dart';
import 'package:ecommerce/features/ecommerce/maps/presentation/screen/map_screen.dart';
import 'package:ecommerce/features/ecommerce/order/order_details/presentation/screens/order_details_screen.dart';
import 'package:ecommerce/features/ecommerce/order/order_placed/presentation/screen/order_placed_screen.dart';
import 'package:ecommerce/features/ecommerce/order/orders/presentation/screen/orders_screen.dart';
import 'package:ecommerce/features/ecommerce/search/presentation/screen/search_screen.dart';
import 'package:ecommerce/features/splash/splash.dart';
import 'package:ecommerce/features/user/chat/presentation/screen/chat_screen.dart';
import 'package:ecommerce/features/user/settings/complaints_screen/presentation/screen/complaints_screen.dart';
import 'package:ecommerce/features/user/settings/contact_us_screen/presentation/screen/contact_us_screen.dart';
import 'package:ecommerce/features/user/settings/fAQs_screen/presentation/screen/f_a_q_s_screen.dart';
import 'package:ecommerce/features/user/settings/terms_and_conditions_screen/presentation/screen/terms_and_conditions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../features/authentication/login/presentation/screen/login_screen.dart';
import '../../../features/ecommerce/address/presentation/screens/address_screen.dart';
import '../../../features/ecommerce/maps/presentation/manager/location_cubit.dart';
import '../../../features/ecommerce/order/order_details/order_details_args.dart';
import '../../../features/ecommerce/product_details/presentation/screens/product_details_screen.dart';
import '../../../features/ecommerce/product_details/product_details_args.dart';
import '../../../features/ecommerce/suggested_products/presentation/screen/suggested_products_screen.dart';
import '../../../features/ecommerce/suggested_products/suggested_products_args.dart';
import '../../../features/user/settings/profile_screen/presentation/screens/change_password/view/screens/change_password_screen.dart';
import '../../../features/user/settings/profile_screen/presentation/screens/profile_screen.dart';
import '../../../features/user/settings/profile_screen/presentation/screens/update_account/view/screens/update_account_screen.dart';
import '../../../features/user/settings/settings_screen/presentation/screens/settings_screen.dart';
import '../../di/di.dart';
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
      child: (context) {
        return BlocProvider(
            create: (context) => LocationCubit(sl(), sl(), sl()),
            child: const MapScreen());
      },
    );
    r.child(
      AppEndpoints.splash,
      child: (context) => const Splash(),
    );
    r.child(
      AppEndpoints.register,
      child: (context) => RegisterScreen(),
    );
    r.child(
      AppEndpoints.suggestedProductsScreen,
      child: (context) {
        final args = Modular.args.data as SuggestedProductsArgs;
        return BlocProvider(
          create: (context) => FavouriteCubit(sl())..getFavouriteData(),
          child: SuggestedProductsScreen(args: args),
        );
      },
    );

    r.child(
      AppEndpoints.settingsScreen,
      child: (context) => const SettingsScreen(),
    );
    r.child(
      AppEndpoints.categoriesScreen,
      child: (context) => const CategoriesScreen(),
    );
    r.child(
      AppEndpoints.addressScreen,
      child: (context) => AddressScreen(),
    );
    r.child(
      AppEndpoints.orderPlacedScreen,
      child: (context) {
       // final id = Modular.args.data;
        return OrderPlacedScreen(id: 4648);
      },
    );
    r.child(
      AppEndpoints.ordersScreen,
      child: (context) => const OrdersScreen(),
    );
    r.child(
      AppEndpoints.orderDetailsScreen,
      child: (context) {
        final orderDetailsArgs = Modular.args.data as OrderDetailsArgs;
        return OrderDetailsScreen(orderDetailsArgs: orderDetailsArgs);
      },
    );

    r.child(
      AppEndpoints.confirmOrderScreen,
      child: (context) => const ConfirmOrderScreen(),
    );
    r.child(
      AppEndpoints.addAddressScreen,
      child: (context) => AddAddressScreen(),
    );
    r.child(
      AppEndpoints.productDetailsScreen,
      child: (context) {
        final args = Modular.args.data as ProductDetailsArgs;
        return ProductDetailsScreen(
          args: args,
        );
      },
    );
    r.child(
      AppEndpoints.categoryDetailsScreen,
      child: (context) {
        final args = Modular.args.data as CategoryDetailsArgs;
        return CategoryDetailsScreen(
          args: args,
        );
      },
    );
    r.child(
      AppEndpoints.cartScreen,
      child: (context) => CartScreen(),
    );
    r.child(
      AppEndpoints.homeScreen,
      child: (context) => const HomeScreen(),
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
      child: (context) {
        return BlocProvider(
            create: (context) => FavouriteCubit(sl())..getFavouriteData(),
            child: const FavoriteScreen());
      },
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
