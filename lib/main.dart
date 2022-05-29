import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ColorProvider>.value(value: ColorProvider()),
        ],
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    ColorProvider state = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homework Provider',
          style: TextStyle(
            color: state.colorValueText,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<ColorProvider>(
              builder: (context, value, child) {
                return AnimatedContainer(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: state.colorValueBox,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  duration: const Duration(seconds: 1),
                );
              },
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(
                  () {
                    isSwitched = value;
                    state._colorUpgrade();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ColorProvider extends ChangeNotifier {
  final random = Random();
  Color _colorBox = Colors.green;
  Color _colorText = Colors.white;

  Color get colorValueBox => _colorBox;

  Color get colorValueText => _colorText;

  void _colorUpgrade() {
    _colorBox = Color.fromRGBO(
      random.nextInt(300),
      random.nextInt(300),
      random.nextInt(300),
      1,
    );
    _colorText = Color.fromRGBO(
      random.nextInt(300),
      random.nextInt(300),
      random.nextInt(300),
      1,
    );
    notifyListeners();
  }
}
