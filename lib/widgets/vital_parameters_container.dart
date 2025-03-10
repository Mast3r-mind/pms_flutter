import 'package:flutter/material.dart';
import 'heart_rate_parameter.dart';
import 'resp_rate_component.dart';

class VitalParametersContainer extends StatefulWidget {
  const VitalParametersContainer({Key? key}) : super(key: key);

  @override
  State<VitalParametersContainer> createState() => _VitalParametersContainerState();
}

class _VitalParametersContainerState extends State<VitalParametersContainer> {
  late List<Widget> parameters;
  bool isSwapped = false;

  @override
  void initState() {
    super.initState();
    _initializeParameters();
  }

  void _initializeParameters() {
    parameters = [
      HeartRateParameter(
        value: '64',
        color: Colors.green,
        onTap: () => _handleTap('HR'),
      ),
      RespRateComponent(
        onTap: () => _handleTap('RESP'),
      ),
    ];
  }

  void _handleTap(String paramType) {
    if (paramType == 'HR' || paramType == 'RESP') {
      _swapParameters();
    }
  }

  void _swapParameters() {
    setState(() {
      final temp = parameters[0];
      parameters[0] = parameters[1];
      parameters[1] = temp;
      isSwapped = !isSwapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              GestureDetector(
                onLongPress: _swapParameters,
                child: parameters[0],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onLongPress: _swapParameters,
                child: parameters[1],
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: _swapParameters,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text(
            'Swap HR and RESP',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
} 