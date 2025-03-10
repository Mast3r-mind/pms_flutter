import 'package:flutter/material.dart';
import 'patient_details_popup.dart';

class PatientIdComponent extends StatefulWidget {
  const PatientIdComponent({Key? key}) : super(key: key);

  @override
  State<PatientIdComponent> createState() => _PatientIdComponentState();
}

class _PatientIdComponentState extends State<PatientIdComponent> {
  bool _isPressed = false;
  String _selectedType = 'ADULT';
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  // Map to store image paths for each type
  final Map<String, String> _typeImages = {
    'ADULT': 'assets/images/adult.png',
    'PEDIATRIC': 'assets/images/pediatrics.png',
    'NEONATE': 'assets/images/newborn.png',
  };

  Widget _buildTypeImage(String type) {
    return Image.asset(
      _typeImages[type]!,
      width: 20,
      height: 20,
      color: Colors.white, // Add this if you want to tint the image white
    );
  }

  Widget _buildTypeOption(String type) {
    return InkWell(
      onTap: () {
        setState(() => _selectedType = type);
        _overlayEntry?.remove();
        _overlayEntry = null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: _selectedType == type ? Colors.black : Colors.transparent,
        child: Row(
          children: [
            _buildTypeImage(type),
            const SizedBox(width: 8),
            Text(
              type,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTypeOptions(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            top: position.dy + 62,
            left: position.dx + 103,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTypeOption('ADULT'),
                    const Divider(height: 1, color: Colors.black),
                    _buildTypeOption('PEDIATRIC'),
                    const Divider(height: 1, color: Colors.black),
                    _buildTypeOption('NEONATE'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _showPatientDetails(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) => const PatientDetailsPopup(),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PAT001 Button
        GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            _showPatientDetails(context);
          },
          onTapCancel: () => setState(() => _isPressed = false),
          child: Container(
            margin: const EdgeInsets.only(left: 5, top: 8),
            width: 98,
            height: 54,
            decoration: BoxDecoration(
              color: _isPressed 
                  ? const Color(0xFF000000).withOpacity(0.3) 
                  : Colors.black,
              border: Border.all(
                color: const Color(0xFF000000),
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: const Center(
              child: Text(
                'PAT 001',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        // Patient Type Button
        GestureDetector(
          onTap: () => _showTypeOptions(context),
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: const Color(0xFF000000),
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypeImage(_selectedType),
                const SizedBox(width: 8),
                Text(
                  _selectedType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 