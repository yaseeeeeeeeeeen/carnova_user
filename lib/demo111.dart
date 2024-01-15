import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/utils/functions/location_selecter.dart';
import 'package:flutter/material.dart';

class CustomWid01 extends StatefulWidget {
  CustomWid01({super.key});

  @override
  State<CustomWid01> createState() => _CustomWid01State();
}

class _CustomWid01State extends State<CustomWid01> {
  TextEditingController locationcontroller = TextEditingController();

  List<Map<String, dynamic>> locationList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
            const  SizedBox(height: 50),
              MyTextField(
                  onFieldSubmitted: (p0) async {
                    locationList = await MapBoxHelper.getSearchResults(
                        locationcontroller.text);
                    setState(() {});
                  },
                  isPassword: false,
                  validation: (value) => null,
                  controller: locationcontroller,
                  hintText: "hintText",
                  obscureText: false),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                        tileColor: Colors.amber,
                        title: Text(locationList[index]["placeName"]));
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: locationList.length)
            ],
          ),
        ),
      ),
    );
  }
}
