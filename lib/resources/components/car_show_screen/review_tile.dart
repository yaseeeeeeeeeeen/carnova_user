import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewCommentTile extends StatelessWidget {
  const ReviewCommentTile(
      {super.key, required this.review, required this.rating});
  final String review;
  final String rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1)),
      child: ListTile(
        trailing: Container(
            margin: const EdgeInsets.all(2),
            width: 60,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.5)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svg/star-svgrepo-com.svg",
                          fit: BoxFit.cover, height: 20, width: 20),
                      Text(
                        rating,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            )),
        leading: const CircleAvatar(radius: 20, backgroundColor: Colors.amber),
        title: Text(
          review,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    );
  }
}
