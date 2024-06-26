import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {'text': "Hi, How can I help you?", 'isUser': false},
  ];

  Map<String, String> responses = {
    "hi": "Hello! How can I help you?",
    "payment details": "You can pay using credit card, debit card or UPI payment.",
    "cost per course": "The cost per course varies. Please check our website for details.",
    "courses offered": "We offer a variety of courses like aeronautics, aerospace, summer camp.",
    "course duration": "The duration of each course varies from four to twelve weeks.",
    "class location": "Classes are conducted online.",
    "contact details": "You can contact through vaayusastra.com or 09360545176"
  };

  void sendMessage(String message) {
    setState(() {
      messages.insert(0, {'text': message, 'isUser': true});
      String response = getResponse(message);
      messages.insert(0, {'text': response, 'isUser': false});
    });
  }

  String getResponse(String message) {
    String response = "I'm sorry, I don't understand. Can you please rephrase?";
    responses.forEach((query, answer) {
      if (message.toLowerCase().contains(query)) {
        response = answer;
      }
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: messages[index]['isUser']
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: <Widget>[
                      _buildMessageContainer(messages[index]['text'], messages[index]['isUser']),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageContainer(String text, bool isUser) {
    return Container(
      decoration: BoxDecoration(
        color: isUser ? Colors.blueAccent : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Text(
        text,
        style: TextStyle(
          color: isUser ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type your message here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                sendMessage(_textController.text);
                _textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
