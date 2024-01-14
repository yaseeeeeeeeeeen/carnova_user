import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomWid01 extends StatelessWidget {
  CustomWid01({super.key});

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        isPassword: false,
                        validation: (value) => null,
                        controller: _controller,
                        hintText: "hintText",
                        obscureText: false),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("SSSSSSSS");
                      
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/svg/filter-svgrepo-com.svg",
                        height: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
