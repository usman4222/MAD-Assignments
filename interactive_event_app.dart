import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Event-Based App',
      home: InteractionScreen(),
    );
  }
}

class InteractionScreen extends StatefulWidget {
  @override
  _InteractionScreenState createState() => _InteractionScreenState();
}

class _InteractionScreenState extends State<InteractionScreen> {
  Color backgroundColor = Colors.white;
  final TextEditingController _controller = TextEditingController();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void changeBackground(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }

  void resetBackground() {
    setState(() {
      backgroundColor = Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text('Flutter Interaction Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Welcome to the Interactive App!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // TextField
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print('Live input: $value');
              },
              onSubmitted: (value) {
                print('Submitted: $value');
              },
            ),
            const SizedBox(height: 20),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => showSnackbar(context, 'Button Clicked'),
                  child: Text('Click Me'),
                ),
                ElevatedButton(
                  onLongPress: () => changeBackground(Colors.blue.shade100),
                  onPressed: () {}, // required for longPress to work
                  child: Text('Long Press Me'),
                ),
                ElevatedButton(
                  onPressed: resetBackground,
                  child: Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // GestureDetector Container
            GestureDetector(
              onTap: () {
                showSnackbar(context, 'Single Tap Detected');
              },
              onDoubleTap: () {
                showSnackbar(context, 'Double Tap Detected');
              },
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: Text(
                  'Tap or Double Tap Here',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
