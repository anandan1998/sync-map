import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected; // Callback for selected date

  const DateSelector({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (picked != null && picked != selectedDate) {
          setState(() {
            selectedDate = picked;
          });
          widget.onDateSelected(picked); // Call the callback with the selected date
        }
      },
      child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
    );
  }
}
