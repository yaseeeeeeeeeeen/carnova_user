import 'package:carnova_user/resources/components/profie_screen/profile_card.dart';
import 'package:carnova_user/resources/components/profie_screen/profile_screen_listtile.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carnova_user/utils/functions/logout_cnfm.dart';
import 'package:carnova_user/view/login_signup/change_password.dart';
import 'package:carnova_user/view/policies/privacy_policy.dart';
import 'package:carnova_user/view/policies/terms_and_condition.dart';

import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: customAppBarU(context),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ProfileCardWid(),
                const SizedBox(height: 10),
                ProfileScreenListtile(
                    text: "Change Password",
                    isLogout: false,
                    ontap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                    }),
                ProfileScreenListtile(
                    ontap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const TermsAndConditionScreen()));
                    },
                    text: "Terms & Conditions",
                    isLogout: false),
                GestureDetector(
                  onTap: () {},
                  child: ProfileScreenListtile(
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const PrivacyAndPolicyScreen()));
                      },
                      text: "Privacy & Policy",
                      isLogout: false),
                ),
                const Divider(thickness: 1.5),
                ProfileScreenListtile(
                    text: "Sign Out",
                    isLogout: true,
                    ontap: () {
                      signoutConfirmation(context);
                    }),
                Container()
              ],
            ),
          ),
        ));
  }
}
