import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/transportasi.dart';

class TransportasiBloc {
  static Future<List<Transportasi>> getTransportasis() async {
    String apiUrl = ApiUrl.listTransportasi;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTransportasi = (jsonObj as Map<String, dynamic>)['data'];
    List<Transportasi> transportasis = [];
    for (var transportasis in listTransportasi) {
      transportasis.add(Transportasi.fromJson(transportasis));
    }
    return transportasis;
  }

  static Future addTransportasi({Transportasi? transportasi}) async {
    String apiUrl = ApiUrl.createTransportasi;

    var body = {
      "jenis_kendaraan": transportasi!.vehicle,
      "perusahaan_kendaraan": transportasi.company,
      "kapasitas": transportasi.capacity.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateTransportasi({required Transportasi transportasi}) async {
    String apiUrl = ApiUrl.updateTransportasi(transportasi.id!);
    print(apiUrl);

    var body = {
      "jenis_kendaraan": transportasi.vehicle,
      "perusahaan_kendaraan": transportasi.company,
      "kapasitas": transportasi.capacity
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteTransportasi({int? id}) async {
    String apiUrl = ApiUrl.deleteTransportasi(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
