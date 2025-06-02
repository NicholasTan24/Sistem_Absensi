import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../../../Dummy/data.dart';
import '../../../Dummy/dummy_data.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _globalError;
  String? _idError;
  String? _passwordError;
  bool _obscurePassword = true;

  void _login() async {
    final idKaryawan = _idController.text.trim();
    final password = _passwordController.text;

    bool hasError = false;
    _idError = null;
    _passwordError = null;
    _globalError = null;

    if (idKaryawan.isEmpty) {
      _idError = 'ID tidak boleh kosong';
      hasError = true;
    }

    if (password.isEmpty) {
      _passwordError = 'Password tidak boleh kosong';
      hasError = true;
    } else if (password.length < 8) {
      _passwordError = 'Password minimal 8 karakter';
      hasError = true;
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$')
        .hasMatch(password)) {
      _passwordError = 'Password harus ada huruf besar, angka, dan simbol';
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    // Coba cari dari dummyKaryawan dulu
    Karyawan? user;
    try {
      user = dummyKaryawan.firstWhere(
        (karyawan) =>
            karyawan.idKaryawan == idKaryawan && karyawan.cekPassword(password),
      );
    } catch (e) {
      user = null;
    }

    if (user != null) {
      print('Login sukses dari dummy sebagai ${user.namaKaryawan}');
      _navigateBasedOnRole(user.jabatan);
      return;
    }

    // Coba cek dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString('idKaryawan');
    final savedEncryptedPassword = prefs.getString('password');
    final savedKey = prefs.getString('key');
    final savedIv = prefs.getString('iv');

    if (savedId == idKaryawan && savedEncryptedPassword != null) {
      final key = encrypt.Key.fromBase64(savedKey ?? '');
      final iv = encrypt.IV.fromBase64(savedIv ?? '');
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      try {
        final decryptedPassword =
            encrypter.decrypt64(savedEncryptedPassword, iv: iv);

        if (password == decryptedPassword) {
          final nama = encrypter
              .decrypt64(prefs.getString('namaKaryawan') ?? '', iv: iv);
          final jabatan = prefs.getString('jabatan') ?? 'karyawan';

          print('Login sukses dari SharedPreferences sebagai $nama');
          _navigateBasedOnRole(jabatan);
          return;
        }
      } catch (e) {
        // error saat dekripsi atau cocokkan password
      }
    }

    setState(() {
      _passwordError = 'ID atau password salah';
    });
  }

  void _navigateBasedOnRole(String jabatan) {
    if (jabatan.toLowerCase() == 'admin') {
      Navigator.pushNamedAndRemoveUntil(
          context, '/dashboard', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/karyawan', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfac278),
      body: Center(
        child: SizedBox(
          width: 350,
          height: 470,
          child: Card(
            elevation: 10,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(23),
                  child: Text('Login',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Divider(thickness: 2, color: Colors.black),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _idController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Masukkan ID',
                          errorText: _idError,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Masukkan Password',
                          errorText: _passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_globalError != null)
                        Text(
                          _globalError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: const Color(0xffe4ebdd)),
                          onPressed: _login,
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Belum Ada ID?',
                            style: const TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Daftar di sini.',
                                style: const TextStyle(
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/register', (route) => false);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
