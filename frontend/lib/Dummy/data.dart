import 'package:shared_preferences/shared_preferences.dart';

import 'dummy_data.dart';
import 'package:encrypt/encrypt.dart'as encrypt;

final List<Karyawan> dummyKaryawan = [
  Karyawan(
    idKaryawan: "001",
    namaKaryawan: "Agus Santoso",
    email: "agus@example.com",
    nomorTelepon: "081234567890",
    jabatan: "Admin",
    status: "aktif",
    password: "Agus@123",
  ),
  Karyawan(
    idKaryawan: "002",
    namaKaryawan: "Dina Rahma",
    email: "dina@example.com",
    nomorTelepon: "082345678901",
    jabatan: "Staf Gudang",
    status: "aktif",
    password: "Dina#321",
  ),
  Karyawan(
    idKaryawan: "003",
    namaKaryawan: "Rudi Hartono",
    email: "rudi@example.com",
    nomorTelepon: "083456789012",
    jabatan: "Sales",
    status: "aktif",
    password: "Rudi!789",
  ),
  Karyawan(
    idKaryawan: "004",
    namaKaryawan: "Siti Aisyah",
    email: "siti@example.com",
    nomorTelepon: "084567890123",
    jabatan: "Kasir",
    status: "aktif",
    password: "Siti!456",
  ),
  Karyawan(
    idKaryawan: "005",
    namaKaryawan: "Budi Prasetyo",
    email: "budi@example.com",
    nomorTelepon: "085678901234",
    jabatan: "Staf Gudang",
    status: "aktif",
    password: "Budi@2023",
  ),
  Karyawan(
    idKaryawan: "006",
    namaKaryawan: "Nina Lestari",
    email: "nina@example.com",
    nomorTelepon: "086789012345",
    jabatan: "Sales",
    status: "aktif",
    password: "Nina#998",
  ),
  Karyawan(
    idKaryawan: "007",
    namaKaryawan: "Andi Wijaya",
    email: "andi@example.com",
    nomorTelepon: "087890123456",
    jabatan: "Kasir",
    status: "aktif",
    password: "Andi!001",
  ),
  Karyawan(
    idKaryawan: "008",
    namaKaryawan: "Mega Putri",
    email: "mega@example.com",
    nomorTelepon: "088901234567",
    jabatan: "Staf Gudang",
    status: "aktif",
    password: "Mega@cs1",
  ),
  Karyawan(
    idKaryawan: "009",
    namaKaryawan: "Fajar Nugroho",
    email: "fajar@example.com",
    nomorTelepon: "089012345678",
    jabatan: "Sales",
    status: "aktif",
    password: "Fajar#dev9",
  ),
  Karyawan(
    idKaryawan: "010",
    namaKaryawan: "Lina Maulida",
    email: "lina@example.com",
    nomorTelepon: "081112223333",
    jabatan: "Sales",
    status: "aktif",
    password: "Lina!2024",
  ),

];

Future<List<Karyawan>> loadKaryawanFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getString('idKaryawan');
  final nama = prefs.getString('namaKaryawan');
  final email = prefs.getString('email');
  final telp = prefs.getString('nomorTelepon');
  final jabatan = prefs.getString('jabatan');
  final status = prefs.getString('status');
  final password = prefs.getString('password');
  final keyStr = prefs.getString('key');
  final ivStr = prefs.getString('iv');

  if ([id, nama, email, telp, jabatan, status, password, keyStr, ivStr].contains(null)) {
    return dummyKaryawan;
  }

  final key = encrypt.Key.fromBase64(keyStr!);
  final iv = encrypt.IV.fromBase64(ivStr!);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  final decryptedNama = encrypter.decrypt64(nama!, iv: iv);
  final decryptedPassword = encrypter.decrypt64(password!, iv: iv);

  final newKaryawan = Karyawan(
    idKaryawan: id!,
    namaKaryawan: decryptedNama,
    email: email!,
    nomorTelepon: telp!,
    jabatan: jabatan!,
    status: status!,
    password: decryptedPassword,
  );

  final isExist = dummyKaryawan.any((k) => k.idKaryawan == id);
  return isExist ? dummyKaryawan : [...dummyKaryawan, newKaryawan];

}
