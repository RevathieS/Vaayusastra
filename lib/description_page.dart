import 'package:flutter/material.dart';
import 'payment_options_page.dart'; // Import the PaymentOptionsPage widget
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class DescriptionPage extends StatelessWidget {
  final String level;
  final Color color;
  final String driveLink = 'https://drive.google.com/your-drive-link'; // Replace with your actual drive link

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
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                // Open the drive link when the button is pressed
                final Uri url = Uri.parse(driveLink);
                if (await canLaunch(url.toString())) {
                  await launch(url.toString());
                } else {
                  throw 'Could not launch $driveLink';
                }
              },
              child: const Text('Open Drive Link'),
            ),
          ],
        ),
      ),
    );
  }
}
