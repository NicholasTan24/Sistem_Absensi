import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // buat decode JSON

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Fungsi untuk panggil API
  Future<void> fetchData() async {
    final url =
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1'); // contoh API
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Berhasil, parsing JSON
      final data = json.decode(response.body);
      print(data);
    } else {
      print('Failed to load data. Status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchData(); // panggil saat build (contoh)

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('API Call Example')),
        body: Center(child: Text('Cek console untuk hasil API')),
      ),
    );
  }
}
