import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared preferences
import 'home_page.dart';
import 'register_page.dart'; // Import the register page
import 'splash_screen.dart'; // Import the splash screen file
import 'onboarding_screen.dart'; // Import the onboarding screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remove debug banner
    home: isFirstTime ? OnboardingScreen() : (isLoggedIn ? HomePage() : SplashScreen()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Example of setting a custom font
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.195:3000/login'), // Use your IP address
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        // Save logged in status
        _prefs.setBool('isLoggedIn', true);

        // Navigate to HomePage on successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Show an error message on login failure
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Invalid email or password'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in flow
        return;
      }

      // Get the authentication tokens
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // You can use googleAuth.idToken and googleAuth.accessToken for server-side authentication
      // Example: Send these tokens to your backend server for authentication

      // Save logged in status
      _prefs.setBool('isLoggedIn', true);

      // Navigate to the home page after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  void _signInWithEmailPassword() {
    // Validate email and password
    String email = _emailController.text;
    String password = _passwordController.text;

    // Perform login logic here (e.g., call API, validate credentials)
    // For simplicity, I'm just checking if both email and password are non-empty
    if (email.isNotEmpty && password.isNotEmpty) {
      // Start loading
      setState(() {
        _isLoading = true;
      });

      // Perform login operation here
      login();
    } else {
      // Show error message if email or password is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter valid email and password'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      backgroundColor: Color(0xFFF3F5F7), // Light gray background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: _signInWithEmailPassword,
                        child: Text('Login'),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _handleSignIn,
                        child: Text('Sign in using Google'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF3F5F7), // Background color
                        ),
                      ),
                      SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text('Don\'t have an account? Register'),
                      ),
                    ],
                  ),
          ],
        ),
),
);
}
}