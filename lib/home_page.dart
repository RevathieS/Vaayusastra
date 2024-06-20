import 'package:flutter/material.dart';
import 'catalogue1_page.dart';
import 'catalogue2_page.dart';
import 'catalogue3_page.dart';
import 'catalogue4_page.dart';
import 'payment_options_page.dart';
import 'main.dart'; // Import the main.dart file to navigate to the LoginPage

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          // Home button (could navigate to the main home screen)
          _buildMenuButton('Home', Icons.home, context),

          // About Us button (could navigate to about us screen)
          _buildMenuButton('About Us', Icons.info, context),

          // Courses dropdown menu
          _buildCoursesMenu(context),

          // More dropdown menu
          _buildMoreMenu(context),

          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Implement logout logic and navigate back to LoginPage
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Home Page!',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF3F5F7), // Light gray background color
    );
  }

  // Helper method to build each menu item button
  Widget _buildMenuButton(String title, IconData icon, BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        // Implement navigation logic here
        switch (title) {
          case 'Home':
            // Navigate to home screen
            break;
          case 'About Us':
            // Navigate to about us screen
            break;
        }
      },
    );
  }

  // Helper method to build the Courses dropdown menu
  Widget _buildCoursesMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu),
      onSelected: (String value) {
        switch (value) {
          case 'Catalogue 1':
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Catalogue1Page()));
            break;
          case 'Catalogue 2':
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Catalogue2Page()));
            break;
          case 'Catalogue 3':
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Catalogue3Page()));
            break;
          case 'Catalogue 4':
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Catalogue4Page()));
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Catalogue 1',
          child: Text('Catalogue 1'),
        ),
        const PopupMenuItem<String>(
          value: 'Catalogue 2',
          child: Text('Catalogue 2'),
        ),
        const PopupMenuItem<String>(
          value: 'Catalogue 3',
          child: Text('Catalogue 3'),
        ),
        const PopupMenuItem<String>(
          value: 'Catalogue 4',
          child: Text('Catalogue 4'),
        ),
      ],
    );
  }

  // Helper method to build the More dropdown menu
  Widget _buildMoreMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (String value) {
        switch (value) {
          case 'Payment':
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentOptionsPage()));
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Payment',
          child: Text('Payment'),
        ),
     ],
);
}
}