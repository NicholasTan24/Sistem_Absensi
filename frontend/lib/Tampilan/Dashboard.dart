import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Color(0xFFfac278)),
          height: 80,
          child: Row(
            children: [
              Drawer(
                  child: ListView(
                children: [Image.asset('BambinoLogo.jpeg')],
              )),
              Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text('Dashboard',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))
            ],
          )),
    );
  }
}
