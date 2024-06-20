import 'package:flutter/material.dart';
import 'payment_options_page.dart'; // Import the PaymentOptionsPage widget

class DescriptionPage extends StatelessWidget {
  final String level;
  final Color color;

  const DescriptionPage({super.key, required this.level, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$level Description'),
        backgroundColor: color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Details about $level',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the PaymentOptionsPage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentOptionsPage()),
                );
              },
              child: const Text('Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}
