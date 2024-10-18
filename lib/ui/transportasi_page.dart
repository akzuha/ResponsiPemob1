import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/transportasi_bloc.dart';
import '/model/transportasi.dart';
import '/ui/transportasi_detail.dart';
import '/ui/transportasi_form.dart';
import 'login_page.dart';

class TransportasiPage extends StatefulWidget {
  const TransportasiPage({Key? key}) : super(key: key);

  @override
  _TransportasiPageState createState() => _TransportasiPageState();
}

class _TransportasiPageState extends State<TransportasiPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Transportasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light, // Tema terang
        primaryColor: Colors.yellow, // Warna utama kuning
        fontFamily: 'Helvetica', // Font Helvetica
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow, // Warna AppBar kuning
          foregroundColor: Colors.black, // Warna teks hitam di AppBar
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Warna teks tombol hitam
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Warna teks body hitam
          bodyMedium: TextStyle(color: Colors.black), // Warna teks body hitam
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('List Transportasi'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TransportasiForm()));
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Logout'),
                trailing: const Icon(Icons.logout),
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                      });
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder<List>(
          future: TransportasiBloc.getTransportasis(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListTransportasi(list: snapshot.data)
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ListTransportasi extends StatelessWidget {
  final List? list;

  const ListTransportasi({super.key, this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemTransportasi(transportasi: list![i]);
        });
  }
}

class ItemTransportasi extends StatelessWidget {
  final Transportasi transportasi;

  const ItemTransportasi({Key? key, required this.transportasi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransportasiDetail(
                      transportasi: transportasi,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(transportasi.vehicle!),
          subtitle: Text(transportasi.capacity.toString()),
          trailing: Text(transportasi.company!),
        ),
      ),
    );
  }
}
