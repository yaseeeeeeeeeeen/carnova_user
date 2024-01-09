import 'package:carnova_user/resources/components/car_show_screen/upcoming_list.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/vehicle/booking/history_list.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/utils/appbar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarU(context),
        body: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: ContainedTabBarView(
            tabBarViewProperties: const TabBarViewProperties(
                physics: AlwaysScrollableScrollPhysics()),
            tabBarProperties: TabBarProperties(
                indicatorWeight: 4,
                indicatorColor: appbarColorU,
                unselectedLabelColor: Colors.black.withOpacity(0.3),
                labelColor: Colors.black),
            tabs: [
              Text('Upcoming', style: tabbartitle),
              Text('All History', style: tabbartitle),
            ],
            views: [CarUpcomingListTile(), HistoryCharList()],
            onChange: (index) {},
          ),
        ));
  }
}
