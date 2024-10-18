import 'package:flutter/material.dart';
import '../bloc/transportasi_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/transportasi.dart';
import '/ui/transportasi_form.dart';
import 'transportasi_page.dart';

// ignore: must_be_immutable
class TransportasiDetail extends StatefulWidget {
  Transportasi? transportasi;

  TransportasiDetail({super.key, this.transportasi});

  @override
  _TransportasiDetailState createState() => _TransportasiDetailState();
}

class _TransportasiDetailState extends State<TransportasiDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail Transportasi',
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
          title: const Text('Detail Transportasi'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                "Kode : ${widget.transportasi!.jenisTransportasi}",
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(
                "Nama : ${widget.transportasi!.perusahaanTransportasi}",
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                "Harga : Rp. ${widget.transportasi!.kapasitasTransportasi}",
                style: const TextStyle(fontSize: 18.0),
              ),
              _tombolHapusEdit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Warna background tombol kuning
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransportasiForm(
                  transportasi: widget.transportasi!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 8.0), // Menambah jarak antara tombol
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Warna background tombol kuning
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Warna background tombol kuning
          ),
          onPressed: () {
            TransportasiBloc.deleteTransportasi(id: widget.transportasi!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TransportasiPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Warna background tombol kuning
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
