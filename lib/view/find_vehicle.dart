import 'package:carnova_user/resources/components/textfields_and_buttons/custom_textfiled.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/utils/appbar.dart';

class FindVehicleU extends StatelessWidget {
  FindVehicleU({super.key});

  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarU(context),
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 5),
          child: Column(
            children: [
              CustomTextfield(
                  hint: "Searching Location",
                  isSufix: false,
                  controller: locationController),
              const SizedBox(height: 5),
              CustomTextfield(
                  hint: "Tap to add Date",
                  isSufix: false,
                  controller: locationController),
              const SizedBox(height: 10),
              const MyLoadingButton(
                  title: "Check Availabilty", isLoading: false)
            ],
          ),
        ));
  }
}
