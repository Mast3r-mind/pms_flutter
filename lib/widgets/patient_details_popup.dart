import 'package:flutter/material.dart';
import 'custom_keyboard.dart';
import 'numeric_keypad.dart';

class PatientDetailsPopup extends StatefulWidget {
  const PatientDetailsPopup({Key? key}) : super(key: key);

  @override
  State<PatientDetailsPopup> createState() => _PatientDetailsPopupState();
}

class _PatientDetailsPopupState extends State<PatientDetailsPopup> {
  late TextEditingController patientIdController;
  late TextEditingController patientNameController;
  late TextEditingController ageController;
  late TextEditingController weightController;
  late TextEditingController heightController;
  
  String selectedGender = 'Female';
  String selectedWeightUnit = 'Kgs';
  String selectedHeightUnit = 'cm';
  String selectedTimeUnit = 'Days';

  @override
  void initState() {
    super.initState();
    patientIdController = TextEditingController(text: 'PAT 001');
    patientNameController = TextEditingController(text: 'Nivi');
    ageController = TextEditingController(text: '45');
    weightController = TextEditingController(text: '72.58');
    heightController = TextEditingController(text: '259');
  }

  // Show keyboard popup for specific fields
  Future<void> _showKeyboardPopup(TextEditingController controller, String label) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Stack(
        children: [
          Positioned(
            top: 300,
            left: 200,
            child: CustomKeyboard(
              initialValue: controller.text,
              onValueChanged: (value) {
                setState(() {
                  controller.text = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Show numeric keypad for specific fields
  Future<void> _showNumericKeypad(TextEditingController controller, String label) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Stack(
        children: [
          Positioned(
            top: 180,
            left: 250,
            child: NumericKeypad(
              initialValue: controller.text,
              onValueChanged: (value) {
                setState(() {
                  controller.text = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with border and highlight background
            Stack(
              children: [
                // Yellow and black striped background with border
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        // Color(0xFFFFD700), // Yellow
                        // Color(0xFF000000), // Black
                      ],
                      stops: [0.5, 0.5],
                      tileMode: TileMode.repeated,
                      transform: GradientRotation(45 * 3.14159 / 180), // 45 degrees
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    // border: Border.all(
                    //   color: const Color(0xFFFFD700), // Yellow border
                    //   width: 2,
                    // ),
                  ),
                ),
                // Header content with border
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xCC1A1A1A), // Semi-transparent dark background
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    // border: Border.all(
                    //   color: const Color(0xFFFFD700), // Yellow border
                    //   width: 1,
                    // ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PATIENT INFORMATION',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Patient ID with keyboard
            _buildFormField(
              'Patient ID :',
              patientIdController,
              enabled: false,
              onTap: () => _showKeyboardPopup(patientIdController, 'Patient ID'),
            ),

            // Patient Name with keyboard
            _buildFormField(
              'Patient Name:',
              patientNameController,
              enabled: false,
              onTap: () => _showKeyboardPopup(patientNameController, 'Patient Name'),
            ),
            
            // Gender dropdown
            _buildDropdownField(
              'Gender :',
              selectedGender,
              ['Female', 'Male', 'Other'],
              (String? value) {
                if (value != null) {
                  setState(() => selectedGender = value);
                }
              },
            ),

            // Date of Birth field with adjusted dropdown size
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    'DOB :',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                // DOB field with flex: 2
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      // DOB input field
                      SizedBox(
                        width: 120,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2C2C),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextField(
                            controller: TextEditingController(text: '45'),
                            enabled: false,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            onTap: () async {
                              await showDialog<String>(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Stack(
                                  children: [
                                    Positioned(
                                      top: 150,
                                      left: 300,
                                      child: NumericKeypad(
                                        initialValue: '45',
                                        onValueChanged: (value) {
                                          setState(() {
                                            // Update DOB value
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Dropdown with exact Kgs box size
                      SizedBox(
                        width: 80, // Adjusted width to match Kgs box exactly
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2C2C),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedTimeUnit,
                              dropdownColor: const Color(0xFF2C2C2C),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                                size: 20, // Smaller icon size
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14, // Adjusted font size
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8), // Reduced padding
                              isExpanded: true,
                              items: ['Days', 'Months', 'Years']
                                  .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(fontSize: 14), // Consistent font size
                                      ),
                                    );
                                  })
                                  .toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedTimeUnit = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add Expanded for the empty space (matches weight/height layout)
                const Expanded(child: SizedBox()),
              ],
            ),

            // Weight field with numeric keypad
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildFormField(
                    'Weight :',
                    weightController,
                    enabled: false,
                    onTap: () async {
                      await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Stack(
                          children: [
                            Positioned(
                              top: 150,
                              left: 300,
                              child: NumericKeypad(
                                initialValue: weightController.text,
                                onValueChanged: (value) {
                                  setState(() {
                                    weightController.text = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDropdownField(
                    '',
                    selectedWeightUnit,
                    ['Kgs', 'lbs'],
                    (String? value) {
                      if (value != null) {
                        setState(() => selectedWeightUnit = value);
                      }
                    },
                  ),
                ),
              ],
            ),

            // Height field with numeric keypad
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildFormField(
                    'Height :',
                    heightController,
                    enabled: false,
                    onTap: () async {
                      await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Stack(
                          children: [
                            Positioned(
                              top: 150,
                              left: 300,
                              child: NumericKeypad(
                                initialValue: heightController.text,
                                onValueChanged: (value) {
                                  setState(() {
                                    heightController.text = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDropdownField(
                    '',
                    selectedHeightUnit,
                    ['cm', 'ft'],
                    (String? value) {
                      if (value != null) {
                        setState(() => selectedHeightUnit = value);
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Save Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF559690),
                  minimumSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller, {
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: controller,
                  enabled: enabled && onTap == null,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (label.isNotEmpty)
            SizedBox(
              width: 120,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF2C2C2C),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 