import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:carnova_user/view/profile/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileCardWid extends StatelessWidget {
  const ProfileCardWid({super.key});

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    final logedUser = getLoggedInUser();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderSide),
        color: mainColorU,
      ),
      padding: const EdgeInsets.all(10),
      height: heigth / 3.4,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: "profilePhoto",  
            child: logedUser.profile!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: heigth / 7,
                      imageUrl:
                          "${ApiUrls.imagegettingUrl}${logedUser.profile}",
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: CircleAvatar(
                          backgroundColor: mainColorU,
                          radius: heigth / 13,
                          child: Image.network(url),
                        ),
                      ),
                      
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: mainColorU,
                    radius: heigth / 13,
                    backgroundImage: AssetImage(imageU.profileDemo)),
          ),
          const SizedBox(height: 10),
          Text(
            "   ${logedUser.name.toUpperCase()}",
            style: activeVehicle1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.8,
                child: Text(logedUser.email,
                    style: mailstyle, overflow: TextOverflow.ellipsis),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileEditScreen()));
                  },
                  child: Text(
                    "Edit Profile",
                    style: boldPoppins15,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
