import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_state.dart';
import 'package:carnova_user/modals/all_vehicle_list_modal.dart';
import 'package:carnova_user/resources/components/searched_title.dart';
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
  List<Vehicle2> filterdList = [];
  bool filteringOn = false;
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: BlocListener<VehicleCheckBloc, VehicleCheckState>(
                        listener: (context, state) {
                          if (state is FilteredList) {
                            filterdList = state.allVehicles;
                          }
                        },
                        child: MyTextField(
                            onChanged: (p0) {
                              if (filteringOn) {
                                context.read<VehicleCheckBloc>().add(
                                    VehicleSearchEvent(
                                        text: p0, datas: filterdList));
                              } else {
                                context.read<VehicleCheckBloc>().add(
                                    VehicleSearchEvent(text: p0, datas: datas));
                              }
                            },
                            isPassword: false,
                            validation: (value) => null,
                            controller: searchController,
                            hintText: "Search Vehicle",
                            obscureText: false),
                      ),
                    ),
                  ),
                  BlocListener<VehicleCheckBloc, VehicleCheckState>(
                    listener: (context, state) {},
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  height: media.height / 2,
                                  color: appbarColorU,
                                  child: Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          filteringOn = true;
                                          context.read<VehicleCheckBloc>().add(
                                              FilteringEventFromAllVehicles(
                                                  datas: datas, brand: "BMW"));
                                        },
                                        child: const Text("Filter The list")),
                                  ),
                                ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: SvgPicture.asset(
                          "assets/svg/filter-svgrepo-com.svg",
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              BlocBuilder<VehicleCheckBloc, VehicleCheckState>(
                builder: (context, state) {
                  if (state is SearchedList) {
                    searchedList = state.allVehicles;
                  } else if (state is FilteredList) {
                    filterdList = state.allVehicles;
                  }
                  if (filteringOn) {
                    searchedList = filterdList;
                  }
                  return searchedList.isEmpty
                      ? SizedBox(
                          height: media.height / 2.5,
                          width: media.width / 1.5,
                          child: SvgPicture.asset(
                              "assets/svg/Car rental-amico (1).svg"),
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final vehicle = searchedList[index];
                            return SearchTileWid(data: vehicle);
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: searchedList.length);
                },
              )
            ]),
          )),
    );
  }
}
