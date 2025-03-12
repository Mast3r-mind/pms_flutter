import 'package:flutter/material.dart';
import 'dart:io'; // Required for exit(0)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Touch Test App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Touch Test Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int rows = 15;
  static const int columns = 20;
  List<List<Color>> gridColors = List.generate(
    rows,
    (_) => List.generate(columns, (_) => Colors.white),
  );
  int exitCellTapCount = 0;

  void _onCellTap(int row, int col) {
    setState(() {
      if (row == rows - 1 && col == columns - 1) {
        exitCellTapCount++;
        if (exitCellTapCount == 2) {
          exit(0); // Close the app after two taps on the bottom-right cell
        }
      } else {
        gridColors[row][col] =
            gridColors[row][col] == Colors.green ? Colors.red : Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double cellWidth = screenWidth / columns;
    double cellHeight = screenHeight / rows;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView( // Allows scrolling if needed
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(rows, (row) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(columns, (col) {
                  return GestureDetector(
                    onTap: () => _onCellTap(row, col),
                    child: Container(
                      width: cellWidth - 2,  // Adjusting for margin
                      height: cellHeight - 2, // Adjusting for margin
                      margin: const EdgeInsets.all(1),
                      color: gridColors[row][col],
                      child: (row == rows - 1 && col == columns - 1)
                          ? const Center(child: Text('Exit'))
                          : null,
                    ),
                  );
                }),
              );
            }),
          ),
        ),
      ),
    );
  }
}
