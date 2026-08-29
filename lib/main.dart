import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Core/AppRoute/app_route.dart';
import 'Core/Dependency/dependency.dart';
import 'Language/translator.dart';
import 'Utils/AppConst/app_const.dart';
import 'global/theme/light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: AppConst.appName,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          translations: AppLanguages(),
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          initialRoute: AppRoute.loadingScreen,
          getPages: AppRoute.routes,
        );
      },
    );
  }
}
