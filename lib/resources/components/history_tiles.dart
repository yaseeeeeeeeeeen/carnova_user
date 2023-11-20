import 'package:carnova_user/modals/vehicle_data._modal.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/car_details_screen.dart';
import 'package:flutter/material.dart';

class CarUpcomingListTile extends StatelessWidget {
  CarUpcomingListTile({super.key});
  //// addd upcoming booked vehiles list
  final vehiclesinfo = vehiclesData;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      color: scaffoldBg,
      padding: const EdgeInsets.all(10),
      height: heigth,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final data = vehiclesinfo[index];
            return GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) =>
                //         CarDataShow(vehicleData: data, isBooked: true)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                height: heigth / 7.3,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: data.name,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data.coverPhoto),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          width: width / 2.4,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(right: 10),
                          width: width / 2,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.name, style: tabcardtext1),
                                    Text("₹${data.price}", style: tabcardtext1)
                                  ],
                                ),
                                Text(data.brand,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                const Row(
                                  children: [
                                    Icon(Icons.calendar_today_outlined,
                                        size: 15, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text("20-10-2023")
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 15, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text("Calicut-Kerala")
                                  ],
                                )
                              ]))
                    ]),
              ),
            );
          },
          itemCount: vehiclesinfo.length),
    );
  }
}

class HistoryCharList extends StatelessWidget {
  HistoryCharList({super.key});
  //// add previous booking car detaisl in this screen
  final vehiclesinfo = vehiclesData;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      color: scaffoldBg,
      padding: const EdgeInsets.all(10),
      height: heigth,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final data = vehiclesinfo[index];
            return GestureDetector(
              onTap: () {
                
             //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarDataShow(vehicleData: data, isBooked: )))
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                height: heigth / 7.3,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: data.name,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data.coverPhoto),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          width: width / 2.4,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(right: 10),
                          width: width / 2,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.name, style: tabcardtext1),
                                    Text("₹${data.price}", style: tabcardtext1)
                                  ],
                                ),
                                Text(data.brand,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                const Row(
                                  children: [
                                    Icon(Icons.calendar_today_outlined,
                                        size: 15, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text("20-10-2023")
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 15, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text("Calicut-Kerala")
                                  ],
                                )
                              ]))
                    ]),
              ),
            );
          },
          itemCount: vehiclesinfo.length),
    );
  }
}
