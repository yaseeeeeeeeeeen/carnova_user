import 'package:carnova_user/blocs/login/login_bloc.dart';
import 'package:carnova_user/blocs/otp/otp_bloc.dart';
import 'package:carnova_user/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:carnova_user/blocs/signup/signup_bloc.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/view/login_signup/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileEditBloc()),
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => OtpBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
