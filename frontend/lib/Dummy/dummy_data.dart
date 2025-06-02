class Karyawan {
  String idKaryawan;
  String namaKaryawan;
  String email;
  String nomorTelepon;
  String jabatan;
  String status;
  String _password;

  Karyawan({
    required this.idKaryawan,
    required this.namaKaryawan,
    required this.email,
    required this.nomorTelepon,
    required this.jabatan,
    required this.status,
    required String password,
  }) : _password = password;

  bool cekPassword(String input) => input == _password;
}
