import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateComponent extends StatefulWidget {
  const DateComponent({Key? key}) : super(key: key);

  @override
  State<DateComponent> createState() => _DateComponentState();
}

class _DateComponentState extends State<DateComponent> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF559690),
              surface: Color(0xFF343434),
            ),
            dialogBackgroundColor: Colors.black,
            shadowColor: const Color(0xFF00FD0C),
            // Add shadow to calendar
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color(0xFF00FD0C),
                  width: 1,
                ),
              ),
              elevation: 24,  // Increased elevation for more pronounced shadow
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 918,
      top: 12,
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: Container(
          width: 90,
          height: 27,
          alignment: Alignment.center,
          child: Text(
            DateFormat('dd-MM-yyyy').format(_selectedDate),
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