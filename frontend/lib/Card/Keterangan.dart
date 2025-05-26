import 'package:flutter/material.dart';

class CardKehadiran extends StatelessWidget {
  const CardKehadiran({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 220,
            width: 200,
            child: Card(
              color: Color(0xffffddcf),
              margin: EdgeInsets.only(top: 20),
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(Icons.check_circle, color: Colors.green,
                    size: 70),
                  ),
                  SizedBox(height: 10),
                  Text('Hadir', style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold
                  ))
              ],
            ),
          ),
        ),
          SizedBox(width: 30),
          Container(
            height: 220,
            width: 200,
            child: Card(
              color: Color(0xffffddcf),
              margin: EdgeInsets.only(top: 20),
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(Icons.error, color: Color(0xfffc4c14),
                        size: 70),
                  ),
                  SizedBox(height: 10),
                  Text('Terlambat', style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold
                  ))
                ],
              ),
            ),
          ),
          SizedBox(width: 30),
          Container(
            height: 220,
            width: 200,
            child: Card(
              color: Color(0xffffddcf),
              margin: EdgeInsets.only(top: 20),
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(Icons.remove_circle, color: Color(0xffebaf57),
                        size: 70),
                  ),
                  SizedBox(height: 10),
                  Text('Izin', style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold
                  ))
                ],
              ),
            ),
          ),
          SizedBox(width: 30),
          Container(
            height: 220,
            width: 200,
            child: Card(
              color: Color(0xffffddcf),
              margin: EdgeInsets.only(top: 20),
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(Icons.cancel, color: Colors.redAccent,
                        size: 70),
                  ),
                  SizedBox(height: 10),
                  Text('Sakit', style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold
                  ))
                ],
              ),
            ),
          ),
        ]
    );
  }
}

