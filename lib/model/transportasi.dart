class Transportasi {
  int? id;
  String? jenisTransportasi;
  String? perusahaanTransportasi;
  int? kapasitasTransportasi;
  Transportasi({this.id, this.jenisTransportasi, this.perusahaanTransportasi, this.kapasitasTransportasi});
  factory Transportasi.fromJson(Map<String, dynamic> obj) {
    return Transportasi(
        id: obj['id'],
        jenisTransportasi: obj['vehicle'],
        perusahaanTransportasi: obj['company'],
        kapasitasTransportasi: obj['capacity']);
  }
}
