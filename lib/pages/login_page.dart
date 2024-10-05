import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:front_end_order/pages/dashboard_page.dart';
import 'package:front_end_order/api_path.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true;
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isError = false;
  bool isLoading = false;
  final storage = const FlutterSecureStorage();

  submitLogin() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      setState(() {
        isLoading = true;
        isError = false;
      });

      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('${ApiPath.BASE_URL}login'));
      request.body = json.encode(
        {
          "username": usernameCtrl.text,
          "password": passwordCtrl.text,
        },
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var dataJson = json.decode(data);
        if (dataJson['success']) {
          storage.write(key: 'username', value: usernameCtrl.text);
          storage.write(key: 'password', value: passwordCtrl.text);
          storage.write(key: 'token', value: dataJson['data']['token']);
          storage.write(key: 'image', value: dataJson['data']['image']);
          log('login ok == ${data}');

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPage(),
              ),
              (route) => false);
        }
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Form(
          key: formkey,
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 50,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(40),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                              alignment: Alignment.center,
                              child: Text('Login',
                                  style: TextStyle(fontSize: 30))),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Username'),
                          TextFormField(
                            controller: usernameCtrl,
                            decoration: InputDecoration(
                              hintText: "Username",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              prefixIcon: const Icon(Icons.person),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter Username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Password'),
                          TextFormField(
                            controller: passwordCtrl,
                            obscureText: showPassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: showPassword
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Builder(builder: (context) {
                            if (isError) {
                              return const Text(
                                'Username or password incorrect',
                                style: TextStyle(color: Colors.red),
                              );
                            }
                            return Container();
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () async {
                                  submitLogin();
                                },
                                child: isLoading
                                    ? CircularProgressIndicator()
                                    : Text('Login')),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Version:1.0.0',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'CopyRight 2024. All reserved',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
