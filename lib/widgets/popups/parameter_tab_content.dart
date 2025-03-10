import 'package:flutter/material.dart';

class ParameterTabContent extends StatefulWidget {
  const ParameterTabContent({Key? key}) : super(key: key);

  @override
  State<ParameterTabContent> createState() => _ParameterTabContentState();
}

class _ParameterTabContentState extends State<ParameterTabContent> {
  String parameter1 = 'HR';
  String parameter2 = 'Temp';
  String parameter3 = 'SpO₂';
  String parameter4 = 'Resp';
  String parameter5 = 'NIBP';
  String parameter6 = 'ST';

  OverlayEntry? _overlayEntry;

  void _showParameterSelection(BuildContext context, Offset position, String currentValue, Function(String) onSelect) {
    _overlayEntry?.remove();
    
    final List<String> options = [
      'HR',
      'Temp',
      'SpO₂',
      'Resp',
      'NIBP',
      'ST',
      'None',
    ];

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 180,
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
              children: options.map((option) => _buildParameterOption(
                option,
                currentValue,
                onSelect,
              )).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildParameterOption(String text, String currentValue, Function(String) onSelect) {
    final isSelected = text == currentValue;
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

  Widget _buildParameterDropdown(String label, String value, Function(String) onChanged) {
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
              _showParameterSelection(
                context,
                details.globalPosition,
                value,
                onChanged,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParameterDropdown('Parameter 1:', parameter1, (value) {
          setState(() => parameter1 = value);
        }),
        const SizedBox(height: 12),
        _buildParameterDropdown('Parameter 2:', parameter2, (value) {
          setState(() => parameter2 = value);
        }),
        const SizedBox(height: 12),
        _buildParameterDropdown('Parameter 3:', parameter3, (value) {
          setState(() => parameter3 = value);
        }),
        const SizedBox(height: 12),
        _buildParameterDropdown('Parameter 4:', parameter4, (value) {
          setState(() => parameter4 = value);
        }),
        const SizedBox(height: 12),
        _buildParameterDropdown('Parameter 5:', parameter5, (value) {
          setState(() => parameter5 = value);
        }),
        const SizedBox(height: 12),
        _buildParameterDropdown('Parameter 6:', parameter6, (value) {
          setState(() => parameter6 = value);
        }),
      ],
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
} 