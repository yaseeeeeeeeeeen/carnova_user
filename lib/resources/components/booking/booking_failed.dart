import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingFailedScreen extends StatelessWidget {
  const BookingFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: customAppBarText("PAYMENT FAILED", context, () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CustomNavBar(index: 1)),
              (route) => false);
        }),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height / 2.6,
                width: size.width / 1.5,
                child: SvgPicture.asset(
                    "assets/svg/Payment Information-bro (1).svg"),
              ),
              Text(
                "PAYMENT FAILED TRY AGAIN",
                style: paymentFailedTilteStyle,
              ),
              SizedBox(height: size.height / 5),
              MyLoadingButton(
                title: "Retry & Roll Out",
                isLoading: false,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => CustomNavBar(index: 1)),
                      (route) => false);
                },
              )
            ],
          )),
        ));
  }
}
