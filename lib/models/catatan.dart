import 'dart:convert';

class Catatan {
  String id;
  String tanggal;
  String tipeTransaksi;
  String kategori;
  int jumlah;
  String catatan;

  Catatan({
    required this.id,
    required this.tanggal,
    required this.tipeTransaksi,
    required this.kategori,
    required this.jumlah,
    required this.catatan,
  });

  factory Catatan.fromJson(Map<String, dynamic> json) {
    return Catatan(
      id: json['id'],
      tanggal: json['tanggal'],
      tipeTransaksi: json['tipeTransaksi'],
      kategori: json['kategori'],
      jumlah: json['jumlah'],
      catatan: json['catatan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tanggal': tanggal,
      'tipeTransaksi': tipeTransaksi,
      'kategori': kategori,
      'jumlah': jumlah,
      'catatan': catatan,
    };
  }

  static List<Catatan> decode(String jsonString) {
    if (jsonString.isEmpty) {
      return []; // Return an empty list when jsonString is empty
    }

    List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((item) => Catatan.fromJson(item)).toList();
  }

  static String encode(List<Catatan> transactions) => jsonEncode(
        transactions
            .map<Map<String, dynamic>>((Catatan item) => item.toJson())
            .toList(),
      );
}
