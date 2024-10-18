import 'package:flutter/material.dart';
import '/helpers/user_info.dart';
import '/ui/login_page.dart';
import 'ui/transportasi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const TransportasiPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Pariwisata',
      debugShowCheckedModeBanner: false,
      home: page,
      theme: ThemeData(
        // Menggunakan warna utama kuning untuk tema terang
        brightness: Brightness.light,
        primaryColor: Colors.yellow,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow, // Warna AppBar
          foregroundColor: Colors.black, // Warna teks pada AppBar
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.yellow, // Warna FAB
          foregroundColor: Colors.black, // Warna icon FAB
        ),
        // Menggunakan font Helvetica
        fontFamily: 'Helvetica',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Warna teks umum
          bodyMedium: TextStyle(color: Colors.black), // Warna teks umum
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.yellow, // Warna tombol
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}
