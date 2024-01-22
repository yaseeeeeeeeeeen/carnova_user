import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/resources/components/car_show_screen/list_empty_svg.dart';
import 'package:carnova_user/resources/components/car_show_screen/upcoming_list.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/vehicle/booking/history_list.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/utils/appbar.dart';

class HistoryScreen extends StatelessWidget {
   HistoryScreen({super.key});
final historyOfbooking = bookedHistory();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarU(context),
        body: Container(
          color: mainColorU,
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: historyOfbooking.isEmpty
          ? const ListIsEmpty(): ContainedTabBarView(
            tabBarViewProperties: const TabBarViewProperties(
                physics: AlwaysScrollableScrollPhysics()),
            tabBarProperties: TabBarProperties(
                indicatorWeight: 4,
                indicatorColor: appbarColorU,
                unselectedLabelColor: black.withOpacity(0.3),
                labelColor: black),
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
