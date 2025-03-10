import 'package:flutter/material.dart';
import 'ecg_detail_popup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! < 0) { // Swipe right to left
          _showECGDetailPopup(context);
        }
      },
      child: Scaffold(
        // Your existing home screen content
      ),
    );
  }

  void _showECGDetailPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const ECGDetailPopup(),
    );
  }
} 