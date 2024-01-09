import 'package:carnova_user/utils/appbar.dart';
import 'package:flutter/material.dart';

class AllVehiclesList extends StatelessWidget {
  const AllVehiclesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarText("ALL VEHICLES", context, () {
        Navigator.of(context).pop();
      }),
      body: Container(color: Colors.amber),
    );
  }
}
