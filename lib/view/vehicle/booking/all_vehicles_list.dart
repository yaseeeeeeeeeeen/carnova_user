import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_state.dart';
import 'package:carnova_user/modals/all_vehicle_list_modal.dart';
import 'package:carnova_user/resources/components/searched_title.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carnova_user/view/vehicle/drop_down.dart';
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
  TextEditingController fuelController = TextEditingController();
  TextEditingController transmissionController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController seatController = TextEditingController();
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
                              if (filterdList.isNotEmpty) {
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
                            backgroundColor: scaffoldBg,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            context: context,
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      DropDownWid(
                                          listIndex: 0,
                                          controller: brandController,
                                          titletext: "Brand",
                                          hinttext: "Tap to Select a Brand"),
                                      DropDownWid(
                                          listIndex: 2,
                                          controller: fuelController,
                                          titletext: "Fueltype ",
                                          hinttext: "Tap to Select Fueltype"),
                                      DropDownWid(
                                          listIndex: 3,
                                          controller: seatController,
                                          titletext: "Seat Count",
                                          hinttext: "Tap to Select Seat Count"),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                fuelController.clear();
                                                brandController.clear();
                                                seatController.clear();
                                                context
                                                    .read<VehicleCheckBloc>()
                                                    .add(
                                                        FilterResetButtonClicked(
                                                            datas: datas));
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: appbarColorU,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  fixedSize: Size(
                                                      media.width / 2.2, 40)),
                                              child: const Text("RESET")),
                                          ElevatedButton(
                                              onPressed: () {
                                                int seatCount = seatController
                                                        .text.isEmpty
                                                    ? 0
                                                    : int.parse(
                                                        seatController.text);
                                                context.read<VehicleCheckBloc>().add(
                                                    FilteringEventFromAllVehicles(
                                                        ////price controller in here
                                                        priceRange: 4000,
                                                        datas: datas,
                                                        brand: brandController
                                                            .text,
                                                        seatCount: seatCount,
                                                        fuelType: fuelController
                                                            .text));
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  backgroundColor: appbarColorU,
                                                  fixedSize: Size(
                                                      media.width / 2.2, 40)),
                                              child: const Text("DONE")),
                                        ],
                                      )
                                    ],
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
