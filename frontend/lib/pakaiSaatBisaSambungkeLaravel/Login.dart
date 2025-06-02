// import 'dart:convert';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class Login extends StatefulWidget {
//   Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String? _globalError;
//   String? _idError;
//   String? _passwordError;
//   bool _obscurePassword = true;
//
//   Future<void> _login() async {
//     setState(() {
//       _globalError = null;
//       _idError = null;
//       _passwordError = null;
//       Navigator.pushNamed(context, '/dashboard');
//     });
//
//     final idKaryawan = _idController.text.trim();
//     final password = _passwordController.text;
//
//     bool hasError = false;
//
//     // Validasi kosong
//     if (idKaryawan.isEmpty) {
//       _idError = 'ID tidak boleh kosong';
//       hasError = true;
//     } else if (!RegExp(r'^\d+$').hasMatch(idKaryawan)) {
//       _idError = 'ID hanya boleh angka';
//       hasError = true;
//     }
//
//     if (password.isEmpty) {
//       _passwordError = 'Password tidak boleh kosong';
//       hasError = true;
//     } else if (password.length < 8) {
//       _passwordError = 'Password minimal 8 karakter';
//       hasError = true;
//     } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$').hasMatch(password)) {
//       _passwordError = 'Password harus kombinasi huruf kapital,angka,simbol';
//       hasError = true;
//     }
//
//     if (hasError) {
//       setState(() {});
//       return;
//     }
//
//
//
//     final url = Uri.parse('http://127.0.0.1:8000/api/login');
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'id_karyawan': idKaryawan,
//           'password': password,
//           'is_admin': false,
//         }),
//       );
//
//       final body = jsonDecode(response.body);
//       if (response.statusCode == 200 && body['status'] == true) {
//         Navigator.pushNamedAndRemoveUntil(
//             context, '/dashboard', (route) => false);
//       } else {
//         setState(() {
//           _globalError = body['message'] ?? 'Login gagal';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _globalError = 'Terjadi kesalahan jaringan';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFfac278),
//       body: Center(
//         child: SizedBox(
//           width: 350,
//           height: 470,
//           child: Card(
//             elevation: 10,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(23),
//                   child: Text('Login',
//                       textAlign: TextAlign.center,
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 ),
//                 Divider(thickness: 2, color: Colors.black),
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: EdgeInsets.all(15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextField(
//                         controller: _idController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           filled: true,
//                           labelText: 'Masukkan ID',
//                           errorText: _idError,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: _obscurePassword,
//                         decoration: InputDecoration(
//                           filled: true,
//                           labelText: 'Masukkan Password',
//                           errorText: _passwordError,
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       if (_globalError != null)
//                         Text(
//                           _globalError!,
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       SizedBox(height: 20),
//                       Center(
//                         child: TextButton(
//                           style: TextButton.styleFrom(
//                               backgroundColor: Color(0xffe4ebdd)),
//                           onPressed: _login,
//                           child: Text('Login'),
//                         ),
//                       ),
//                       SizedBox(height: 30),
//                       Center(
//                         child: RichText(
//                           text: TextSpan(
//                             text: 'Belum Ada ID?',
//                             style: TextStyle(color: Colors.black),
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: ' Daftar di sini.',
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                 ),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     Navigator.pushNamed(context, '/register');
//                                   },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
