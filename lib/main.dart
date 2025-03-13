import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import './generated/myproto.pbgrpc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ClientChannel channel;
  late MyServiceClient stub;
  String message = "Waiting for updates...";
  String displayedMessage = "";

  @override
  void initState() {
    super.initState();
    initGrpc();
  }

  void initGrpc() async {
    channel = ClientChannel(
      'localhost', // Change this to the server IP if needed
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = MyServiceClient(channel);

    await for (var response in stub.streamData(MyRequest())) {
      animateMessage(response.message);
    }
  }

  void animateMessage(String fullMessage) async {
    setState(() {
      displayedMessage = "";
    });

    // Add a small delay before starting the animation
    await Future.delayed(Duration(milliseconds: 100));

    for (int i = 0; i <= fullMessage.length; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      setState(() {
        displayedMessage = fullMessage.substring(0, i);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter gRPC with C++ Server")),
        body: Center(
          child: Text(displayedMessage, style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.shutdown();
    super.dispose();
  }
}
