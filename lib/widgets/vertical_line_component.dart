import 'package:flutter/material.dart';

class VerticalLineComponent extends StatelessWidget {
  const VerticalLineComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 52,
      color: const Color(0xFF343434),  // Green color
    );
  }
} 