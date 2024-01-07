import 'package:carnova_user/blocs/booking/booking_bloc.dart';
import 'package:carnova_user/blocs/booking/booking_event.dart';
import 'package:carnova_user/blocs/booking/booking_state.dart';
import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CancleBookingButton extends StatelessWidget {
  CancleBookingButton({super.key, required this.bookedVehicle});
  final BookedVehicle bookedVehicle;
  TextEditingController resonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  Text("₹ ${bookedVehicle.grandTotal}", style: style2),
                  Text("  Total Ammount",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.black54))
                ]),
          ),
          const SizedBox(width: 30),
          ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.viewInsetsOf(context).bottom),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: Colors.black38,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              MyTextField(
                                  isPassword: false,
                                  validation: (value) => null,
                                  controller: resonController,
                                  hintText: "Reson",
                                  obscureText: false),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        textStyle: GoogleFonts.poppins(),
                                        backgroundColor: Colors.black,
                                        fixedSize: Size(
                                            MediaQuery.sizeOf(context).width /
                                                2.3,
                                            50)),
                                    child: const Text("Cancel"),
                                  ),
                                  BlocConsumer<BookingBloc, BookingState>(
                                    listener: (context, state) {
                                      if (state is CancelFailedState) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(customSnackbar(
                                                context, false, state.message));
                                      } else if (state is CancelSuccsessState) {
                                        context
                                            .read<BookingBloc>()
                                            .add(UpdateBookedVehiclesList());
                                      } else if (state is FetchedVehicleData) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomNavBar(index: 2)),
                                                (route) => false);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(customSnackbar(
                                                context,
                                                true,
                                                "Booking Cancelation Succsessfull"));
                                      }
                                    },
                                    builder: (context, state) {
                                      return ElevatedButton(
                                          onPressed: () {
                                            context.read<BookingBloc>().add(
                                                CancelBooking(
                                                    bookId: bookedVehicle.id,
                                                    userId:
                                                        bookedVehicle.userId,
                                                    reason:
                                                        resonController.text,
                                                    ammount: bookedVehicle
                                                        .grandTotal));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              textStyle: GoogleFonts.poppins(),
                                              backgroundColor: Colors.black,
                                              fixedSize: Size(
                                                  MediaQuery.sizeOf(context)
                                                          .width /
                                                      2.3,
                                                  50)),
                                          child: state is BookingLoadingState
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2)
                                              : const Text("Confirm"));
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(130, 50),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text("Cancel", style: style4))
        ],
      ),
    ));
  }
}
