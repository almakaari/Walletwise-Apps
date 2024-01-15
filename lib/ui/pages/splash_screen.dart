import 'dart:async';
import 'package:flutter/material.dart';
import 'package:walletwise_app/shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/sign-in',
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Container(
          width: 164,
          height: 164,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/walletwise3.png')),
          ),
        ),
      ),
    );
  }
}
