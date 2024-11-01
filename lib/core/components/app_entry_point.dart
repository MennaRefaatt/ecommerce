import 'package:device_preview/device_preview.dart';
import 'package:ecommerce/core/cubits/language/language_cubit.dart';
import 'package:ecommerce/core/helpers/shared_pref.dart';
import 'package:ecommerce/core/theming/theming_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toastification/toastification.dart';
import '../services/navigation/router.dart';
import '../theming/app_theme.dart';
import '../theming/theming_manager.dart';

class AppEntryPoint extends StatefulWidget {
  final String initialRoute;

  const AppEntryPoint({super.key, required this.initialRoute});

  @override
  State<AppEntryPoint> createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  //final ThemeManager _themeManager =ThemeManager();
  @override
  void initState() {
    super.initState();
    //_themeManager.init();
  }

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      builder: (context) =>
          ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            enableScaleText: () => false,
            enableScaleWH: () => false,
            builder: (BuildContext context, Widget? child) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ThemeCubit(),
                  ),
                  BlocProvider(
                    create: (context) =>LanguageCubit(),
                  ),
                ],
                child: BlocBuilder<ThemeCubit, ThemeData>(
                    builder: (context, theme) {
                      return ModularApp(
                        module: AppModule(),
                        child: LocalizedApp(
                          child: ToastificationWrapper(
                            config: const ToastificationConfig(
                              alignment: Alignment.topCenter,
                            ),
                            child: MaterialApp.router(
                              title: 'ecommerce',
                              key: ValueKey(SharedPref.getCurrentLanguage()),
                              locale: Locale(SharedPref.getCurrentLanguage()),
                              debugShowCheckedModeBanner: false,
                              routeInformationParser: Modular
                                  .routeInformationParser,
                              routerDelegate: Modular.routerDelegate,
                              theme: theme,
                              themeMode: ThemeMode.system,
                              builder: (context, child) {
                                AppModule.init();
                                child ??= const SizedBox.shrink();
                                return EasyLoading.init()(context, child);
                              },
                            ),
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
    );
  }
}
