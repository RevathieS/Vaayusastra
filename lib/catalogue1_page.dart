import 'package:flutter/material.dart';
import 'description_page.dart'; // Import the DescriptionPage widget
import 'package:app/chatbot_page.dart'; // Import the ChatbotPage widget

class Catalogue1Page extends StatefulWidget {
  const Catalogue1Page({super.key});

  @override
  _Catalogue1PageState createState() => _Catalogue1PageState();
}

class _Catalogue1PageState extends State<Catalogue1Page> {
  Offset position = const Offset(100, 100); // Initial position for the draggable button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue 1 Page'),
      ),
      backgroundColor: Colors.grey[200], // Background color
      body: Stack(
        children: <Widget>[
          // Catalogue content here
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Level boxes
                _buildLevelBox('Level 1', Colors.blue),
                const SizedBox(height: 20),
                _buildLevelBox('Level 2', Colors.green),
                const SizedBox(height: 20),
                _buildLevelBox('Level 3', Colors.orange),
                const SizedBox(height: 20),
                _buildLevelBox('Level 4', Colors.red),
              ],
            ),
          ),
          // Positioned widget for draggable button
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              feedback: const FloatingActionButton(
                onPressed: null, // Disable onPressed during dragging
                child: Icon(Icons.chat),
              ),
              childWhenDragging: Container(), // Empty container when dragging
              onDragEnd: (dragDetails) {
                setState(() {
                  position = dragDetails.offset; // Update position after dragging
                });
              },
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to the ChatbotPageScreen when button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatbotPageScreen()),
                  );
                },
                child: const Icon(Icons.chat),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelBox(String text, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescriptionPage(level: text, color: color),
          ),
        );
      },
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatbotPageScreen extends StatelessWidget {
  const ChatbotPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: const ChatbotPage(),
    );
  }
}
