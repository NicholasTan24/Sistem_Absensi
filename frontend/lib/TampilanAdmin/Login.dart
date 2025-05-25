import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfac278),
      body: Center(
        child: SizedBox(
            width: 300,
            height: 400,
            child: Card(
              elevation: 10,
              child: Column(
                  children: [
              Padding(
              padding: EdgeInsets.all(23),
              child: Text('Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Divider(thickness: 2, color: Colors.black),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  children: [
              TextField(
              decoration: InputDecoration(
              filled: true, labelText: 'Masukkan ID'),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                  filled: true, labelText: 'Masukkan Password'),
            ),
            SizedBox(height: 40),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xffe4ebdd)),
              onPressed: () {
                Navigator.pushNamed(
                    context,'/dashboard');
              },
              child: Text('Login'),
            ),
            SizedBox(height: 30),
            RichText(
                text: TextSpan(
                  text: 'Belum Ada ID?',
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Daftar di sini.',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/register');
                        },
                    ),
                  ],
                )),
        ],
      ),
    )],
    ),
    ),
    ),
    ));
  }
}
