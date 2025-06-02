import 'package:flutter/material.dart';
import 'package:frontend/Dummy/data.dart';
import 'package:frontend/Dummy/dummy_data.dart';

class EditPage extends StatefulWidget {
  final void Function() onUpdated;

  const EditPage({super.key, required this.onUpdated});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Karyawan? selectedKaryawan;

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _teleponController = TextEditingController();
  final _jabatanController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _teleponController.dispose();
    _jabatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Karyawan"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton<Karyawan>(
              hint: const Text("Pilih Karyawan"),
              isExpanded: true,
              value: selectedKaryawan,
              items: dummyKaryawan.map((k) {
                return DropdownMenuItem(
                  value: k,
                  child: Text(k.namaKaryawan),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedKaryawan = value;
                    _namaController.text = value.namaKaryawan;
                    _emailController.text = value.email;
                    _teleponController.text = value.nomorTelepon;
                    _jabatanController.text = value.jabatan;
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _teleponController,
              decoration: const InputDecoration(labelText: 'Telepon'),
            ),
            DropdownButtonFormField<String>(
              value: _jabatanController.text.isNotEmpty
                  ? _jabatanController.text
                  : null,
              items: const [
                DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                DropdownMenuItem(
                    value: 'Staf Gudang', child: Text('Staf Gudang')),
                DropdownMenuItem(value: 'Sales', child: Text('Sales')),
                DropdownMenuItem(value: 'Kasir', child: Text('Kasir')),
              ],
              onChanged: (value) {
                setState(() {
                  _jabatanController.text = value ?? '';
                });
              },
              decoration: const InputDecoration(labelText: 'Jabatan'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedKaryawan != null) {
              setState(() {
                selectedKaryawan!.namaKaryawan = _namaController.text;
                selectedKaryawan!.email = _emailController.text;
                selectedKaryawan!.nomorTelepon = _teleponController.text;
                selectedKaryawan!.jabatan = _jabatanController.text;
              });
              widget.onUpdated();
              Navigator.pop(context);
            }
          },
          child: const Text("Simpan"),
        ),
      ],
    );
  }
}
