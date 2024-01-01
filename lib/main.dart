import 'package:carnova_user/blocs/login/login_bloc.dart';
import 'package:carnova_user/blocs/otp/otp_bloc.dart';
import 'package:carnova_user/blocs/password_settings/password_settings_bloc.dart';
import 'package:carnova_user/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:carnova_user/blocs/signup/signup_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/view/map_screen.dart';
import 'package:carnova_user/view/splash_screen/splash_screen.dart';
import 'package:carnova_user/view/vehicle_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.instance.initStorage();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileEditBloc()),
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => OtpBloc()),
        BlocProvider(create: (context) => VehicleCheckBloc()),
        BlocProvider(create: (context) => PasswordSettingsBloc())
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: SplashScreen()),
    );
  }
}
