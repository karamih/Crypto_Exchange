import 'package:exchange/providers/cryptoDataProvider.dart';
import 'package:exchange/providers/themeSwitcherProvider.dart';
import 'package:exchange/ui/pages/SignUpPage.dart';
import 'package:exchange/ui/pages/homePage.dart';
import 'package:exchange/ui/pages/mainWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'utilities/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeSwitcherProvider()),
      ChangeNotifierProvider(create: (context) => CryptoDataProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeSwitcherProvider>(
      builder: (context, themeSwitcherProvider, child) {
        return MaterialApp(
          themeMode: themeSwitcherProvider.themeMode,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          debugShowCheckedModeBanner: false,
          home: const SignUpPage(),
          routes: {

          },
        );
      },
    );
  }
}
