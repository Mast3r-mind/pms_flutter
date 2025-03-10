class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _knobValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: KnobControl(
          value: _knobValue,
          min: 0.0,
          max: 1.0,
          color: Colors.blue,
          size: 100.0,
          onChanged: (value) {
            setState(() {
              _knobValue = value;
            });
            // Handle value change
            print('Knob value: $value');
          },
        ),
      ),
    );
  }
} 