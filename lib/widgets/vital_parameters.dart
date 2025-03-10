class VitalParameters extends StatefulWidget {
  @override
  _VitalParametersState createState() => _VitalParametersState();
}

class _VitalParametersState extends State<VitalParameters> {
  // List to maintain order of parameters
  List<String> parameterOrder = ['HR', 'NIBP', 'RR', 'SpO2', 'Temp'];
  
  // Map to store expanded states
  Map<String, bool> expandedStates = {
    'HR': false,
    'NIBP': false,
    'RR': false,
    'SpO2': false,
    'Temp': false,
  };

  // Function to handle parameter swapping
  void swapParameters(String source, String target) {
    setState(() {
      final sourceIndex = parameterOrder.indexOf(source);
      final targetIndex = parameterOrder.indexOf(target);
      
      // Swap positions in the list
      parameterOrder[sourceIndex] = target;
      parameterOrder[targetIndex] = source;
    });
  }

  Widget _buildDraggableParameter(String parameter) {
    Map<String, Color> borderColors = {
      'HR': Colors.green,
      'NIBP': Colors.white,
      'RR': Colors.red,
      'SpO2': Colors.yellow,
      'Temp': Colors.cyan,
    };

    return Draggable<String>(
      data: parameter,
      child: DragTarget<String>(
        onWillAccept: (data) => data != parameter,
        onAccept: (data) => swapParameters(data, parameter),
        builder: (context, candidateData, rejectedData) {
          return Container(
            height: expandedStates[parameter]! ? 200 : 100,
            width: expandedStates[parameter]! ? double.infinity : MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Color(0xFF2C2C2C),
              border: Border.all(
                color: borderColors[parameter]!,
                width: 1,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // Reset all expanded states
                  expandedStates.forEach((key, value) {
                    expandedStates[key] = false;
                  });
                  // Toggle current parameter
                  expandedStates[parameter] = !expandedStates[parameter]!;
                });
              },
              child: _buildParameterContent(parameter),
            ),
          );
        },
      ),
      feedback: Material(
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            color: Color(0xFF2C2C2C).withOpacity(0.7),
            border: Border.all(
              color: borderColors[parameter]!,
              width: 1,
            ),
          ),
          child: _buildParameterContent(parameter),
        ),
      ),
      childWhenDragging: Container(
        height: 100,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: Color(0xFF2C2C2C).withOpacity(0.3),
          border: Border.all(
            color: borderColors[parameter]!.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildParameterContent(String parameter) {
    switch (parameter) {
      case 'HR':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('HR', style: TextStyle(color: Colors.green, fontSize: 16)),
            Text('60', style: TextStyle(color: Colors.green, fontSize: 48)),
            Text('bpm', style: TextStyle(color: Colors.green, fontSize: 16)),
          ],
        );
      case 'NIBP':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('NIBP', style: TextStyle(color: Colors.white, fontSize: 16)),
            Text('120/80', style: TextStyle(color: Colors.white, fontSize: 32)),
            Text('(93)', style: TextStyle(color: Colors.white, fontSize: 24)),
            Text('mmHg', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        );
      // Add similar cases for RR, SpO2, and Temp
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildDraggableParameter(parameterOrder[0])),
            if (!expandedStates.values.any((expanded) => expanded))
              Expanded(child: _buildDraggableParameter(parameterOrder[1])),
          ],
        ),
        if (!expandedStates.values.any((expanded) => expanded))
          Row(
            children: [
              Expanded(child: _buildDraggableParameter(parameterOrder[2])),
              Expanded(child: _buildDraggableParameter(parameterOrder[3])),
            ],
          ),
        if (!expandedStates.values.any((expanded) => expanded))
          _buildDraggableParameter(parameterOrder[4]),
      ],
    );
  }
} 