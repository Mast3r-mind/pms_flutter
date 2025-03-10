import 'package:flutter/material.dart';
import '../widgets/animated_ecg_waveform.dart';
import '../widgets/popups/patient_details_popup.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Normal Sinus Rhythm
              AnimatedECGWaveform(
                color: Colors.green,
                height: 120,
                title: 'Lead I - Normal Sinus',
                waveformType: WaveformType.normal,
              ),
              
              const SizedBox(height: 20),
              
              // Tachycardia
              AnimatedECGWaveform(
                color: Colors.green,
                height: 120,
                title: 'Lead II - Tachycardia',
                waveformType: WaveformType.tachycardia,
              ),
              
              const SizedBox(height: 20),
              
              // Bradycardia
              AnimatedECGWaveform(
                color: Colors.green,
                height: 120,
                title: 'Lead III - Bradycardia',
                waveformType: WaveformType.bradycardia,
              ),
              
              const SizedBox(height: 20),
              
              // Atrial Fibrillation
              AnimatedECGWaveform(
                color: Colors.green,
                height: 120,
                title: 'aVR - Atrial Fibrillation',
                waveformType: WaveformType.atrialFibrillation,
              ),
              
              const SizedBox(height: 20),
              
              // Ventricular Tachycardia
              AnimatedECGWaveform(
                color: Colors.green,
                height: 120,
                title: 'aVL - V-Tach',
                waveformType: WaveformType.ventricularTachycardia,
              ),
              
              const SizedBox(height: 20),
              
              // ST Elevation
              AnimatedECGWaveform(
                color: Colors.green,
                height: 120,
                title: 'aVF - ST Elevation',
                waveformType: WaveformType.stElevation,
              ),
              
              const SizedBox(height: 20),
              
              // Heart Block
              AnimatedECGWaveform(
                color: Colors.green,
                height: 120,
                title: 'V1 - Heart Block',
                waveformType: WaveformType.heartBlock,
              ),
              
              const SizedBox(height: 20),

              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const PatientDetailsPopup(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 