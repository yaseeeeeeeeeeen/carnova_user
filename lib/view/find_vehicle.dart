import 'package:carnova_user/resources/components/textfields_and_buttons/custom_textfiled.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/utils/appbar.dart';

class FindVehicleU extends StatelessWidget {
  FindVehicleU({super.key});

  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: customAppBarU(context),
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 5),
          child: Column(
            children: [
              CustomTextfield(
                  viewonly: false,
                  hint: "Searching Location",
                  isSufix: false,
                  controller: locationController),
              const SizedBox(height: 5),
              InkWell(
                // onTap: ,
                child: CustomTextfield(
                    viewonly: false,
                    keybordtype: TextInputType.none,
                    hint: "Tap to add Date",
                    isSufix: false,
                    controller: dateController),
              ),
              const SizedBox(height: 15),
              const DatePickerWidget(),
              const SizedBox(height: 15),
              const MyLoadingButton(
                  title: "Check Availabilty", isLoading: false)
            ],
          ),
        ));
  }
}
