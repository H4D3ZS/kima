import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onSelectDate;
  final DateTime? initialDate;

  const CustomDatePicker({
    required this.onSelectDate,
    this.initialDate,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime? selectedDate;

  @override
  void initState() {
    selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (BuildContext context) => Container(
          height: 300.0,
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
          child: CupertinoDatePicker(
            itemExtent: 50.0,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate ?? DateTime.now(),
            onDateTimeChanged: (value) {
              setState(() => selectedDate = value);
              widget.onSelectDate(value);
            },
          ),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey30),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: CustomText(
          selectedDate != null ? DateFormat('MM/dd/yyyy').format(selectedDate!) : 'MM/DD/YYYY',
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontColor: selectedDate != null ? Colors.black : AppColors.black20.withOpacity(0.7),
        ),
      ),
    );
  }
}
