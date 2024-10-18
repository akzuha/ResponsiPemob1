class ApiUrl {
  static const String baseUrlAuth = 'http://103.196.155.42/api';

  static const String baseUrl = 'http://103.196.155.42/api/pariwisata';

  static const String registrasi = baseUrlAuth + '/registrasi';

  static const String login = baseUrlAuth + '/login';

  static const String createTransportasi = baseUrl + '/transportasi';

  static const String listTransportasi = baseUrl + '/transportasi';
  
  static String updateTransportasi(int id) {
    return baseUrl +
        '/transportasi/' +
        id.toString() + 
        '/update';
  }

  static String showTransportasi(int id) {
    return baseUrl +
        '/transportasi/' +
        id.toString();
  }

  static String deleteTransportasi(int id) {
    return baseUrl +
        '/transportasi/' +
        id.toString()+ 
        '/delete';
  }
}
