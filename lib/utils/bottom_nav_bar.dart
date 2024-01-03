import 'package:carnova_user/modals/vehicle_data._modal.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/history_screen.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:carnova_user/view/vehicle/find_vehicle.dart';
import 'package:carnova_user/view/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomNavBar extends StatefulWidget {
  CustomNavBar({super.key, this.index});
  int? index;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<CustomNavBar> {
  var currentIndex = 0;

  @override
  void initState() {
    final mapppp1 = VehicleDataModal.fromJson(imageU.vehicleDataMap1);
    vehiclesData.add(mapppp1);
    final mapppp2 = VehicleDataModal.fromJson(imageU.vehicleDataMap2);
    vehiclesData.add(mapppp2);
    final mapppp3 = VehicleDataModal.fromJson(imageU.vehicleDataMap3);
    vehiclesData.add(mapppp3);

    if (widget.index != null) {
      currentIndex = widget.index!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            left: displayWidth * .05, right: displayWidth * .05),
        height: displayWidth * .200,
        decoration: BoxDecoration(
          color: bottomNavColorU,
        ),
        child: ListView.builder(
          itemCount: screens.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Colors.black.withOpacity(0.3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                                index == currentIndex
                                    ? listOfStrings[index]
                                    : '',
                                style: navbartitle),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == currentIndex
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.search_outlined,
    Icons.history,
    Icons.person,
  ];

  List<String> listOfStrings = [
    'Home',
    'Find',
    'History',
    'Profile',
  ];

  List<Widget> screens = [
    const HomeScreen(),
    FindVehicleU(),
    const HistoryScreen(),
    const UserProfile(),
  ];
}
