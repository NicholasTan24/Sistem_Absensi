import 'package:flutter/material.dart';
import '../Drawer/Mydrawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Color(0xffffa44f),
          title: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(children: [
              Text('Dashboard',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold)
              ),
              Spacer(),
              Icon(Icons.qr_code_2, size: 50),
            ]),
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Row(
        children: [],
      ),
    );
  }
}
