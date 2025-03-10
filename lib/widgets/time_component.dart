import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeComponent extends StatefulWidget {
  const TimeComponent({Key? key}) : super(key: key);

  @override
  State<TimeComponent> createState() => _TimeComponentState();
}

class _TimeComponentState extends State<TimeComponent> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF559690),
              surface: Color(0xFF343434),
            ),
            dialogBackgroundColor: Colors.black,
            shadowColor: const Color(0xFF00FD0C),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color(0xFF00FD0C),
                  width: 1,
                ),
              ),
              elevation: 24,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 898,
      top: 35,  // Positioned below the date
      child: GestureDetector(
        onTap: () => _selectTime(context),
        child: Container(
          width: 90,
          height: 27,
          alignment: Alignment.center,
          child: Text(
            _selectedTime.format(context),  // This will show time in 12-hour format
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
} 