import 'package:flutter/material.dart';
import 'patient_id_component.dart';
import 'date_component.dart';

class TopRectangleComponent extends StatelessWidget {
  const TopRectangleComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1013,
      height: 57,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: const Color(0xFF000000),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PatientIdComponent(),
        //   DateComponent(),
        ],
      ),
    );
  }
} 