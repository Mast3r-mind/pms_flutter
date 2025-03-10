import 'package:flutter/material.dart';

enum PatientType { adult, pediatric, neonate }

class PatientTypeSelector extends StatefulWidget {
  final PatientType selectedType;
  final Function(PatientType) onTypeChanged;

  const PatientTypeSelector({
    Key? key,
    required this.selectedType,
    required this.onTypeChanged,
  }) : super(key: key);

  @override
  State<PatientTypeSelector> createState() => _PatientTypeSelectorState();
}

class _PatientTypeSelectorState extends State<PatientTypeSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: const Color(0xFF000000)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTypeButton(
            type: PatientType.adult,
            icon: Icons.person,
            label: 'ADULT',
          ),
          _buildDivider(),
          _buildTypeButton(
            type: PatientType.pediatric,
            icon: Icons.child_care,
            label: 'PEDIATRIC',
          ),
          _buildDivider(),
          _buildTypeButton(
            type: PatientType.neonate,
            icon: Icons.baby_changing_station,
            label: 'NEONATE',
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton({
    required PatientType type,
    required IconData icon,
    required String label,
  }) {
    final isSelected = widget.selectedType == type;
    
    return GestureDetector(
      onTap: () => widget.onTypeChanged(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: isSelected ? Colors.black : Colors.transparent,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
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

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: double.infinity,
      color: const Color(0xFF000000),
    );
  }
} 