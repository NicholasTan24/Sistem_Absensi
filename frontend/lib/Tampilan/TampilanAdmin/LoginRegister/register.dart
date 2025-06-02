import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController telpController = TextEditingController();

  bool _obscurePassword = true;
  String? selectedJabatan;
  bool status = true;
  final List<String> jabatanList = ['Admin', 'Staf Gudang', 'Sales', 'Kasir'];

  bool isPasswordStrong(String password) {
    final RegExp upper = RegExp(r'[A-Z]');
    final RegExp lower = RegExp(r'[a-z]');
    final RegExp symbol = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return password.length >= 8 &&
        upper.hasMatch(password) &&
        lower.hasMatch(password) &&
        symbol.hasMatch(password);
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    final id = idController.text.trim();
    final nama = namaController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final noTelp = telpController.text.trim();
    final jabatan = selectedJabatan ?? 'Tidak Diketahui';
    final statusStr = status ? 'aktif' : 'nonaktif';

    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encryptedNama = encrypter.encrypt(nama, iv: iv);
    final encryptedPassword = encrypter.encrypt(password, iv: iv);

    await prefs.setString('idKaryawan', id);
    await prefs.setString('namaKaryawan', encryptedNama.base64);
    await prefs.setString('email', email);
    await prefs.setString('nomorTelepon', noTelp);
    await prefs.setString('jabatan', jabatan);
    await prefs.setString('status', statusStr);
    await prefs.setString('password', encryptedPassword.base64);
    await prefs.setString('key', key.base64);
    await prefs.setString('iv', iv.base64);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pendaftaran berhasil')),
    );

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Karyawan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/', (route) => false),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID Karyawan'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                (value == null || value.isEmpty || !RegExp(r'^\d+$').hasMatch(value))
                    ? 'ID hanya boleh angka dan wajib diisi'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                (value == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                    ? 'Format email tidak valid'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
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
              const SizedBox(height: 16),
              TextFormField(
                controller: telpController,
                decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                (value == null || !RegExp(r'^\d+$').hasMatch(value))
                    ? 'Nomor hanya boleh angka'
                    : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedJabatan,
                decoration: const InputDecoration(labelText: 'Jabatan'),
                items: jabatanList
                    .map((jab) => DropdownMenuItem(
                  value: jab,
                  child: Text(jab),
                ))
                    .toList(),
                onChanged: (val) => setState(() => selectedJabatan = val),
                validator: (val) =>
                val == null ? 'Pilih salah satu jabatan' : null,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text("Status Aktif"),
                value: status,
                onChanged: (val) => setState(() => status = val),
              ),
              const SizedBox(height: 20),
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
