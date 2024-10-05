import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end_order/api_path.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_end_order/pages/dashboard_page.dart';
import 'package:front_end_order/pages/login_page.dart';
import 'package:http/http.dart' as http;

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    onInitData();
  }

  final storage = const FlutterSecureStorage();

  Future<void> onInitData() async {
    try {
      String? token = await storage.read(key: 'token');
      print(
          'Token: $token'); // Debugging line to check if token is read correctly

      if (token == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false,
        );
        return;
      }

      var headers = {
        'Authorization': 'Bearer $token'
      }; // Ensure Bearer keyword is used
      var request =
          http.Request('GET', Uri.parse(ApiPath.BASE_URL + 'validate-token'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(
          'Response status: ${response.statusCode}'); // Debugging line to check status code

      if (response.statusCode == 200) {
        var body = jsonDecode(await response.stream.bytesToString());
        print('Response body: $body'); // Debugging line to check response body

        if (body['success']) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardPage(),
            ),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (route) => false,
          );
        }
      } else {
        print(
            'Response reasonPhrase: ${response.reasonPhrase}'); // Debugging line for error message
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      print(
          'Error during token validation: $e'); // Debugging line for exception
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/shopingIcon.webp',
              width: 150,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors
                  .white), // Optional: Set a color for the progress indicator
            ),
          ],
        ),
      ),
    );
  }
}
