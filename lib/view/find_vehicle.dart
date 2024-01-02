import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/custom_textfiled.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:carnova_user/view/vehicle_list.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: must_be_immutable
class FindVehicleU extends StatelessWidget {
  FindVehicleU({super.key});
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
    double heigth = MediaQuery.sizeOf(context).height;
    return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: customAppBarU(context),
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                CustomTextfield(
                    viewonly: false,
                    keybordtype: TextInputType.none,
                    hint: "Staring Date",
                    isSufix: false,
                    controller: startdateController),
                CustomTextfield(
                    viewonly: false,
                    keybordtype: TextInputType.none,
                    hint: "Ending Date",
                    isSufix: false,
                    controller: enddateController),
                const SizedBox(height: 15),
                //////calander/////////////////////////////////////////
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    height: heigth / 2.5,
                    child: SfDateRangePicker(
                        todayHighlightColor: Colors.black,
                        rangeTextStyle: GoogleFonts.poppins(),
                        endRangeSelectionColor: appbarColorU,
                        rangeSelectionColor: appbarColorU.withOpacity(0.3),
                        view: DateRangePickerView.month,
                        minDate: DateTime.now(),
                        selectionShape: DateRangePickerSelectionShape.rectangle,
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialDisplayDate: DateTime.now(),
                        showActionButtons: true,
                        onSubmit: (p0) {
                          if (startDate.isNotEmpty && endDate.isNotEmpty) {
                            return ScaffoldMessenger.maybeOf(context)!
                                .showSnackBar(customSnackbar(
                                    context, true, "Successfully Selected"));
                          }
                          return ScaffoldMessenger.maybeOf(context)!
                              .showSnackBar(customSnackbar(
                                  context, false, "Please Select A Date"));
                        },
                        onCancel: () {
                          /////// textfield and timeformat hint textes all clearing here//////////////

                          _startDate = DateTime.now();
                          _endDate = DateTime.now();
                          endDate = "";
                          startDate = "";
                          startdateController.clear();
                          enddateController.clear();
                        },
                        headerStyle: DateRangePickerHeaderStyle(
                            textStyle: GoogleFonts.poppins()),
                        // hijriDatePickerDisplayMode: DatePickerDisplayMode.month,
                        initialSelectedRange: PickerDateRange(
                          _startDate ?? DateTime.now(),
                          _endDate ?? DateTime.now(),
                        ),
                        startRangeSelectionColor: appbarColorU,
                        onSelectionChanged:
                            (DateRangePickerSelectionChangedArgs args) {
                          if (args.value is PickerDateRange) {
                            if (args.value!.startDate != null &&
                                args.value!.endDate != null) {
                              _startDate = args.value!.startDate!;
                              _endDate = args.value!.endDate!;
                              endDate = DateFormat('EEEE, MMMM d, yyyy')
                                  .format(_endDate!);
                              startDate = DateFormat('EEEE, MMMM d, yyyy')
                                  .format(_startDate!);
                              startdateController.text = startDate;
                              enddateController.text = endDate;
                            }
                          }
                        })),
                const SizedBox(height: 15),
                BlocConsumer<VehicleCheckBloc, VehicleCheckState>(
                  listener: (context, state) {
                    if (state is UserStoreChoiceState) {
                      location = state.data["pickup"].toString();
                      context
                          .read<VehicleCheckBloc>()
                          .add(FetchAvalibleVehicles(checkingData: state.data));
                    } else if (state is LocationPickingFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          customSnackbar(context, false, state.message));
                    } else if (state is UserStoreChoiceSuccsess) {
                      context.read<VehicleCheckBloc>().add(FetchVehicles());
                    } else if (state is VehilceFetchingFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          customSnackbar(context, false, state.messege));
                    } else if (state is VehicleFetchSuccsessState) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return FetchedVehicles(
                              startDate: startDate,
                              enddate: endDate,
                              vehicles: state.vehicleModel,
                              location: location,
                              position: state.location);
                        },
                      ));
                    }
                  },
                  builder: (context, state) {
                    return MyLoadingButton(
                        title: "Check Nearby Vehicles",
                        isLoading: state is VehicleCheckLoading,
                        onTap: () {
                          if (enddateController.text.isNotEmpty) {
                            context.read<VehicleCheckBloc>().add(
                                CheckAvaliblityButtonClicked(
                                    startDate: startdateController.text,
                                    endDate: enddateController.text));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackbar(
                                    context, false, "Select a date"));
                          }
                        });
                  },
                )
              ],
            ),
          ),
        ));
  }
}
