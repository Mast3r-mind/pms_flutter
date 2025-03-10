import 'package:flutter/material.dart';

class PatientPopupComponent extends StatelessWidget {
  const PatientPopupComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.green].withOpacity(0.3),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Patient Details',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.green),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      'Patient Information',
                      {
                        'Patient ID': 'PAT001',
                        'Name': 'John Doe',
                        'Age': '45 years',
                        'Gender': 'Male',
                        'Blood Type': 'O+',
                        'Room': '301',
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      'Vital Signs',
                      {
                        'Heart Rate': '72 bpm',
                        'Blood Pressure': '120/80 mmHg',
                        'Temperature': '98.6°F',
                        'SpO2': '98%',
                        'Respiratory Rate': '16/min',
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      'Current Medication',
                      {
                        'Medicine 1': '10mg - Morning',
                        'Medicine 2': '5mg - Evening',
                        'Medicine 3': '15mg - Night',
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      'Recent Updates',
                      {
                        'Last Checkup': '2 hours ago',
                        'Next Checkup': 'In 4 hours',
                        'Status': 'Stable',
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Map<String, String> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: data.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        color: Colors.green.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      entry.value,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
} 