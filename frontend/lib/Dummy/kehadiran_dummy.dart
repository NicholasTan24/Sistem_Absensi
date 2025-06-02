import 'package:intl/intl.dart';

class dummyData {
  void tambahAbsensi(String nama, String status) {
    absensiHariIni.add({
      "tanggal": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "namaKaryawan": nama,
      "status": status,
    });
  }
  List<Map<String, dynamic>> absensiHariIni = [
    {
      "idKaryawan": "001",
      "namaKaryawan": "Agus Santoso",
      "status": "Hadir",
      "tanggal": DateFormat('yyyy-MM-dd').format(DateTime.now())
    },
    {
      "idKaryawan": "002",
      "namaKaryawan": "Dina Rahma",
      "status": "Hadir",
      "tanggal": DateFormat('yyyy-MM-dd').format(DateTime.now())
    },
    {
      "idKaryawan": "003",
      "namaKaryawan": "Rudi Hartono",
      "status": "Hadir",
      "tanggal": DateFormat('yyyy-MM-dd').format(DateTime.now())
    },
    {
      "idKaryawan": "004",
      "namaKaryawan": "Siti Aisyah",
      "status": "Izin",
      "tanggal": DateFormat('yyyy-MM-dd').format(DateTime.now())
    },
    {
      "idKaryawan": "005",
      "namaKaryawan": "Budi Prasetyo",
      "status": "Izin",
      "tanggal": DateFormat('yyyy-MM-dd').format(DateTime.now())
    }


  ];
  final List<Map<String, dynamic>> semuaKaryawan = [
    {
      "id_karyawan": "001",
      'nama_karyawan': 'Agus Santoso',
      'email': 'agus@example.com',
      'nomor_telepon': '081234567890',
      'jabatan': 'Admin',
      'status': 'aktif',
    },
    {
      'id_karyawan': '002',
      'nama_karyawan': 'Dina Rahma',
      'email': 'dina@example.com',
      'nomor_telepon': '082345678901',
      'jabatan': 'Staf Gudang',
      'status': 'aktif',
    },
    {
      'id_karyawan': '003',
      'nama_karyawan': 'Rudi Hartono',
      'email': 'rudi@example.com',
      'nomor_telepon': '083456789012',
      'jabatan': 'Sales',
      'status': 'aktif',
    },
    {
      'id_karyawan': '004',
      'nama_karyawan': 'Siti Aisyah',
      'email': 'siti@example.com',
      'nomor_telepon': '084567890123',
      'jabatan': 'Kasir',
      'status': 'aktif',
    },
    {
      'id_karyawan': '005',
      'nama_karyawan': 'Budi Prasetyo',
      'email': 'budi@example.com',
      'nomor_telepon': '085678901234',
      'jabatan': 'Staf Gudang',
      'status': 'aktif',
    },
    {
      'id_karyawan': '006',
      'nama_karyawan': 'Nina Lestari',
      'email': 'nina@example.com',
      'nomor_telepon': '086789012345',
      'jabatan': 'Sales',
      'status': 'aktif',
    },
    {
      'id_karyawan': '007',
      'nama_karyawan': 'Andi Wijaya',
      'email': 'andi@example.com',
      'nomor_telepon': '087890123456',
      'jabatan': 'Kasir',
      'status': 'aktif',
    },
    {
      'id_karyawan': '008',
      'nama_karyawan': 'Mega Putri',
      'email': 'mega@example.com',
      'nomor_telepon': '088901234567',
      'jabatan': 'Staf Gudang',
      'status': 'aktif',
    },
    {
      'id_karyawan': '009',
      'nama_karyawan': 'Fajar Nugroho',
      'email': 'fajar@example.com',
      'nomor_telepon': '089012345678',
      'jabatan': 'Sales',
      'status': 'aktif',
    },
    {
      'id_karyawan': '010',
      'nama_karyawan': 'Lina Maulida',
      'email': 'lina@example.com',
      'nomor_telepon': '081112223333',
      'jabatan': 'Sales',
      'status': 'aktif',
    }
  ];
}
