import 'package:flutter/material.dart';
import 'ecg_tab_content.dart';
import 'parameter_tab_content.dart';

class ViewsPopup extends StatefulWidget {
  const ViewsPopup({Key? key}) : super(key: key);

  @override
  State<ViewsPopup> createState() => _ViewsPopupState();
}

class _ViewsPopupState extends State<ViewsPopup> {
  String selectedTab = 'Standard';
  String waveform1 = 'ECG II';
  String waveform2 = 'ECG III';
  String waveform3 = 'aVR';
  String waveform4 = 'Resp';
  String waveform5 = 'SpO₂';

  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF343434),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with dark background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'VIEWS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, color: Colors.white, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tab buttons with reduced size
                  Row(
                    children: [
                      Expanded(child: _buildTabButton('Standard')),
                      const SizedBox(width: 4),
                      Expanded(child: _buildTabButton('ECG')),
                      const SizedBox(width: 4),
                      Expanded(child: _buildTabButton('Parameter')),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Show content based on selected tab
                  _buildSelectedTabContent(),

                  const SizedBox(height: 32),
                  // Save button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006C58),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Save', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text) {
    final isSelected = selectedTab == text;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF006C58) : const Color(0xFF343434),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Color(0xFF006C58)),
        ),
      ),
      onPressed: () => setState(() => selectedTab = text),
      child: Text(text),
    );
  }

  Widget _buildWaveformDropdown(String label, String value, Function(String?) onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showECGSelection(
                context,
                details.globalPosition,
                (String newValue) {
                  onChanged(newValue);
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade800),
              ),
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showECGSelection(BuildContext context, Offset position, Function(String) onSelect) {
    _overlayEntry?.remove();
    
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 240,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: [
                _buildECGOption('ECG I', onSelect),
                _buildECGOption('ECG II', onSelect),
                _buildECGOption('ECG III', onSelect),
                _buildECGOption('aVR', onSelect),
                _buildECGOption('aVL', onSelect),
                _buildECGOption('aVF', onSelect),
                _buildECGOption('V', onSelect),
                _buildECGOption('RR', onSelect),
                _buildECGOption('SpO₂', onSelect),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildECGOption(String text, Function(String) onSelect) {
    final isSelected = text == waveform1;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onSelect(text);
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF006C58) : const Color(0xFF2A2A2A),
            border: Border.all(color: Colors.grey.shade800, width: 0.5),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  Widget _buildSelectedTabContent() {
    switch (selectedTab) {
      case 'ECG':
        return const ECGTabContent();
      case 'Standard':
        return _buildWaveformContent();
      case 'Parameter':
        return const ParameterTabContent();
      default:
        return Container();
    }
  }

  Widget _buildWaveformContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWaveformDropdown('Waveform 1:', waveform1, (value) {
          setState(() => waveform1 = value!);
        }),
        const SizedBox(height: 12),
        _buildWaveformDropdown('Waveform 2:', waveform2, (value) {
          setState(() => waveform2 = value!);
        }),
        const SizedBox(height: 12),
        _buildWaveformDropdown('Waveform 3:', waveform3, (value) {
          setState(() => waveform3 = value!);
        }),
        const SizedBox(height: 12),
        _buildWaveformDropdown('Waveform 4:', waveform4, (value) {
          setState(() => waveform4 = value!);
        }),
        const SizedBox(height: 12),
        _buildWaveformDropdown('Waveform 5:', waveform5, (value) {
          setState(() => waveform5 = value!);
        }),
      ],
    );
  }
} 