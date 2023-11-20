import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCardWid extends StatelessWidget {
  const ProfileCardWid({super.key});

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      height: heigth / 3.4,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              backgroundColor: Colors.white,
              radius: heigth / 13,
              backgroundImage: AssetImage(imageU.userPhoto)),
          const SizedBox(height: 10),
          Text(
            "Muhammed Yaseen",
            style: profileName,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.8,
                child: Text("muhammedyaseen@gmail.com",
                    style: mailstyle, overflow: TextOverflow.ellipsis),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Edit Profile",
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
    );
  }
}



