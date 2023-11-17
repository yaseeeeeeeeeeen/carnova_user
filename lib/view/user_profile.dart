import 'package:carnova_user/utils/appbar.dart';

import 'package:flutter/material.dart';


class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarU(context),
      body: Container(color: Colors.black87));
  }
}
