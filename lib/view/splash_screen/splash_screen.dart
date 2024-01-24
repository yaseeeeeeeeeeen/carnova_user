import 'package:carnova_user/blocs/login/login_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/repositories/booking_repo.dart';
import 'package:carnova_user/repositories/user_repo.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:carnova_user/view/login_signup/login_page.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    await Future.delayed(const Duration(seconds: 1));

    final token = SharedPref.instance.getToke();

    if (token != null) {
      final response = await UserRepo().fetchUserData();
      response.fold((left) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      }, (right) {
        final data1 = UserModal.fromJson(right);
        locator<LoginBloc>().logedUser = data1;
        fetchUserBookings(context);
      });
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }

  fetchUserBookings(context) async {
    final userBooking = await BookingRepo().userBookings();
    userBooking.fold((left) {
      locator<VehicleCheckBloc>().bookedVehicles = [];
      locator<VehicleCheckBloc>().allBookedVehicles = [];
      locator<VehicleCheckBloc>().activeVehicles = [];
    }, (right) {
      DateTime currentDate = DateTime.now();
      DateFormat('yyyy-MM-dd').format(currentDate);
      final List vehicleList = right as List;
      final datas = vehicleList.map((e) => BookedVehicle.fromJson(e)).toList();
      locator<VehicleCheckBloc>().allBookedVehicles = datas;
      //////////////////// DIVIED BOOKED AND NOT BOOKED////////////////////////////////
      final bookedonly = datas.where((element) {
        final endDate = DateTime.parse(element.endDate);
        return endDate.isBefore(currentDate) && element.status == "Booked";
      }).toList();
      locator<VehicleCheckBloc>().bookedVehicles = bookedonly;
      ////////////////// ACTIVE VEHICLE SORTING/////////////////////////////////
      locator<VehicleCheckBloc>().activeVehicles = datas.where((element) {
        final startDate = DateTime.parse(element.startDate);
        final endDate = DateTime.parse(element.endDate);
        return startDate.isBefore(currentDate) &&
                endDate.isAfter(currentDate) && element.status == "Booked";
      }).toList();
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CustomNavBar()),
        (route) => false);
  }
}
