import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_state.dart';
import 'package:carnova_user/modals/all_vehicle_list_modal.dart';
import 'package:carnova_user/resources/components/car_show_screen/list_empty_svg.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllVehiclesList extends StatelessWidget {
  AllVehiclesList({super.key, required this.datas});
  List<Vehicle2> datas;
  List<Vehicle2> searchedList = [];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    searchedList = datas;
    return Scaffold(
      appBar: customAppBarText("ALL VEHICLES", context, () {
        Navigator.of(context).pop();
      }),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            GestureDetector(
              child: BlocListener<VehicleCheckBloc, VehicleCheckState>(
                listener: (context, state) {},
                child: MyTextField(
                    onChanged: (p0) {
                      context
                          .read<VehicleCheckBloc>()
                          .add(VehicleSearchEvent(text: p0, datas: datas));
                    },
                    isPassword: false,
                    validation: (value) => null,
                    controller: searchController,
                    hintText: "Search Vehicle",
                    obscureText: false),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<VehicleCheckBloc, VehicleCheckState>(
              builder: (context, state) {
                if (state is SearchedList) {
                  searchedList = state.allVehicles;
                }
                return searchedList.isEmpty
                    ? SizedBox(
                        height: media.height / 2.5,
                        width: media.width / 1.5,
                        child: SvgPicture.asset(
                            "assets/svg/Car rental-amico (1).svg"),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final vehicle = searchedList[index];
                          return Container(
                              height: 30,
                              width: double.infinity,
                              color: Colors.amberAccent,
                              child: Center(child: Text(vehicle.name)));
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: searchedList.length);
              },
            )
          ])),
    );
  }
}
