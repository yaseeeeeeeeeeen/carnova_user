import 'package:flutter/material.dart';
import 'package:carnova_user/utils/appbar.dart';

class FindVehicleU extends StatelessWidget {
  const FindVehicleU({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarU(context),
      body: Container(color: Colors.red));
  }
}