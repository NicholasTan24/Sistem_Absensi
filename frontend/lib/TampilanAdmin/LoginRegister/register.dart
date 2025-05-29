import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController idKaryawanController = TextEditingController();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomorTeleponController = TextEditingController();

  bool _obscurePassword = true;

  String? selectedJabatan;
  bool status = false;
  bool isAdmin = false;

  final _formKey = GlobalKey<FormState>();

  final List<String> jabatanList = ['Admin', 'Gudang', 'SPG', 'Kasir'];

  bool isPasswordStrong(String password) {
    final RegExp upper = RegExp(r'[A-Z]');
    final RegExp lower = RegExp(r'[a-z]');
    final RegExp symbol = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return password.length >= 8 &&
        upper.hasMatch(password) &&
        lower.hasMatch(password) &&
        symbol.hasMatch(password);
  }

  int _getKodeJabatan(String? jabatan) {
    switch (jabatan) {
      case 'Admin': return 1;
      case 'Karyawan': return 2;
      case 'Gudang': return 3;
      case 'SPG': return 4;
      case 'Kasir': return 5;
      default: return 0;
    }
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'id_karyawan': idKaryawanController.text.trim(),
        'nama_karyawan': namaLengkapController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'nomor_telepon': nomorTeleponController.text.trim(),
        'kd_jabatan': _getKodeJabatan(selectedJabatan),
        'status': status ? 'aktif' : 'nonaktif',
        'role': selectedJabatan == 'Admin' ? 'admin' : 'karyawan',
      };


      final url = Uri.parse('http://127.0.0.1:8000/api/register');

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 201 && responseData['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registrasi berhasil')),
          );

          Navigator.pushReplacementNamed(context, '/');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? 'Registrasi gagal')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan jaringan')),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Karyawan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: idKaryawanController,
                decoration: const InputDecoration(labelText: 'ID Karyawan'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'ID hanya boleh angka';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: namaLengkapController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email wajib diisi';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (!isPasswordStrong(value)) {
                    return 'Gunakan huruf besar, kecil & simbol. Min 8 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: nomorTeleponController,
                decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Nomor hanya boleh angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedJabatan,
                decoration: const InputDecoration(labelText: 'Jabatan'),
                items: jabatanList
                    .map((jabatan) => DropdownMenuItem(
                  value: jabatan,
                  child: Text(jabatan),
                ))
                    .toList(),
                onChanged: (value) => setState(() => selectedJabatan = value),
                validator: (value) => value == null ? 'Pilih jabatan' : null,
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: const Text("Status Aktif"),
                value: status,
                onChanged: (val) => setState(() => status = val),
              ),
              const SizedBox(height:10),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
