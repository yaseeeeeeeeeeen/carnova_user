import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnova_user/blocs/booking/booking_bloc.dart';
import 'package:carnova_user/blocs/booking/booking_event.dart';
import 'package:carnova_user/blocs/booking/booking_state.dart';
import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/components/booking/booking_failed.dart';
import 'package:carnova_user/resources/components/booking/booking_widget.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/components/car_show_screen/agent_tile.dart';

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
    double h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: customAppBarText(widget.vehicle.name.toUpperCase(), context, () {
        Navigator.of(context).pop();
      }),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: widget.vehicle.name,
                  child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                          height: h / 3.8,
                          width: double.infinity,
                      imageUrl: "${ApiUrls.imagegettingUrl}${widget.vehicle.images[0]}",
                      fit: BoxFit.cover,
                      placeholder:(context, url) =>  Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: Container(
                            height: h / 3.8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        url),
                                    fit: BoxFit.cover))),
                      ),
                    ),
                  )),
              const SizedBox(height: 5),
              CarAgentTile(vehicledata: widget.vehicle),
              const SizedBox(height: 5),
              Container(
                // height: h / 2.3,
                decoration: BoxDecoration(
                    color: mainColorU,
                    border: Border.all(color: borderSide),
                    borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubTitleWidget(title: '  Booking Details'),
                    FairDetailsRowWidget(
                        name: "Base Rate :",
                        money: '₹ ${widget.vehicle.price}'),
                    FairDetailsRowWidget(name: "SGST : 14 %", money: '₹ $sgst'),
                    FairDetailsRowWidget(name: "CGST : 14 %", money: '₹ $cgst'),
                    FairDetailsRowWidget(
                        name: "", money: "${count.toString()} DAYS"),
                    FairDetailsRowWidget(
                        name: "Location", money: widget.vehicle.location),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(thickness: 0.5)),
                    FairDetailsRowWidget(
                        name: "Total Rental Amount", money: '₹ $totalAmount'),
                    // Row(
                    //   children: [
                    //     Checkbox(value: false, onChanged: (value) {}),
                    //     const Text("WALLET")
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocConsumer<BookingBloc, BookingState>(
                        listener: (context, state) {
                          if (state is PaymentSuccessState) {
                            context
                                .read<BookingBloc>()
                                .add(UpdateBookedVehiclesList());
                          } else if (state is PaymentFailedState) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BookingFailedScreen()),
                                (route) => false);
                          } else if (state is PaymentErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackbar(context, false, state.message));
                          } else if (state is FetchedVehicleData) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => CustomNavBar()),
                                (route) => false);
                          }
                        },
                        builder: (context, state) {
                          return MyLoadingButton(
                              title: "Go to Payment",
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
              )
            ],
          ),
        ),
      ),
    );
  }

  int countDate(String start, String end) {
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    int diffrence = endDate.difference(startDate).inDays;
    final count = diffrence + 1;
    return count;
  }
}
