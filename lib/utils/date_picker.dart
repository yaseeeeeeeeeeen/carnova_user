import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HijriDatePickerWidgetState createState() => _HijriDatePickerWidgetState();
}

class _HijriDatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _startDate;
  DateTime? _endDate;
  String endDate = "";
  String startDate = "";
  // DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      height: heigth / 2.5,
      child: SfDateRangePicker(
        todayHighlightColor: Colors.black,
        rangeTextStyle: GoogleFonts.poppins(),

        endRangeSelectionColor: appbarColorU,
        rangeSelectionColor: appbarColorU.withOpacity(0.3),
        view: DateRangePickerView.month,
        minDate: DateTime.now(),
        selectionShape: DateRangePickerSelectionShape.rectangle,
        selectionMode: DateRangePickerSelectionMode.extendableRange,
        initialDisplayDate: DateTime.now(),
        // hijriDatePickerDisplayMode: DatePickerDisplayMode.month,
        initialSelectedRange: PickerDateRange(
          _startDate ?? DateTime.now(),
          _endDate ?? DateTime.now(),
        ),
        startRangeSelectionColor: appbarColorU,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          setState(() {
            if (args.value is PickerDateRange) {
              _startDate = args.value!.startDate;
              _endDate = args.value!.endDate;
              endDate = DateFormat('EEEE, MMMM d, yyyy').format(_endDate!);
              startDate = DateFormat('EEEE, MMMM d, yyyy').format(_startDate!);
              // print("start date: $startDate");
              // print("end date:$endDate");
            }
          });
        },
      ),
    );
  }
}
