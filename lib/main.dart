import 'package:flutter/material.dart';
import 'package:walletwise_app/shared/theme.dart';
import 'package:walletwise_app/ui/pages/sign_in_page.dart';
import 'package:walletwise_app/ui/pages/sign_up_page.dart';
import 'package:walletwise_app/ui/pages/splash_screen.dart';
import 'package:walletwise_app/ui/pages/menu_page.dart';
import 'package:walletwise_app/ui/pages/add_financial_page.dart';
import 'package:walletwise_app/ui/pages/profile_page.dart';
import 'package:walletwise_app/ui/pages/avatar_page.dart';
import 'package:walletwise_app/bottombar/custom_bottom_navigation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: lightBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: lightBackgroundColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: blackColor),
          titleTextStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/bottom-bar': (context) => CustomBottomNavigation(),
        '/menu': (context) => const MenuPage(),
        '/add': (context) => const AddFinancialPage(),
        '/profile': (context) => const ProfilePage(),
        '/avatar': (context) => const AvatarPage(),
      },
    );
  }
}
