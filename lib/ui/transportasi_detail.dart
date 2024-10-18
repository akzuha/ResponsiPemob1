import 'package:flutter/material.dart';
import '../bloc/transportasi_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/transportasi.dart';
import 'transportasi_form.dart';
import 'transportasi_page.dart'; // Mengimpor halaman TransportasiPage

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transportasi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Jenis : ${widget.transportasi!.vehicle}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Perusahaan : ${widget.transportasi!.company}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Kapasitas : ${widget.transportasi!.capacity}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit(),
            const SizedBox(height: 20), // Jarak antara tombol edit/hapus dan tombol kembali
            _tombolKembali(), // Tombol Kembali ke halaman transportasi
          ],
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
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  // Membuat Tombol Kembali ke TransportasiPage
  Widget _tombolKembali() {
    return OutlinedButton(
      child: const Text("Kembali ke Daftar Transportasi"),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TransportasiPage(), // Arahkan kembali ke halaman TransportasiPage
          ),
        );
      },
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
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
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
