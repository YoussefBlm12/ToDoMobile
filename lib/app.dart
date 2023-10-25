

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/themes/light_theme.dart';
import 'package:todo/themes/theme_services.dart';
import 'core/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode:  ThemeServices().theme,
      initialRoute: '/home',
      getPages: routes,

    );
  }
}