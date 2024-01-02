import 'package:carnova_user/blocs/booking/booking_bloc.dart';
import 'package:carnova_user/blocs/booking/booking_event.dart';
import 'package:carnova_user/blocs/booking/booking_state.dart';
import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/components/payment_demo/payment_demo.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatefulWidget {
  Vehicle vehicle;
  final String startingDate;
  final String endingDate;

  PaymentScreen({
    super.key,
    required this.vehicle,
    required this.startingDate,
    required this.endingDate,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    count = countDate(widget.startingDate, widget.endingDate);
  }

  int? count;
  var isChecked = ValueNotifier(false);
  late int sgst = widget.vehicle.price ~/ 14.ceil();
  late int cgst = sgst;
  late double totalAmount = (widget.vehicle.price * count!) + sgst + cgst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  child: Image.network(
                    '${ApiUrls.baseUrl}/${widget.vehicle.images[0]}',
                    fit: BoxFit.fill,
                    height: 300,
                    width: double.infinity,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: dpadding),
                //   child: const BackButtonWidget(),
                // )
              ],
            ),
            SubTitleWidget(
                title:
                    "${widget.vehicle.brand.toUpperCase()}  ${widget.vehicle.name.toUpperCase()}",
                fontsize: 18),
            const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     PickupDropoffWidget(
            //         title: 'Pickup',
            //         location: widget.vehicle.location,
            //         date: widget.startingDate),
            //     PickupDropoffWidget(
            //         title: 'Dropoff',
            //         location: widget.vehicle.location,
            //         date: widget.endingDate),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubTitleWidget(title: 'Fair Details'),
                    FairDetailsRowWidget(
                        name: "Base Rate :",
                        money: '₹ ${widget.vehicle.price}'),
                    FairDetailsRowWidget(name: "SGST : 14 %", money: '₹ $sgst'),
                    FairDetailsRowWidget(name: "CGST : 14 %", money: '₹ $cgst'),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(thickness: 0.5)),
                    // Row(
                    //   children: [
                    //     ValueListenableBuilder(
                    //         valueListenable: isChecked,
                    //         builder: (context, value, _) {
                    //           return Checkbox(
                    //             value: value,
                    //             onChanged: (value) {
                    //               isChecked.value = value ?? false;
                    //             },
                    //           );
                    //         }),
                    //     // Expanded(
                    //     //   child: Padding(
                    //     //     padding: const EdgeInsets.only(right: 15),
                    //     //     child: Row(
                    //     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     //       children: [
                    //     //         const Text('Wallet'),
                    //     //         // Text('₹ ${globalUserModel.wallet ?? 0}')
                    //     //       ],
                    //     //     ),
                    //     //   ),
                    //     // )
                    //   ],
                    // ),
                    FairDetailsRowWidget(
                        name: "Total Rental Amount", money: '₹ $totalAmount'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocConsumer<BookingBloc, BookingState>(
                        listener: (context, state) {
                          if (state is PaymentSuccessState) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => CustomNavBar()),
                                (route) => false);
                          } else if (state is PaymentFailedState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackbar(
                                    context, false, 'Payment Failed'));
                          } else if (state is PaymentErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackbar(context, false, state.message));
                          }
                        },
                        builder: (context, state) {
                          return MyLoadingButton(
                              title: "BookNow",
                              isLoading: false,
                              onTap: () {
                                context.read<BookingBloc>().add(
                                    PaymentInitialEvent(
                                        total: widget.vehicle.price.toInt(),
                                        userId: widget.vehicle.hostDetails.id,
                                        vehicleId: widget.vehicle.id,
                                        pickup: widget.vehicle.location,
                                        dropoff: widget.vehicle.location,
                                        startDate: widget.startingDate,
                                        endDate: widget.endingDate,
                                        grandTotal: totalAmount.toInt()));
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int countDate(String start, String end) {
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    int diffrence = endDate.difference(startDate).inDays;
    return diffrence;
  }
}
