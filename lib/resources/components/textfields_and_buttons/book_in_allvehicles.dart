// ignore_for_file: must_be_immutable

import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_state.dart';
import 'package:carnova_user/modals/all_vehicle_list_modal.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AllVehicleScreenBottom extends StatelessWidget {
  AllVehicleScreenBottom(
      {super.key, required this.price, required this.vehicle});
  String price;
  Vehicle2 vehicle;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime today = DateTime.now();
  String endDate = "";
  String startDate = "";
  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();
  String location = "";
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return BottomAppBar(
        child: Container(
      height: 80,
      color: appbarColorU.withOpacity(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("₹$price", style: style2),
                  Text("  Per Day",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: black.withOpacity(0.6)))
                ]),
          ),
          const SizedBox(width: 30),
          BlocListener<VehicleCheckBloc, VehicleCheckState>(
            listener: (context, state) {},
            child: ElevatedButton(
                onPressed: () {
                  context.read<VehicleCheckBloc>().add(DeffualtCalanderOpen());

                  showBottomSheet(
                      backgroundColor: scaffoldBg,
                      enableDrag: true,
                      context: context,
                      builder: (context) => Container(
                            padding: const EdgeInsets.all(15),
                            // color: appbarColorU.withOpacity(0.7),
                            child: BlocBuilder<VehicleCheckBloc,
                                VehicleCheckState>(
                              builder: (context, state) {
                                if (state is AllreadyThisVehicleHaveBooking) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: mainColorU,
                                      border: Border.all(color: borderSide),
                                    ),
                                    height: media.height / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "This Vehicle Avalible Have Already A Booking",
                                          style: cardtitle,
                                        ),
                                        MyLoadingButton(
                                            title: "Go Back",
                                            isLoading: false,
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    ),
                                  );
                                } else if (state
                                    is CheckVehicleAvalibleSuccess) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: mainColorU,
                                      border: Border.all(color: borderSide),
                                    ),
                                    height: media.height / 3,
                                    child: Column(
                                      children: [
                                        Text(
                                          "This Vehicle Avalible You can book",
                                          style: cardtitle,
                                        ),
                                        MyLoadingButton(
                                            title: "Book Now",
                                            isLoading: false,
                                            onTap: () {})
                                      ],
                                    ),
                                  );
                                } else if (state is DeffultCalanderState) {
                                  return ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: mainColorU,
                                            border:
                                                Border.all(color: borderSide),
                                          ),
                                          height: media.height / 2.5,
                                          child: SfDateRangePicker(
                                              todayHighlightColor: black,
                                              rangeTextStyle: normalSizePoppins,
                                              endRangeSelectionColor:
                                                  appbarColorU,
                                              rangeSelectionColor:
                                                  appbarColorU.withOpacity(0.3),
                                              view: DateRangePickerView.month,
                                              minDate: DateTime.now(),
                                              selectionShape:
                                                  DateRangePickerSelectionShape
                                                      .rectangle,
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .range,
                                              initialDisplayDate:
                                                  DateTime.now(),
                                              showActionButtons: true,
                                              onSubmit: (p0) {
                                                if (startDate.isNotEmpty &&
                                                    endDate.isNotEmpty) {
                                                  return ScaffoldMessenger
                                                          .maybeOf(context)!
                                                      .showSnackBar(customSnackbar(
                                                          context,
                                                          true,
                                                          "Successfully Selected"));
                                                }
                                                return ScaffoldMessenger
                                                        .maybeOf(context)!
                                                    .showSnackBar(customSnackbar(
                                                        context,
                                                        false,
                                                        "Please Select A Date"));
                                              },
                                              onCancel: () {
                                                _startDate = DateTime.now();
                                                _endDate = DateTime.now();
                                                endDate = "";
                                                startDate = "";
                                                startdateController.clear();
                                                enddateController.clear();
                                              },
                                              headerStyle:
                                                  DateRangePickerHeaderStyle(
                                                      textStyle: GoogleFonts
                                                          .poppins()),
                                              initialSelectedRange:
                                                  PickerDateRange(
                                                _startDate ?? DateTime.now(),
                                                _endDate ?? DateTime.now(),
                                              ),
                                              startRangeSelectionColor:
                                                  appbarColorU,
                                              onSelectionChanged:
                                                  (DateRangePickerSelectionChangedArgs
                                                      args) {
                                                if (args.value
                                                    is PickerDateRange) {
                                                  if (args.value!.startDate !=
                                                          null &&
                                                      args.value!.endDate !=
                                                          null) {
                                                    _startDate =
                                                        args.value!.startDate!;
                                                    _endDate =
                                                        args.value!.endDate!;
                                                    endDate =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(_endDate!);
                                                    startDate = DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(_startDate!);
                                                    // startdateController.text =
                                                    //     startDate;
                                                    // enddateController.text = endDate;
                                                  }
                                                }
                                              })),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          HalfSizeButton(
                                            title: "Close",
                                            isLoading: false,
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          BlocConsumer<VehicleCheckBloc,
                                              VehicleCheckState>(
                                            listener: (context, state) {
                                              if (state
                                                  is CheckVehicleAvalibleFailed) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        customSnackbar(
                                                            context,
                                                            false,
                                                            "Something Wrong"));
                                              } else if (state
                                                  is CheckVehicleAvalibleSuccess) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(customSnackbar(
                                                        context,
                                                        true,
                                                        "This Vehicle Avalible"));
                                              }
                                            },
                                            builder: (context, state) {
                                              return HalfSizeButton(
                                                title: "Chek Now",
                                                isLoading: state
                                                    is VehicleCheckLoading,
                                                onTap: () {
                                                  context
                                                      .read<VehicleCheckBloc>()
                                                      .add(CheckAVhicleBookings(
                                                          vehicle.location,
                                                          vehicle.id,
                                                          endDate,
                                                          startDate));
                                                },
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ));
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(media.width / 2, media.height / 17),
                    backgroundColor: black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text("Check Avaliblity", style: style4)),
          )
        ],
      ),
    ));
  }
}
