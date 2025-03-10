import 'package:flutter/material.dart';

class VitalParameter {
  final String name;
  final String value;
  final String? unit;
  final String? subValue;
  final Color color;

  VitalParameter({
    required this.name,
    required this.value,
    this.unit,
    this.subValue,
    required this.color,
  });
}

class VitalParametersList extends StatefulWidget {
  const VitalParametersList({Key? key}) : super(key: key);

  @override
  State<VitalParametersList> createState() => _VitalParametersListState();
}

class _VitalParametersListState extends State<VitalParametersList> {
  late List<VitalParameter> parameters;

  @override
  void initState() {
    super.initState();
    parameters = [
      VitalParameter(
        name: 'HR',
        value: '64',
        unit: 'bpm',
        color: Colors.green,
      ),
      VitalParameter(
        name: 'NIBP',
        value: '124/84',
        subValue: '(97)',
        unit: 'mmHg',
        color: Colors.white,
      ),
      VitalParameter(
        name: 'RESP',
        value: '16',
        unit: '/min',
        color: Colors.blue,
      ),
      VitalParameter(
        name: 'SpO2',
        value: '76',
        subValue: 'PI 1.4 %',
        color: Colors.yellow,
      ),
      VitalParameter(
        name: 'TEMP',
        value: '37.2 °C   36.5 °C',
        color: Colors.cyan,
      ),
    ];
  }

  void _handleParameterTap(String paramName) {
    switch (paramName) {
      case 'HR':
        print('Heart Rate parameter tapped');
        // Add your HR tap handling logic here
        break;
      case 'NIBP':
        print('NIBP parameter tapped');
        // Add your NIBP tap handling logic here
        break;
      case 'RESP':
        print('Respiratory parameter tapped');
        // Add your RESP tap handling logic here
        break;
      case 'SpO2':
        print('SpO2 parameter tapped');
        // Add your SpO2 tap handling logic here
        break;
      case 'TEMP':
        print('Temperature parameter tapped');
        // Add your TEMP tap handling logic here
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: parameters.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = parameters.removeAt(oldIndex);
          parameters.insert(newIndex, item);
        });
      },
      itemBuilder: (context, index) {
        final param = parameters[index];
        return GestureDetector(
          key: ValueKey(param.name),
          onTap: () => _handleParameterTap(param.name),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: param.color,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        param.name,
                        style: TextStyle(
                          color: param.color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (param.name == 'NIBP')
                        Text(
                          '15:30',
                          style: TextStyle(
                            color: param.color,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        param.value,
                        style: TextStyle(
                          color: param.color,
                          fontSize: param.name == 'NIBP' ? 24 : 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (param.unit != null)
                        Text(
                          param.unit!,
                          style: TextStyle(
                            color: param.color,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                  if (param.subValue != null)
                    Text(
                      param.subValue!,
                      style: TextStyle(
                        color: param.color,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 