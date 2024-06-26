import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  void _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildPageContent(
                  backgroundColor: Colors.blue,
                  image: 'assets/splash.jpeg',
                  title: 'Welcome',
                  description: 'Welcome to Vaayusastra app. Let\'s get started!',
                ),
                _buildPageContent(
                  backgroundColor: Colors.green,
                  image: 'assets/splash2.jpeg',
                  title: 'App uses',
                  description: 'We offer various types of courses for different age groups.',
                ),
                _buildPageContent(
                  backgroundColor: Colors.orange,
                  image: 'assets/splash3.jpeg',
                  title: 'Discover More',
                  description: 'Explore various features and functionalities.',
                ),
              ],
            ),
          ),
          _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildPageContent({
    required Color backgroundColor,
    required String image,
    required String title,
    required String description,
  }) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          SizedBox(height: 32),
          Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 16),
          Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentPage == 2
              ? SizedBox()
              : TextButton(
                  onPressed: () {
                    _pageController.jumpToPage(2);
                  },
                  child: Text('SKIP'),
                ),
          Row(
            children: List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                ),
              );
            }),
          ),
          _currentPage == 2
              ? ElevatedButton(
                  onPressed: _completeOnboarding,
                  child: Text('START'),
                )
              : TextButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Text('NEXT'),
                ),
        ],
      ),
    );
  }
}
