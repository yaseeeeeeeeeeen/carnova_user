import 'dart:convert';

import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/repositories/userdata_repo.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:carnova_user/view/login_signup/login_page.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loginCheck(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imageU.applogoBlack), fit: BoxFit.cover)),
        height: 200,
        width: 300,
      )),
    );
  }

  loginCheck(context) async {
    await Future.delayed(const Duration(seconds: 2));

    final token = SharedPreference.instance.getToken();

    if (token != null) {
      final response = await UserDataRepo().userData(token);
      final data = jsonDecode(response.body);
      print(data);
      if (data != null) {
        final data1 = UserModal.fromJson(data);
        logedUser = data1;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CustomNavBar()),
            (route) => false);
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }
}
